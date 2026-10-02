import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/notifiers/graph_state_notifier.dart';
import 'package:ford_fulkerson_simulator/presentation/painters/edges_painter.dart';
import 'package:ford_fulkerson_simulator/presentation/painters/viewport_painter.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/node_widget.dart';

class GraphViewport extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<GraphViewport> createState() => _GraphViewportState();
}

class _GraphViewportState extends ConsumerState<GraphViewport> {
  late final TransformationController _controller;
  @override
  void initState() {
    super.initState();
    const double initialScale = 1.0;
    _controller = TransformationController(
      Matrix4.identity()
        ..scaleByDouble(initialScale, initialScale, 1.0, 1.0)
        ..translateByDouble(-1100.0, -1200.0, 0.0, 1.0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final graphState = ref.watch(graphStateNotifier);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(8),
          border: Border.all(color: AppTheme.darkBorder, width: 2),
        ),
        child: InteractiveViewer(
          transformationController: _controller,
          minScale: 0.5,
          maxScale: 3.0,
          constrained: false,
          child: SizedBox(
            width: 3000,
            height: 3000,
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: ViewportPainter())),
                Positioned.fill(
                  child: CustomPaint(
                    painter: EdgesPainter(edges: graphState.edges),
                  ),
                ),
                ...graphState.nodes.map((node) {
                  return Positioned(
                    left: node.position.dx - node.radius,
                    top: node.position.dy - node.radius,
                    child: NodeWidget(node: node),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
