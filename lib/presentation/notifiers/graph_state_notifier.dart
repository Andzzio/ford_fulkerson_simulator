import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/graph_state.dart';
import 'package:ford_fulkerson_simulator/presentation/utils/node_position_generator.dart';
import 'package:ford_fulkerson_simulator/providers/core_providers.dart';

class GraphStateNotifier extends Notifier<GraphState> {
  @override
  GraphState build() {
    return GraphState();
  }

  void generateRandom() {
    final generateRandomUsecase = ref.read(generateRandomGraphProvider);
    final graphRandom = generateRandomUsecase(state.nodesMaxCapacity);
    final nodesUi = NodePositionGenerator.generateRandomPositions(
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
}

final graphStateNotifier = NotifierProvider<GraphStateNotifier, GraphState>(
  GraphStateNotifier.new,
);
