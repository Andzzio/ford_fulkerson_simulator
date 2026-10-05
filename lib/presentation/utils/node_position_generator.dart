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

  static List<NodeUi> generateStructuredPositions(
    List<NodeCore> nodes, {
    Offset center = const Offset(1500, 1500),
    double gridSize = 20.0,
    double nodeRadius = 20.0,
    double colSpacing = 240.0,
    double rowSpacing = 150.0,
  }) {
    if (nodes.isEmpty) return [];
    if (nodes.length == 1) {
      return [NodeUi(core: nodes.first, position: center, radius: nodeRadius)];
    }

    final int n = nodes.length;
    final List<int> colCounts = [];

    if (n <= 9) {
      final int c1 = 1;
      final int c4 = 1;
      final int remaining = n - 2;
      final int c2 = remaining ~/ 2;
      final int c3 = remaining - c2;
      colCounts.addAll([c1, c2, c3, c4]);
    } else if (n <= 13) {
      final int c1 = 2;
      final int c5 = 1;
      final int remaining = n - 3;
      final int c2 = remaining ~/ 3;
      final int c3 = remaining ~/ 3 + (remaining % 3 > 0 ? 1 : 0);
      final int c4 = remaining - c2 - (remaining % 3 > 0 ? 1 : 0);
      colCounts.addAll([c1, c2, c3, c4, c5]);
    } else {
      final int c1 = 2;
      final int c6 = 2;
      final int remaining = n - 4;
      final int base = remaining ~/ 4;
      final int rem = remaining % 4;
      final int c2 = base + (rem > 0 ? 1 : 0);
      final int c3 = base + (rem > 1 ? 1 : 0);
      final int c4 = base + (rem > 2 ? 1 : 0);
      final int c5 = base;
      colCounts.addAll([c1, c2, c3, c4, c5, c6]);
    }

    Offset align(Offset raw) {
      final double x = (raw.dx / gridSize).round() * gridSize;
      final double y = (raw.dy / gridSize).round() * gridSize;
      return Offset(x, y);
    }

    final List<Offset> positions = [];
    final int numCols = colCounts.length;
    final double totalWidth = (numCols - 1) * colSpacing;
    final double startX = center.dx - totalWidth / 2;

    for (int col = 0; col < numCols; col++) {
      final int countInCol = colCounts[col];
      final double x = startX + col * colSpacing;
      final double totalHeight = (countInCol - 1) * rowSpacing;
      final double startY = center.dy - totalHeight / 2;

      for (int row = 0; row < countInCol; row++) {
        final double y = startY + row * rowSpacing;
        positions.add(align(Offset(x, y)));
      }
    }

    final math.Random random = math.Random();
    final List<Offset> shuffledPositions = List.of(positions)..shuffle(random);
    final List<NodeUi> result = [];

    for (int i = 0; i < n; i++) {
      result.add(
        NodeUi(
          core: nodes[i],
          position: shuffledPositions[i],
          radius: nodeRadius,
        ),
      );
    }

    return result;
  }

  static List<int> getStageSizes(int n) {
    if (n <= 3) return [n];
    final int numStages = n <= 9 ? 4 : (n <= 13 ? 5 : 6);
    final int intermediateStages = numStages - 2;
    final int intermediateNodes = n - 2;
    final int base = intermediateNodes ~/ intermediateStages;
    int rem = intermediateNodes % intermediateStages;

    final List<int> mid = List.filled(intermediateStages, base);
    int left = intermediateStages ~/ 2;
    int right = left;
    if (intermediateStages % 2 == 0 && left > 0) {
      left -= 1;
    }
    while (rem > 0) {
      if (rem > 0 && right < intermediateStages) {
        mid[right] += 1;
        rem -= 1;
      }
      if (rem > 0 && left < right) {
        mid[left] += 1;
        rem -= 1;
      }
      if (left > 0) left -= 1;
      if (right + 1 < intermediateStages) right += 1;
    }
    return [1, ...mid, 1];
  }

  static List<NodeUi> generateRailGridPositions(
    List<NodeCore> nodes, {
    Offset center = const Offset(1500, 1500),
    double colSpacing = 200.0,
    double rowSpacing = 130.0,
    double gridSize = 20.0,
    double nodeRadius = 20.0,
  }) {
    if (nodes.isEmpty) return [];
    if (nodes.length == 1) {
      return [NodeUi(core: nodes.first, position: center, radius: nodeRadius)];
    }

    final int n = nodes.length;
    final List<int> stageSizes = getStageSizes(n);
    final int numCols = stageSizes.length;
    final double totalWidth = (numCols - 1) * colSpacing;
    final double startX = center.dx - totalWidth / 2;

    Offset align(Offset raw) {
      final double x = (raw.dx / gridSize).round() * gridSize;
      final double y = (raw.dy / gridSize).round() * gridSize;
      return Offset(x, y);
    }

    final List<NodeUi> result = [];
    int nodeIdx = 0;

    for (int col = 0; col < numCols; col++) {
      final int count = stageSizes[col];
      final double x = startX + col * colSpacing;
      final double totalHeight = (count - 1) * rowSpacing;
      final double startY = center.dy - totalHeight / 2;

      for (int row = 0; row < count; row++) {
        if (nodeIdx >= n) break;
        final double y = startY + row * rowSpacing;
        result.add(
          NodeUi(
            core: nodes[nodeIdx],
            position: align(Offset(x, y)),
            radius: nodeRadius,
          ),
        );
        nodeIdx++;
      }
    }

    while (nodeIdx < n) {
      result.add(
        NodeUi(
          core: nodes[nodeIdx],
          position: align(Offset(startX + (numCols - 1) * colSpacing, center.dy)),
          radius: nodeRadius,
        ),
      );
      nodeIdx++;
    }

    return result;
  }
}
