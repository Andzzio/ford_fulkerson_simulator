import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/models/edge_ui.dart';

class EdgesPainter extends CustomPainter {
  EdgesPainter({required this.edges});
  final List<EdgeUi> edges;
  @override
  void paint(Canvas canvas, Size size) {
    final arrowLength = 10.0;
    final arrowHeight = 15.0;
    final paint = Paint()
      ..color = AppTheme.darkBorder
      ..strokeWidth = 4;
    final arrowPaint = Paint()
      ..color = AppTheme.darkBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    for (final EdgeUi edge in edges) {
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
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant EdgesPainter oldDelegate) {
    return edges != oldDelegate.edges;
  }
}
