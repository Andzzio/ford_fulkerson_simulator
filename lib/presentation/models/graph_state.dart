import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class GraphState {
  GraphState({
    this.nodes = const [],
    this.edges = const [],
    this.nodesMaxCapacity = 7,
    this.selectedNode,
    this.joinSourceNode,
  });
  List<NodeUi> nodes;
  List<EdgeUi> edges;
  final int nodesMaxCapacity;
  final NodeUi? selectedNode;
  final NodeUi? joinSourceNode;

  bool get hasSources {
    return nodes.any((node) => node.core.nodeType == NodeType.source);
  }

  bool get hasSinks {
    return nodes.any((node) => node.core.nodeType == NodeType.sink);
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
    );
  }
}
