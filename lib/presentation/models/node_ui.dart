import 'package:flutter/animation.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class NodeUi {
  NodeUi({required this.core, required this.position, required this.radius});
  NodeCore core;
  Offset position;
  final double radius;

  String get id => core.id;
  String get label => core.label;
}
