import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_mode.dart';

class EdgeHitboxWidget extends StatelessWidget {
  const EdgeHitboxWidget({
    super.key,
    required this.edge,
    required this.mode,
    required this.isSimulating,
    required this.onTap,
  });

  final EdgeUi edge;
  final GraphMode mode;
  final bool isSimulating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p1 = edge.fromPosition;
    final p2 = edge.toPosition;
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final length = sqrt(dx * dx + dy * dy);
    if (length == 0) return const SizedBox.shrink();
    final angle = atan2(dy, dx);

    final cursor = isSimulating
        ? SystemMouseCursors.basic
        : switch (mode) {
            GraphMode.move => SystemMouseCursors.click,
            GraphMode.delete => SystemMouseCursors.forbidden,
            _ => SystemMouseCursors.basic,
          };

    return Positioned(
      left: p1.dx,
      top: p1.dy - 12.0,
      child: Transform.rotate(
        angle: angle,
        alignment: Alignment.centerLeft,
        child: MouseRegion(
          hitTestBehavior: HitTestBehavior.opaque,
          cursor: cursor,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isSimulating ? null : onTap,
            child: SizedBox(
              width: length,
              height: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
