import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class EdgesPainter extends CustomPainter {
  EdgesPainter({
    required this.edges,
    this.edgeColors = const {},
    this.currentFlows = const {},
    this.minCutPath,
  });

  final List<EdgeUi> edges;
  final Map<String, Color> edgeColors;
  final Map<String, int> currentFlows;
  final Path? minCutPath;

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

    final arrowLength = 10.0;
    final arrowHeight = 15.0;
    final textSpacing = 10.0;

    for (final EdgeUi edge in edges) {
      final edgeColor = edgeColors[edge.core.id] ?? AppTheme.darkBorder;
      final flow = currentFlows[edge.core.id] ?? edge.core.flow;
      const strokeWidth = 4.0;

      final paint = Paint()
        ..color = edgeColor
        ..strokeWidth = strokeWidth;
      final arrowPaint = Paint()
        ..color = edgeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final textSpan = TextSpan(
        text: '(${edge.core.capacity},$flow)',
        style: GoogleFonts.getFont(
          AppTheme.mainFont,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: edgeColor,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();
      canvas.drawLine(edge.fromPosition, edge.toPosition, paint);
      final dx = edge.toPosition.dx - edge.fromPosition.dx;
      final dy = edge.toPosition.dy - edge.fromPosition.dy;
      final angle = atan2(dy, dx);
      final midPoint = Offset(
        (edge.fromPosition.dx + edge.toPosition.dx) / 2,
        (edge.fromPosition.dy + edge.toPosition.dy) / 2,
      );
      canvas.save();
      canvas.translate(midPoint.dx, midPoint.dy);
      canvas.rotate(angle);
      final arrowPath = Path()
        ..moveTo(-arrowLength, -(arrowHeight / 2))
        ..lineTo(0, 0)
        ..lineTo(-arrowLength, (arrowHeight / 2));
      canvas.drawPath(arrowPath, arrowPaint);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height - textSpacing),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant EdgesPainter oldDelegate) {
    return edges != oldDelegate.edges ||
        edgeColors != oldDelegate.edgeColors ||
        currentFlows != oldDelegate.currentFlows ||
        minCutPath != oldDelegate.minCutPath;
  }
}
