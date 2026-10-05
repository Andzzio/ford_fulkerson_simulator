import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/data/repositories/graph_repository_impl.dart';
import 'package:ford_fulkerson_simulator/domain/repositories/graph_repository.dart';
import 'package:ford_fulkerson_simulator/domain/usecases/generate_blank_graph_usecase.dart';
import 'package:ford_fulkerson_simulator/domain/usecases/generate_random_graph_usecase.dart';
import 'package:ford_fulkerson_simulator/domain/usecases/run_ford_fulkerson_usecase.dart';

final graphRepositoryProvider = Provider<GraphRepository>(
  (ref) => GraphRepositoryImpl(),
);
final generateRandomGraphProvider = Provider(
  (ref) => GenerateRandomGraphUsecase(repo: ref.watch(graphRepositoryProvider)),
);
final generateBlankGraphProvider = Provider(
  (ref) => GenerateBlankGraphUsecase(repo: ref.watch(graphRepositoryProvider)),
);
final runFordFulkersonProvider = Provider(
  (ref) => RunFordFulkersonUsecase(repo: ref.watch(graphRepositoryProvider)),
);
