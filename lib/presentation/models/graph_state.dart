import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';

class GraphState {
  GraphState({
    this.nodes = const [],
    this.edges = const [],
    this.nodesMaxCapacity = 7,
  });
  List<NodeUi> nodes;
  List<EdgeUi> edges;
  final int nodesMaxCapacity;
  GraphState copyWith({
    List<NodeUi>? nodes,
    List<EdgeUi>? edges,
    int? nodesMaxCapacity,
  }) {
    return GraphState(
      nodes: nodes ?? this.nodes,
      edges: edges ?? this.edges,
      nodesMaxCapacity: nodesMaxCapacity ?? this.nodesMaxCapacity,
    );
  }
}
