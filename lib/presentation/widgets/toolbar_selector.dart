import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:gap/gap.dart';

class ToolbarSelector extends StatefulWidget {
  const ToolbarSelector({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.onTap,
    this.isActive = false,
  });
  final String label;
  final FaIconData prefixIcon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  State<ToolbarSelector> createState() => _ToolbarSelectorState();
}

class _ToolbarSelectorState extends State<ToolbarSelector> {
  bool _isHovered = false;
  final double _buttonHeight = 40;
  @override
  Widget build(BuildContext context) {
    final styleMedium = Theme.of(context).textTheme.bodyMedium;
    final bool enabled = widget.onTap != null;
    return Tooltip(
      message: widget.label,
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          cursor: enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
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
          child: Transform.translate(
            offset: Offset(0, widget.isActive && enabled ? 3 : 0),
            child: Container(
              height: _buttonHeight,
              decoration: BoxDecoration(
                color: !enabled
                    ? Colors.grey
                    : _isHovered || widget.isActive
                    ? AppTheme.blueGreyHoverColor
                    : Colors.white,
                border: Border.all(color: AppTheme.darkBorder, width: 2),
                borderRadius: BorderRadiusGeometry.circular(8),
                boxShadow: !widget.isActive || !enabled
                    ? [
                        BoxShadow(
                          color: AppTheme.darkBorder,
                          blurRadius: 0,
                          offset: Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FaIcon(
                      widget.prefixIcon,
                      size: 13,
                      color: AppTheme.darkBorder,
                    ),
                    Gap(5),
                    Text(
                      widget.label,
                      style: styleMedium?.copyWith(color: AppTheme.darkBorder),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
