import 'package:flutter/material.dart';

class ViewportPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey;
    final double spacing = 20;
    final radius = 1.0;
    for (double i = spacing; i < size.height - spacing; i += spacing) {
      for (double j = spacing; j < size.width - spacing; j += spacing) {
        canvas.drawCircle(Offset(j, i), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ViewportPainter oldDelegate) {
    return false;
  }
}
