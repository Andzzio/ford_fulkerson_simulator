import 'package:ford_fulkerson_simulator/domain/repositories/graph_repository.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/simulation_event.dart';

class RunFordFulkersonUsecase {
  RunFordFulkersonUsecase({required this.repo});
  final GraphRepository repo;

  SimulationResult call(GraphCore graph) {
    return repo.runFordFulkerson(graph);
  }
}
