import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';
import 'package:ford_fulkerson_simulator/src/rust/api/entities/node_core.dart';

class NodePositionGenerator {
  static List<NodeUi> generate(
    List<NodeCore> nodes, {
    Offset center = const Offset(1500, 1500),
    double gridSize = 20.0,
    double nodeRadius = 20.0,
  }) {
    if (nodes.isEmpty) return [];
    if (nodes.length == 1) {
      return [NodeUi(core: nodes.first, position: center, radius: nodeRadius)];
    }

    final int n = nodes.length;
    final List<NodeUi> result = [];

    Offset align(Offset raw) {
      final double x = (raw.dx / gridSize).round() * gridSize;
      final double y = (raw.dy / gridSize).round() * gridSize;
      return Offset(x, y);
    }

    if (n <= 9) {
      result.add(
        NodeUi(core: nodes[0], position: align(center), radius: nodeRadius),
      );

      final int outerCount = n - 1;
      final double outerRadius = 180.0;
      final double angleStep = (2 * math.pi) / outerCount;

      for (int i = 0; i < outerCount; i++) {
        final double angle = -math.pi / 2 + i * angleStep;
        final double rawX = center.dx + outerRadius * math.cos(angle);
        final double rawY = center.dy + outerRadius * math.sin(angle);

        result.add(
          NodeUi(
            core: nodes[i + 1],
            position: align(Offset(rawX, rawY)),
            radius: nodeRadius,
          ),
        );
      }
    } else if (n <= 13) {
      final int innerCount = 3;
      final double innerRadius = 100.0;
      final double innerStep = (2 * math.pi) / innerCount;

      for (int i = 0; i < innerCount; i++) {
        final double angle = -math.pi / 2 + i * innerStep;
        final double rawX = center.dx + innerRadius * math.cos(angle);
        final double rawY = center.dy + innerRadius * math.sin(angle);

        result.add(
          NodeUi(
            core: nodes[i],
            position: align(Offset(rawX, rawY)),
            radius: nodeRadius,
          ),
        );
      }

      final int outerCount = n - innerCount;
      final double outerRadius = 240.0;
      final double outerStep = (2 * math.pi) / outerCount;
      final double outerOffset = math.pi / outerCount;

      for (int i = 0; i < outerCount; i++) {
        final double angle = -math.pi / 2 + i * outerStep + outerOffset;
        final double rawX = center.dx + outerRadius * math.cos(angle);
        final double rawY = center.dy + outerRadius * math.sin(angle);

        result.add(
          NodeUi(
            core: nodes[innerCount + i],
            position: align(Offset(rawX, rawY)),
            radius: nodeRadius,
          ),
        );
      }
    } else {
      result.add(
        NodeUi(core: nodes[0], position: align(center), radius: nodeRadius),
      );

      final int midCount = 5;
      final double midRadius = 130.0;
      final double midStep = (2 * math.pi) / midCount;

      for (int i = 0; i < midCount; i++) {
        final double angle = -math.pi / 2 + i * midStep;
        final double rawX = center.dx + midRadius * math.cos(angle);
        final double rawY = center.dy + midRadius * math.sin(angle);

        result.add(
          NodeUi(
            core: nodes[1 + i],
            position: align(Offset(rawX, rawY)),
            radius: nodeRadius,
          ),
        );
      }

      final int outerCount = n - 1 - midCount;
      final double outerRadius = 260.0;
      final double outerStep = (2 * math.pi) / outerCount;
      final double outerOffset = math.pi / outerCount;

      for (int i = 0; i < outerCount; i++) {
        final double angle = -math.pi / 2 + i * outerStep + outerOffset;
        final double rawX = center.dx + outerRadius * math.cos(angle);
        final double rawY = center.dy + outerRadius * math.sin(angle);

        result.add(
          NodeUi(
            core: nodes[1 + midCount + i],
            position: align(Offset(rawX, rawY)),
            radius: nodeRadius,
          ),
        );
      }
    }

    return result;
  }

  static List<NodeUi> generateRandomPositions(
    List<NodeCore> nodes, {
    Offset center = const Offset(1500, 1500),
    double areaWidth = 1400.0,
    double areaHeight = 650.0,
    double minDistance = 100.0,
    double gridSize = 20.0,
    double nodeRadius = 20.0,
  }) {
    if (nodes.isEmpty) return [];
    if (nodes.length == 1) {
      return [NodeUi(core: nodes.first, position: center, radius: nodeRadius)];
    }

    final math.Random random = math.Random();
    final List<NodeUi> result = [];
    final double startX = center.dx - areaWidth / 2;
    final double stepX = areaWidth / (nodes.length - 1);

    for (int i = 0; i < nodes.length; i++) {
      Offset newPosition = center;
      bool isValid = false;
      int attempts = 0;

      while (!isValid && attempts < 100) {
        final double rawX =
            startX + i * stepX + (random.nextDouble() - 0.5) * (stepX * 0.4);
        final double rawY =
            center.dy + (random.nextDouble() - 0.5) * areaHeight;

        final double x = (rawX / gridSize).round() * gridSize;
        final double y = (rawY / gridSize).round() * gridSize;
        newPosition = Offset(x, y);

        isValid = result.every((placedNode) {
          final double dist = (placedNode.position - newPosition).distance;
          return dist >= minDistance;
        });

        attempts++;
      }

      result.add(
        NodeUi(core: nodes[i], position: newPosition, radius: nodeRadius),
      );
    }

    return result;
  }
}
