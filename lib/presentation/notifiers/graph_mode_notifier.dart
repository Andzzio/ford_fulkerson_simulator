import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_mode.dart';

class GraphModeNotifier extends Notifier<GraphMode> {
  @override
  GraphMode build() {
    return GraphMode.move;
  }

  void changeMode(GraphMode newMode) {
    state = newMode;
  }
}

final graphModeNotifier = NotifierProvider<GraphModeNotifier, GraphMode>(
  GraphModeNotifier.new,
);
