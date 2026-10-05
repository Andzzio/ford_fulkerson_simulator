import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/graph_state.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/utils/node_position_generator.dart';
import 'package:ford_fulkerson_simulator/providers/core_providers.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/edge_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class GraphStateNotifier extends Notifier<GraphState> {
  @override
  GraphState build() {
    return GraphState();
  }

  void generateRandom() {
    final generateRandomUsecase = ref.read(generateRandomGraphProvider);
    final graphRandom = generateRandomUsecase(state.nodesMaxCapacity);
    final nodesUi = NodePositionGenerator.generateRailGridPositions(
      graphRandom.nodes,
    );
    final edgesUi = graphRandom.edges.map((edgeCore) {
      final fromIndex = int.parse(edgeCore.from);
      final toIndex = int.parse(edgeCore.to);
      return EdgeUi(
        core: edgeCore,
        from: nodesUi[fromIndex],
        to: nodesUi[toIndex],
      );
    }).toList();

    state = GraphState(
      nodes: nodesUi,
      edges: edgesUi,
      nodesMaxCapacity: state.nodesMaxCapacity,
    );
  }

  void generateBlank() {
    state = GraphState(nodesMaxCapacity: state.nodesMaxCapacity);
  }

  void changeNodesMaxCapacity(int newValue) {
    state = state.copyWith(nodesMaxCapacity: newValue);
  }

  void selectNode(NodeUi node) {
    state = state.copyWith(selectedNode: () => node);
  }

  void selectJoinSource(NodeUi node) {
    state = state.copyWith(joinSourceNode: () => node);
  }

  void clearJoinSource() {
    state = state.copyWith(joinSourceNode: () => null);
  }

  void unselectNode() {
    state = state.copyWith(
      selectedNode: () => null,
      joinSourceNode: () => null,
    );
  }

  bool hasEdge(String fromId, String toId) {
    return state.edges.any((e) => e.core.from == fromId && e.core.to == toId);
  }

  bool wouldCreateCycle(String fromId, String toId) {
    if (fromId == toId) return true;
    final visited = <String>{toId};
    final queue = <String>[toId];
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      if (current == fromId) return true;
      for (final edge in state.edges) {
        if (edge.core.from == current) {
          final next = edge.core.to;
          if (!visited.contains(next)) {
            visited.add(next);
            queue.add(next);
          }
        }
      }
    }
    return false;
  }

  void addEdge({
    required NodeUi from,
    required NodeUi to,
    required int capacity,
  }) {
    final newEdgeId = '${from.id}-${to.id}';
    final core = EdgeCore(
      id: newEdgeId,
      from: from.id,
      to: to.id,
      capacity: capacity,
      flow: 0,
    );
    final newEdge = EdgeUi(
      core: core,
      from: from,
      to: to,
    );
    state = state.copyWith(
      edges: [...state.edges, newEdge],
      joinSourceNode: () => null,
    );
  }

  void updateEdgeCapacity({
    required String edgeId,
    required int capacity,
  }) {
    final updatedEdges = state.edges.map((edge) {
      if (edge.core.id == edgeId) {
        final newCore = EdgeCore(
          id: edge.core.id,
          from: edge.core.from,
          to: edge.core.to,
          capacity: capacity,
          flow: edge.core.flow,
        );
        return EdgeUi(
          core: newCore,
          from: edge.from,
          to: edge.to,
        );
      }
      return edge;
    }).toList();
    state = state.copyWith(edges: updatedEdges);
  }

  void deleteEdge(String edgeId) {
    final updatedEdges =
        state.edges.where((e) => e.core.id != edgeId).toList();
    state = state.copyWith(edges: updatedEdges);
  }

  void deleteNode(String nodeId) {
    final updatedNodes = state.nodes.where((n) => n.id != nodeId).toList();
    final updatedEdges = state.edges
        .where((e) => e.core.from != nodeId && e.core.to != nodeId)
        .toList();
    state = state.copyWith(
      nodes: updatedNodes,
      edges: updatedEdges,
      selectedNode: () =>
          state.selectedNode?.id == nodeId ? null : state.selectedNode,
      joinSourceNode: () =>
          state.joinSourceNode?.id == nodeId ? null : state.joinSourceNode,
    );
  }

  void updateNodeType(NodeType nodeType) {
    NodeUi? current = state.selectedNode;
    if (current == null) return;
    current.core = NodeCore(
      id: current.id,
      label: current.label,
      nodeType: nodeType,
    );
    state = state.copyWith();
  }

  void moveNode(NodeUi node, Offset delta) {
    final newX = (node.position.dx + delta.dx).clamp(node.radius, 3000.0 - node.radius);
    final newY = (node.position.dy + delta.dy).clamp(node.radius, 3000.0 - node.radius);
    node.position = Offset(newX, newY);
    state = state.copyWith(nodes: [...state.nodes], edges: [...state.edges]);
  }

  int getNextAvailableId() {
    final existingIds = state.nodes
        .map((n) => int.tryParse(n.id))
        .whereType<int>()
        .toSet();
    var id = 0;
    while (existingIds.contains(id)) {
      id++;
    }
    return id;
  }

  String getSuggestedLabel(int id) {
    if (id < 26) {
      return String.fromCharCode('A'.codeUnitAt(0) + id);
    }
    final prefix = String.fromCharCode('A'.codeUnitAt(0) + (id ~/ 26) - 1);
    final suffix = String.fromCharCode('A'.codeUnitAt(0) + (id % 26));
    return '$prefix$suffix';
  }

  void addNode({
    required Offset position,
    String? label,
    NodeType nodeType = NodeType.intermediate,
  }) {
    if (state.nodes.length >= 16) return;
    final id = getNextAvailableId();
    final effectiveLabel = (label != null && label.trim().isNotEmpty)
        ? label.trim()
        : getSuggestedLabel(id);
    final core = NodeCore(
      id: id.toString(),
      label: effectiveLabel,
      nodeType: nodeType,
    );
    final newNode = NodeUi(
      core: core,
      position: position,
      radius: 20.0,
    );
    final updatedNodes = [...state.nodes, newNode];
    final updatedMax = updatedNodes.length > state.nodesMaxCapacity
        ? updatedNodes.length
        : state.nodesMaxCapacity;
    state = state.copyWith(
      nodes: updatedNodes,
      nodesMaxCapacity: updatedMax,
    );
  }
}

final graphStateNotifier = NotifierProvider<GraphStateNotifier, GraphState>(
  GraphStateNotifier.new,
);
