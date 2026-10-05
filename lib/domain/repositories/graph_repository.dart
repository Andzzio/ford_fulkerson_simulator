import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/simulation_event.dart';

abstract class GraphRepository {
  GraphCore generateRandomGraph(int n);
  GraphCore generateBlankGraph();
  SimulationResult runFordFulkerson(GraphCore graph);
}
