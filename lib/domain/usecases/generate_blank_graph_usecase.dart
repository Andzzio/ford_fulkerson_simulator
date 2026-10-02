import 'package:ford_fulkerson_simulator/domain/repositories/graph_repository.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';

class GenerateBlankGraphUsecase {
  GenerateBlankGraphUsecase({required this.repo});
  final GraphRepository repo;
  GraphCore call() {
    return repo.generateBlankGraph();
  }
}
