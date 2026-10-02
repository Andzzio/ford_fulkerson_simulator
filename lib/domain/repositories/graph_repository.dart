import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';

abstract class GraphRepository {
  GraphCore generateRandomGraph(int n);
  GraphCore generateBlankGraph();
}
