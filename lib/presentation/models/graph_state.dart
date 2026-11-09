import 'dart:math';
import 'dart:ui';

import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/edge_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class GraphState {
  GraphState({
    this.nodes = const [],
    this.edges = const [],
    this.nodesMaxCapacity = 7,
    this.selectedNode,
    this.joinSourceNode,
    NodeUi? superSourceNode,
    NodeUi? superSinkNode,
  }) {
    this.superSourceNode = _resolveSuperSourceNode(superSourceNode);
    this.superSinkNode = _resolveSuperSinkNode(superSinkNode);
  }

  List<NodeUi> nodes;
  List<EdgeUi> edges;
  final int nodesMaxCapacity;
  final NodeUi? selectedNode;
  final NodeUi? joinSourceNode;
  late final NodeUi? superSourceNode;
  late final NodeUi? superSinkNode;

  bool get hasSources {
    return nodes.any((node) => node.core.nodeType == NodeType.source);
  }

  bool get hasSinks {
    return nodes.any((node) => node.core.nodeType == NodeType.sink);
  }

  List<NodeUi> get sourceNodes {
    return nodes.where((node) => node.core.nodeType == NodeType.source).toList();
  }

  List<NodeUi> get sinkNodes {
    return nodes.where((node) => node.core.nodeType == NodeType.sink).toList();
  }

  NodeUi? _resolveSuperSourceNode(NodeUi? existing) {
    final sources = sourceNodes;
    if (sources.length < 2) return null;
    if (existing != null) return existing;
    final minX = sources.map((n) => n.position.dx).reduce(min);
    final avgY =
        sources.map((n) => n.position.dy).reduce((a, b) => a + b) /
        sources.length;
    final defaultPos = Offset(
      (minX - 140.0).clamp(20.0, 2980.0),
      avgY.clamp(20.0, 2980.0),
    );
    return NodeUi(
      core: const NodeCore(
        id: '__super_source__',
        label: 'S*',
        nodeType: NodeType.source,
      ),
      position: defaultPos,
      radius: 20.0,
      isVirtual: true,
    );
  }

  NodeUi? _resolveSuperSinkNode(NodeUi? existing) {
    final sinks = sinkNodes;
    if (sinks.length < 2) return null;
    if (existing != null) return existing;
    final maxX = sinks.map((n) => n.position.dx).reduce(max);
    final avgY =
        sinks.map((n) => n.position.dy).reduce((a, b) => a + b) / sinks.length;
    final defaultPos = Offset(
      (maxX + 140.0).clamp(20.0, 2980.0),
      avgY.clamp(20.0, 2980.0),
    );
    return NodeUi(
      core: const NodeCore(
        id: '__super_sink__',
        label: 'T*',
        nodeType: NodeType.sink,
      ),
      position: defaultPos,
      radius: 20.0,
      isVirtual: true,
    );
  }

  late final List<NodeUi> virtualNodes = [
    ?superSourceNode,
    ?superSinkNode,
  ];

  late final List<EdgeUi> virtualEdges = _createVirtualEdges();

  List<EdgeUi> _createVirtualEdges() {
    final result = <EdgeUi>[];
    final sNode = superSourceNode;
    if (sNode != null) {
      for (final src in sourceNodes) {
        result.add(
          EdgeUi(
            core: EdgeCore(
              id: '__virtual_s_${src.id}__',
              from: sNode.id,
              to: src.id,
              capacity: 0,
              flow: 0,
            ),
            from: sNode,
            to: src,
            isVirtual: true,
          ),
        );
      }
    }
    final tNode = superSinkNode;
    if (tNode != null) {
      for (final snk in sinkNodes) {
        result.add(
          EdgeUi(
            core: EdgeCore(
              id: '__virtual_t_${snk.id}__',
              from: snk.id,
              to: tNode.id,
              capacity: 0,
              flow: 0,
            ),
            from: snk,
            to: tNode,
            isVirtual: true,
          ),
        );
      }
    }
    return result;
  }

  GraphState copyWith({
    List<NodeUi>? nodes,
    List<EdgeUi>? edges,
    int? nodesMaxCapacity,
    NodeUi? Function()? selectedNode,
    NodeUi? Function()? joinSourceNode,
  }) {
    return GraphState(
      nodes: nodes ?? this.nodes,
      edges: edges ?? this.edges,
      nodesMaxCapacity: nodesMaxCapacity ?? this.nodesMaxCapacity,
      selectedNode: selectedNode != null ? selectedNode() : this.selectedNode,
      joinSourceNode:
          joinSourceNode != null ? joinSourceNode() : this.joinSourceNode,
      superSourceNode: superSourceNode,
      superSinkNode: superSinkNode,
    );
  }
}
