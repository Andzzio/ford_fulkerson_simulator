import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/painters/viewport_painter.dart';

class GraphViewport extends StatefulWidget {
  const new({super.key});

  @override
  State<GraphViewport> createState() => _GraphViewportState();
}

class _GraphViewportState extends State<GraphViewport> {
  late final TransformationController _controller;
  @override
  void initState() {
    super.initState();
    const double initialScale = 1.0;
    _controller = TransformationController(
      Matrix4.identity()..scaleByDouble(initialScale, initialScale, 1.0, 1.0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(8),
          border: Border.all(color: AppTheme.darkBorder, width: 2),
        ),
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 3.0,
          constrained: false,
          child: SizedBox(
            width: 3000,
            height: 3000,
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: ViewportPainter())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
