import 'package:ford_fulkerson_simulator/domain/repositories/graph_repository.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/ford_fulkerson.dart' as rust;
import 'package:ford_fulkerson_simulator/src/rust/api/simulation_event.dart';

class GraphRepositoryImpl implements GraphRepository {
  @override
  GraphCore generateBlankGraph() {
    return GraphCore.generateBlank();
  }

  @override
  GraphCore generateRandomGraph(int n) {
    return GraphCore.generateRandom(n: BigInt.from(n));
  }

  @override
  SimulationResult runFordFulkerson(GraphCore graph) {
    return rust.runFordFulkerson(graph: graph);
  }
}
