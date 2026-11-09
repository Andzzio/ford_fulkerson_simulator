import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:ford_fulkerson_simulator/presentation/models/simulation_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ResidualEdgesPainter extends CustomPainter {
  ResidualEdgesPainter({
    required this.edges,
    this.edgeColors = const {},
    this.currentFlows = const {},
    this.minCutPath,
  });

  final List<EdgeUi> edges;
  final Map<String, Color> edgeColors;
  final Map<String, int> currentFlows;
  final Path? minCutPath;

  static const double _laneOffset = 7.0;
  static const double _labelOffset = 16.0;
  static const double _arrowLength = 10.0;
  static const double _arrowHeight = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (minCutPath != null) {
      final glowPaint = Paint()
        ..color = Colors.redAccent.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      final cutPaint = Paint()
        ..color = Colors.redAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(minCutPath!, glowPaint);
      canvas.drawPath(minCutPath!, cutPaint);
    }

    for (final edge in edges) {
      final flow = currentFlows[edge.core.id] ?? edge.core.flow;
      final forwardResidual = edge.core.capacity - flow;

      // Arista directa en G_f: u → v con c_f = c - f (∞ en aristas ficticias).
      if (edge.isVirtual || forwardResidual > 0) {
        _drawResidualArrow(
          canvas,
          from: edge.fromPosition,
          to: edge.toPosition,
          label: edge.isVirtual ? '∞' : '$forwardResidual',
          color: edgeColors[edge.core.id] ?? AppTheme.darkBorder,
          dashed: edge.isVirtual,
        );
      }

      // Arista inversa en G_f: v → u con c_f = f.
      if (flow > 0) {
        _drawResidualArrow(
          canvas,
          from: edge.toPosition,
          to: edge.fromPosition,
          label: '$flow',
          color:
              edgeColors[SimulationState.residualBackKey(edge.core.id)] ??
              AppTheme.darkBorder,
          dashed: edge.isVirtual,
        );
      }
    }
  }

  /// Dibuja una flecha desplazada a su derecha, de modo que la arista directa
  /// y la inversa quedan en carriles paralelos sin superponerse.
  void _drawResidualArrow(
    Canvas canvas, {
    required Offset from,
    required Offset to,
    required String label,
    required Color color,
    required bool dashed,
  }) {
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final length = sqrt(dx * dx + dy * dy);
    if (length == 0) return;

    final normal = Offset(-dy / length, dx / length);
    final shift = normal * _laneOffset;
    final p1 = from + shift;
    final p2 = to + shift;

    final strokeWidth = dashed ? 2.5 : 3.0;
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (dashed) {
      _drawDashedLine(canvas, p1, p2, linePaint);
    } else {
      canvas.drawLine(p1, p2, linePaint);
    }

    final midPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
    canvas.save();
    canvas.translate(midPoint.dx, midPoint.dy);
    canvas.rotate(atan2(dy, dx));
    final arrowPath = Path()
      ..moveTo(-_arrowLength, -(_arrowHeight / 2))
      ..lineTo(0, 0)
      ..lineTo(-_arrowLength, _arrowHeight / 2);
    canvas.drawPath(arrowPath, arrowPaint);
    canvas.restore();

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: GoogleFonts.getFont(
          AppTheme.mainFont,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    final labelCenter = midPoint + normal * _labelOffset;
    textPainter.paint(
      canvas,
      labelCenter - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const dashWidth = 8.0;
    const dashSpace = 6.0;
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    final distance = sqrt(dx * dx + dy * dy);
    if (distance == 0) return;
    final ux = dx / distance;
    final uy = dy / distance;
    var start = 0.0;
    while (start < distance) {
      final end = min(start + dashWidth, distance);
      canvas.drawLine(
        Offset(p1.dx + ux * start, p1.dy + uy * start),
        Offset(p1.dx + ux * end, p1.dy + uy * end),
        paint,
      );
      start += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant ResidualEdgesPainter oldDelegate) {
    return edges != oldDelegate.edges ||
        edgeColors != oldDelegate.edgeColors ||
        currentFlows != oldDelegate.currentFlows ||
        minCutPath != oldDelegate.minCutPath;
  }
}
