import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/models/node_ui.dart';

class NodeWidget extends StatefulWidget {
  const NodeWidget({super.key, required this.node});
  final NodeUi node;

  @override
  State<NodeWidget> createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final diameter = widget.node.radius * 2;
    return Tooltip(
      message: widget.node.label,
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovered = false;
          });
        },
        cursor: SystemMouseCursors.grab,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.blueGreyHoverColor : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.darkBorder, width: 3),
          ),
          child: Center(
            child: Text(
              widget.node.label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
