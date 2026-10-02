import 'package:ford_fulkerson_simulator/domain/repositories/graph_repository.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/graph_core.dart';

class GraphRepositoryImpl implements GraphRepository {
  @override
  GraphCore generateBlankGraph() {
    return GraphCore.generateBlank();
  }

  @override
  GraphCore generateRandomGraph(int n) {
    return GraphCore.generateRandom(n: BigInt.from(n));
  }
}
