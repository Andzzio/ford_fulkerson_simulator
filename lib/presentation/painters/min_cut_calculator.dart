import 'dart:math';

import 'package:flutter/material.dart';

class MinCutCalculator {
  static Path? computeMinCutPath({
    required List<Offset> sourcePositions,
    required List<Offset> sinkPositions,
    List<(Offset, Offset)> sourceEdges = const [],
    List<(Offset, Offset)> sinkEdges = const [],
    List<(Offset, Offset)> cutEdges = const [],
  }) {
    if (sourcePositions.isEmpty || sinkPositions.isEmpty) return null;

    var minX = double.infinity;
    var maxX = -double.infinity;
    var minY = double.infinity;
    var maxY = -double.infinity;

    for (final p in sourcePositions) {
      minX = min(minX, p.dx);
      maxX = max(maxX, p.dx);
      minY = min(minY, p.dy);
      maxY = max(maxY, p.dy);
    }
    for (final p in sinkPositions) {
      minX = min(minX, p.dx);
      maxX = max(maxX, p.dx);
      minY = min(minY, p.dy);
      maxY = max(maxY, p.dy);
    }

    const margin = 100.0;
    minX -= margin;
    maxX += margin;
    minY -= margin;
    maxY += margin;

    const cols = 80;
    const rows = 80;
    final dx = (maxX - minX) / cols;
    final dy = (maxY - minY) / rows;

    final field = List.generate(
      rows + 1,
      (r) => List.generate(cols + 1, (c) {
        final x = minX + c * dx;
        final y = minY + r * dy;
        final target = Offset(x, y);

        var minSourceDist = double.infinity;
        for (final sp in sourcePositions) {
          final d = (target - sp).distance;
          if (d < minSourceDist) minSourceDist = d;
        }
        for (final se in sourceEdges) {
          final d = _distToSegment(target, se.$1, se.$2);
          if (d < minSourceDist) minSourceDist = d;
        }

        var minSinkDist = double.infinity;
        for (final tp in sinkPositions) {
          final d = (target - tp).distance;
          if (d < minSinkDist) minSinkDist = d;
        }
        for (final te in sinkEdges) {
          final d = _distToSegment(target, te.$1, te.$2);
          if (d < minSinkDist) minSinkDist = d;
        }

        return minSourceDist - minSinkDist;
      }),
    );

    final segments = <(Offset, Offset)>[];

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final x = minX + c * dx;
        final y = minY + r * dy;

        final v0 = field[r][c];
        final v1 = field[r][c + 1];
        final v2 = field[r + 1][c + 1];
        final v3 = field[r + 1][c];

        final caseIndex =
            (v0 > 0 ? 1 : 0) |
            (v1 > 0 ? 2 : 0) |
            (v2 > 0 ? 4 : 0) |
            (v3 > 0 ? 8 : 0);

        if (caseIndex == 0 || caseIndex == 15) continue;

        Offset lerpEdge(Offset pA, Offset pB, double valA, double valB) {
          final t = (valB - valA).abs() < 1e-6 ? 0.5 : (-valA) / (valB - valA);
          return Offset(
            pA.dx + t * (pB.dx - pA.dx),
            pA.dy + t * (pB.dy - pA.dy),
          );
        }

        final pTop = lerpEdge(Offset(x, y), Offset(x + dx, y), v0, v1);
        final pRight = lerpEdge(
          Offset(x + dx, y),
          Offset(x + dx, y + dy),
          v1,
          v2,
        );
        final pBottom = lerpEdge(
          Offset(x, y + dy),
          Offset(x + dx, y + dy),
          v3,
          v2,
        );
        final pLeft = lerpEdge(Offset(x, y), Offset(x, y + dy), v0, v3);

        switch (caseIndex) {
          case 1:
          case 14:
            segments.add((pLeft, pTop));
          case 2:
          case 13:
            segments.add((pTop, pRight));
          case 3:
          case 12:
            segments.add((pLeft, pRight));
          case 4:
          case 11:
            segments.add((pRight, pBottom));
          case 5:
            segments.add((pLeft, pTop));
            segments.add((pRight, pBottom));
          case 6:
          case 9:
            segments.add((pTop, pBottom));
          case 7:
          case 8:
            segments.add((pLeft, pBottom));
          case 10:
            segments.add((pTop, pRight));
            segments.add((pLeft, pBottom));
        }
      }
    }

    if (segments.isEmpty) return null;

    final polylines = _chainSegments(segments);
    final rawPath = Path();

    for (final poly in polylines) {
      if (poly.length < 2) continue;
      final smoothed = _smoothPolyline(poly);

      if (cutEdges.isNotEmpty) {
        final cumDist = <double>[0.0];
        for (var i = 0; i < smoothed.length - 1; i++) {
          cumDist.add(cumDist.last + (smoothed[i + 1] - smoothed[i]).distance);
        }
        final totalLen = cumDist.last;
        if (totalLen < 1.0) continue;

        double? firstTouchDist;
        double? lastTouchDist;

        for (var i = 0; i < smoothed.length; i++) {
          final p = smoothed[i];
          var minDist = double.infinity;
          for (final e in cutEdges) {
            final d = _distToSegment(p, e.$1, e.$2);
            if (d < minDist) minDist = d;
          }

          if (minDist <= 50.0) {
            firstTouchDist ??= cumDist[i];
            lastTouchDist = cumDist[i];
          }
        }

        if (firstTouchDist == null || lastTouchDist == null) continue;

        const margin = 15.0;
        final startDist = max(0.0, firstTouchDist - margin);
        final endDist = min(totalLen, lastTouchDist + margin);

        final polyPath = Path();
        polyPath.moveTo(smoothed.first.dx, smoothed.first.dy);
        for (var i = 1; i < smoothed.length; i++) {
          polyPath.lineTo(smoothed[i].dx, smoothed[i].dy);
        }

        for (final metric in polyPath.computeMetrics()) {
          final extracted = metric.extractPath(startDist, endDist);
          rawPath.addPath(extracted, Offset.zero);
        }
      } else {
        rawPath.moveTo(smoothed.first.dx, smoothed.first.dy);
        for (var i = 1; i < smoothed.length; i++) {
          rawPath.lineTo(smoothed[i].dx, smoothed[i].dy);
        }
      }
    }

    return _toDashedPath(rawPath, 12.0, 7.0);
  }

  static double _distToSegment(Offset p, Offset a, Offset b) {
    final ab = b - a;
    final ap = p - a;
    final lenSq = ab.dx * ab.dx + ab.dy * ab.dy;
    if (lenSq == 0) return (p - a).distance;
    final t = ((ap.dx * ab.dx + ap.dy * ab.dy) / lenSq).clamp(0.0, 1.0);
    final proj = Offset(a.dx + t * ab.dx, a.dy + t * ab.dy);
    return (p - proj).distance;
  }

  static List<Offset> _smoothPolyline(
    List<Offset> points, [
    int iterations = 2,
  ]) {
    if (points.length < 3) return points;
    var current = points;
    for (var it = 0; it < iterations; it++) {
      final smoothed = <Offset>[current.first];
      for (var i = 0; i < current.length - 1; i++) {
        final p0 = current[i];
        final p1 = current[i + 1];
        final q = Offset(
          0.75 * p0.dx + 0.25 * p1.dx,
          0.75 * p0.dy + 0.25 * p1.dy,
        );
        final r = Offset(
          0.25 * p0.dx + 0.75 * p1.dx,
          0.25 * p0.dy + 0.75 * p1.dy,
        );
        smoothed.add(q);
        smoothed.add(r);
      }
      smoothed.add(current.last);
      current = smoothed;
    }
    return current;
  }

  static List<List<Offset>> _chainSegments(List<(Offset, Offset)> segments) {
    final remaining = List<(Offset, Offset)>.from(segments);
    final polylines = <List<Offset>>[];

    while (remaining.isNotEmpty) {
      final first = remaining.removeLast();
      final line = <Offset>[first.$1, first.$2];
      var extended = true;

      while (extended) {
        extended = false;
        for (var i = 0; i < remaining.length; i++) {
          final seg = remaining[i];
          if ((line.last - seg.$1).distanceSquared < 4.0) {
            line.add(seg.$2);
            remaining.removeAt(i);
            extended = true;
            break;
          } else if ((line.last - seg.$2).distanceSquared < 4.0) {
            line.add(seg.$1);
            remaining.removeAt(i);
            extended = true;
            break;
          } else if ((line.first - seg.$2).distanceSquared < 4.0) {
            line.insert(0, seg.$1);
            remaining.removeAt(i);
            extended = true;
            break;
          } else if ((line.first - seg.$1).distanceSquared < 4.0) {
            line.insert(0, seg.$2);
            remaining.removeAt(i);
            extended = true;
            break;
          }
        }
      }
      polylines.add(line);
    }

    return polylines;
  }

  static Path _toDashedPath(Path source, double dashWidth, double dashSpace) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final len = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }
    return dest;
  }
}
