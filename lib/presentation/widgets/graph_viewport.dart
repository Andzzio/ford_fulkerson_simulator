import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_mode_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/simulation_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/viewport_controller.dart';
import 'package:ford_fulkerson_simulator/presentation/painters/edges_painter.dart';
import 'package:ford_fulkerson_simulator/presentation/painters/min_cut_calculator.dart';
import 'package:ford_fulkerson_simulator/presentation/painters/viewport_painter.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/add_edge_dialog.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/add_node_dialog.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_info_badge.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/edge_hitbox_widget.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/edit_edge_dialog.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_mode.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/node_type_selector.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/node_widget.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/outlined_button_elevated.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/simulation_controls.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/simulation_history_tile.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/simulation_status.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/simulation_event.dart';

class GraphViewport extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<GraphViewport> createState() => _GraphViewportState();
}

class _GraphViewportState extends ConsumerState<GraphViewport>
    with SingleTickerProviderStateMixin {
  late final TransformationController _controller;
  late final AnimationController _animationController;
  Animation<Matrix4>? _animation;
  Size _viewportSize = Size.zero;

  @override
  void initState() {
    super.initState();
    const double initialScale = 1.0;
    _controller = TransformationController(
      Matrix4.identity()
        ..scaleByDouble(initialScale, initialScale, 1.0, 1.0)
        ..translateByDouble(-1100.0, -1200.0, 0.0, 1.0),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..addListener(() {
        if (_animation != null) {
          _controller.value = _animation!.value;
        }
      });
    final viewportController = ref.read(viewportControllerProvider);
    viewportController.onCenterGraph = _centerGraph;
    viewportController.onSetZoom = _setZoom;
  }

  @override
  void dispose() {
    final viewportController = ref.read(viewportControllerProvider);
    viewportController.onCenterGraph = null;
    viewportController.onSetZoom = null;
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(Matrix4 targetMatrix) {
    _animation = Matrix4Tween(
      begin: _controller.value,
      end: targetMatrix,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    _animationController.reset();
    _animationController.forward();
  }

  void _centerGraph() {
    final graphState = ref.read(graphStateNotifier);
    final nodes = graphState.nodes;
    final viewW = _viewportSize.width > 0 ? _viewportSize.width : 800.0;
    final viewH = _viewportSize.height > 0 ? _viewportSize.height : 600.0;

    Offset center;
    if (nodes.isEmpty) {
      center = const Offset(1500, 1500);
    } else {
      var minX = nodes.first.position.dx;
      var maxX = nodes.first.position.dx;
      var minY = nodes.first.position.dy;
      var maxY = nodes.first.position.dy;
      for (final n in nodes) {
        if (n.position.dx < minX) minX = n.position.dx;
        if (n.position.dx > maxX) maxX = n.position.dx;
        if (n.position.dy < minY) minY = n.position.dy;
        if (n.position.dy > maxY) maxY = n.position.dy;
      }
      center = Offset((minX + maxX) / 2, (minY + maxY) / 2);
    }

    final minScale = max(0.5, max(viewW / 3000.0, viewH / 3000.0));
    final currentScale =
        _controller.value.getMaxScaleOnAxis().clamp(minScale, 3.0);

    final rawTx = (viewW / 2) - (center.dx * currentScale);
    final rawTy = (viewH / 2) - (center.dy * currentScale);

    final minTx = viewW - (3000.0 * currentScale);
    final maxTx = 0.0;
    final targetTx = minTx < maxTx
        ? rawTx.clamp(minTx, maxTx)
        : (viewW - (3000.0 * currentScale)) / 2;

    final minTy = viewH - (3000.0 * currentScale);
    final maxTy = 0.0;
    final targetTy = minTy < maxTy
        ? rawTy.clamp(minTy, maxTy)
        : (viewH - (3000.0 * currentScale)) / 2;

    final targetMatrix = Matrix4.identity()
      ..translateByDouble(targetTx, targetTy, 0.0, 1.0)
      ..scaleByDouble(currentScale, currentScale, 1.0, 1.0);

    _animateTo(targetMatrix);
  }

  void _setZoom(double targetScale) {
    final viewW = _viewportSize.width > 0 ? _viewportSize.width : 800.0;
    final viewH = _viewportSize.height > 0 ? _viewportSize.height : 600.0;

    final minScale = max(0.5, max(viewW / 3000.0, viewH / 3000.0));
    final effectiveScale = targetScale.clamp(minScale, 3.0);

    final currentScale = _controller.value.getMaxScaleOnAxis();
    final currentTx = _controller.value.getTranslation().x;
    final currentTy = _controller.value.getTranslation().y;

    final centerCanvasX = (viewW / 2 - currentTx) / currentScale;
    final centerCanvasY = (viewH / 2 - currentTy) / currentScale;

    final rawTx = (viewW / 2) - (centerCanvasX * effectiveScale);
    final rawTy = (viewH / 2) - (centerCanvasY * effectiveScale);

    final minTx = viewW - (3000.0 * effectiveScale);
    final maxTx = 0.0;
    final targetTx = minTx < maxTx
        ? rawTx.clamp(minTx, maxTx)
        : (viewW - (3000.0 * effectiveScale)) / 2;

    final minTy = viewH - (3000.0 * effectiveScale);
    final maxTy = 0.0;
    final targetTy = minTy < maxTy
        ? rawTy.clamp(minTy, maxTy)
        : (viewH - (3000.0 * effectiveScale)) / 2;

    final targetMatrix = Matrix4.identity()
      ..translateByDouble(targetTx, targetTy, 0.0, 1.0)
      ..scaleByDouble(effectiveScale, effectiveScale, 1.0, 1.0);

    _animateTo(targetMatrix);
  }

  @override
  Widget build(BuildContext context) {
    final graphState = ref.watch(graphStateNotifier);
    final graphNotifier = ref.read(graphStateNotifier.notifier);
    final simulationState = ref.watch(simulationNotifier);
    final simulationStateNotifier = ref.read(simulationNotifier.notifier);
    final mode = ref.watch(graphModeNotifier);
    final modeNotifier = ref.read(graphModeNotifier.notifier);
    final edgeColors = simulationState.getEdgeColors(graphState.edges);
    final nodeBorderColors = simulationState.nodeBorderColors;
    Path? minCutPath;
    final currentEvent = simulationState.currentEvent;
    if (currentEvent is SimulationEvent_Finished) {
      final nodeMap = {for (final n in graphState.nodes) n.id: n.position};
      final sourceSet = currentEvent.minCutSourceNodes.toSet();
      final sinkSet = currentEvent.minCutSinkNodes.toSet();

      final sourcePositions = currentEvent.minCutSourceNodes
          .map((id) => nodeMap[id])
          .whereType<Offset>()
          .toList();
      final sinkPositions = currentEvent.minCutSinkNodes
          .map((id) => nodeMap[id])
          .whereType<Offset>()
          .toList();

      final sourceEdges = <(Offset, Offset)>[];
      final sinkEdges = <(Offset, Offset)>[];
      final cutEdges = <(Offset, Offset)>[];

      for (final edge in graphState.edges) {
        final pFrom = nodeMap[edge.core.from];
        final pTo = nodeMap[edge.core.to];
        if (pFrom == null || pTo == null) continue;

        if (sourceSet.contains(edge.core.from) &&
            sourceSet.contains(edge.core.to)) {
          sourceEdges.add((pFrom, pTo));
        } else if (sinkSet.contains(edge.core.from) &&
            sinkSet.contains(edge.core.to)) {
          sinkEdges.add((pFrom, pTo));
        } else if (sourceSet.contains(edge.core.from) &&
            sinkSet.contains(edge.core.to)) {
          cutEdges.add((pFrom, pTo));
        }
      }

      minCutPath = MinCutCalculator.computeMinCutPath(
        sourcePositions: sourcePositions,
        sinkPositions: sinkPositions,
        sourceEdges: sourceEdges,
        sinkEdges: sinkEdges,
        cutEdges: cutEdges,
      );
    }
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          _viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(8),
              border: Border.all(color: AppTheme.darkBorder, width: 2),
            ),
            child: Stack(
              children: [
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.zero,
                  transformationController: _controller,
                  minScale: 0.5,
                  maxScale: 3.0,
              constrained: false,
              panEnabled: mode == GraphMode.move,
              child: SizedBox(
                width: 3000,
                height: 3000,
                child: MouseRegion(
                  cursor: mode == GraphMode.add
                      ? (graphState.nodes.length >= 16
                            ? SystemMouseCursors.forbidden
                            : SystemMouseCursors.precise)
                      : SystemMouseCursors.basic,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapUp: (details) {
                      if (mode == GraphMode.add &&
                          !simulationStateNotifier.isSimulating) {
                        if (graphState.nodes.length >= 16) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Límite máximo de 16 nodos alcanzado',
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AddNodeDialog(position: details.localPosition),
                        );
                      } else if (mode == GraphMode.move) {
                        graphNotifier.unselectNode();
                      } else if (mode == GraphMode.join) {
                        graphNotifier.clearJoinSource();
                      }
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(painter: ViewportPainter()),
                        ),
                        Positioned.fill(
                          child: CustomPaint(
                            painter: EdgesPainter(
                              edges: graphState.edges,
                              edgeColors: edgeColors,
                              currentFlows: simulationState.currentFlows,
                              minCutPath: minCutPath,
                            ),
                          ),
                        ),
                        ...graphState.edges.map((edge) {
                          return EdgeHitboxWidget(
                            edge: edge,
                            mode: mode,
                            isSimulating: simulationStateNotifier.isSimulating,
                            onTap: () {
                              if (simulationStateNotifier.isSimulating) return;
                              if (mode == GraphMode.move) {
                                showDialog(
                                  context: context,
                                  builder: (_) => EditEdgeDialog(edge: edge),
                                );
                              } else if (mode == GraphMode.delete) {
                                graphNotifier.deleteEdge(edge.core.id);
                              }
                            },
                          );
                        }),
                        ...graphState.nodes.map((node) {
                          return Positioned(
                            left: node.position.dx - node.radius,
                            top: node.position.dy - node.radius,
                            child: NodeWidget(
                              node: node,
                              borderColor: nodeBorderColors[node.id],
                              onTap: simulationStateNotifier.isSimulating
                                  ? () {}
                                  : () {
                                      if (mode == GraphMode.move) {
                                        graphNotifier.selectNode(node);
                                      } else if (mode == GraphMode.delete) {
                                        graphNotifier.deleteNode(node.id);
                                      } else if (mode == GraphMode.join) {
                                        final source =
                                            graphState.joinSourceNode;
                                        if (source == null) {
                                          graphNotifier.selectJoinSource(node);
                                        } else if (source.id == node.id) {
                                          graphNotifier.clearJoinSource();
                                        } else {
                                          if (graphNotifier.hasEdge(
                                            source.id,
                                            node.id,
                                          )) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Ya existe una conexión directa de "${source.label}" hacia "${node.label}"',
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          if (graphNotifier.wouldCreateCycle(
                                            source.id,
                                            node.id,
                                          )) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'No se puede conectar: crearía un ciclo entre "${source.label}" y "${node.label}"',
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          showDialog(
                                            context: context,
                                            builder: (_) => AddEdgeDialog(
                                              from: source,
                                              to: node,
                                            ),
                                          );
                                        }
                                      }
                                    },
                              onPanUpdate:
                                  (simulationStateNotifier.isSimulating ||
                                      mode != GraphMode.move)
                                  ? null
                                  : (details) {
                                      graphNotifier.moveNode(
                                        node,
                                        details.delta,
                                      );
                                    },
                            ),
                          );
                        }),
                        ...graphState.nodes
                            .where(
                              (node) => node.core.nodeType == NodeType.sink,
                            )
                            .map((node) {
                              if (!simulationStateNotifier.isSimulating) {
                                return const SizedBox.shrink();
                              }
                              final sinkFlow = simulationState.getSinkFlow(
                                node.id,
                                graphState.edges,
                              );
                              return Positioned(
                                left: node.position.dx,
                                top: node.position.dy - node.radius - 8,
                                child: FractionalTranslation(
                                  translation: const Offset(-0.5, -1.0),
                                  child: AppInfoBadge.text(
                                    text: 'Flujo: $sinkFlow',
                                    height: 32,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                ),
                              );
                            }),
                        if (graphState.selectedNode != null &&
                            !simulationStateNotifier.isSimulating &&
                            mode == GraphMode.move)
                          Positioned(
                            left: graphState.selectedNode!.position.dx,
                            top: graphState.selectedNode!.position.dy,
                            child: FractionalTranslation(
                              translation: Offset(-0.5, -1.3),
                              child: NodeTypeSelector(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 10,
              right: 10,
              child: Badge(
                offset: const Offset(-8, -6),
                isLabelVisible:
                    simulationState.status == SimulationStatus.stopped &&
                    graphState.nodes.length < 7,
                backgroundColor: graphState.nodes.length < 4
                    ? Colors.redAccent
                    : Colors.orangeAccent,
                label: Text(
                  '${graphState.nodes.length}/7',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: Tooltip(
                  message: (simulationState.status != SimulationStatus.stopped)
                      ? 'Detener Algoritmo'
                      : graphState.nodes.length < 7
                      ? 'Se requieren al menos 7 nodos para ejecutar (actualmente ${graphState.nodes.length}/7)'
                      : !(graphState.hasSources && graphState.hasSinks)
                      ? 'Necesitas almenos una fuente y un sumidero para poder ejecutar este algoritmo'
                      : 'Ejecutar Algoritmo',
                  child: OutlinedButtonElevated.icon(
                    onPressed:
                        (simulationState.status != SimulationStatus.stopped)
                        ? () {
                            graphNotifier.unselectNode();
                            modeNotifier.changeMode(GraphMode.move);
                            simulationStateNotifier.stopSimulation();
                          }
                        : (graphState.nodes.length >= 7 &&
                              graphState.hasSources &&
                              graphState.hasSinks)
                        ? () {
                            graphNotifier.unselectNode();
                            modeNotifier.changeMode(GraphMode.move);
                            final graphCore = GraphCore(
                              nodes: graphState.nodes
                                  .map((n) => n.core)
                                  .toList(),
                              edges: graphState.edges
                                  .map((e) => e.core)
                                  .toList(),
                            );
                            simulationStateNotifier.startSimulation(graphCore);
                          }
                        : null,
                    label: simulationState.status == SimulationStatus.stopped
                        ? 'Ejecutar Algoritmo'
                        : 'Detener Algoritmo',
                    iconData: simulationState.status == SimulationStatus.stopped
                        ? FontAwesomeIcons.play
                        : FontAwesomeIcons.stop,
                    color: (simulationState.status != SimulationStatus.stopped)
                        ? Colors.redAccent
                        : (graphState.nodes.length >= 7 &&
                              graphState.hasSources &&
                              graphState.hasSinks)
                        ? Colors.greenAccent
                        : Colors.grey,
                  ),
                ),
              ),
            ),
            if (simulationStateNotifier.isSimulating) ...[
              Positioned(bottom: 10, left: 10, child: SimulationControls()),
              Positioned(top: 10, right: 10, child: SimulationHistoryTile()),
            ],
          ],
        ),
      );
    },
  ),
);
  }
}
