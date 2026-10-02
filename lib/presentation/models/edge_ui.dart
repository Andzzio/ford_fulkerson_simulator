import 'package:flutter/animation.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/edge_core.dart';

class EdgeUi {
  EdgeUi({required this.core, required this.from, required this.to});
  final EdgeCore core;
  final NodeUi from;
  final NodeUi to;
  Offset get fromPosition => from.position;
  Offset get toPosition => to.position;
}
