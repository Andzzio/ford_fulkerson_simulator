import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ford_fulkerson_simulator/data/services/windows_manager_service.dart';

final windowManagerServiceProvider = Provider((ref) => WindowsManagerService());
