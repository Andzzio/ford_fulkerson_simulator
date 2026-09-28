import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:gap/gap.dart';

class AppPopupMenuButton<T> extends StatefulWidget {
  const AppPopupMenuButton({
    super.key,
    required this.label,
    this.prefixIcon,
    this.onSelected,
    this.items = const [],
  });
  final FaIconData? prefixIcon;
  final String label;
  final List<PopupMenuItem<T>> items;
  final void Function(T)? onSelected;

  @override
  State<AppPopupMenuButton<T>> createState() => _AppPopupMenuButtonState<T>();
}

class _AppPopupMenuButtonState<T> extends State<AppPopupMenuButton<T>> {
  bool _isHovered = false;
  final double _buttonHeight = 40.0;
  @override
  Widget build(BuildContext context) {
    final styleMedium = Theme.of(context).textTheme.bodyMedium;
    return PopupMenuButton<T>(
      offset: Offset(0, _buttonHeight + 8),
      tooltip: widget.label,
      itemBuilder: (context) {
        return widget.items;
      },
      onSelected: widget.onSelected,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
        child: Container(
          height: _buttonHeight,
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.blueGreyHoverColor : Colors.white,
            border: Border.all(
              color: _isHovered ? AppTheme.darkBorder : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FaIcon(
                  widget.prefixIcon,
                  size: 13,
                  color: _isHovered ? AppTheme.darkBorder : Colors.blueAccent,
                ),
                Gap(5),
                Text(
                  widget.label,
                  style: styleMedium?.copyWith(
                    color: _isHovered ? AppTheme.darkBorder : Colors.blueAccent,
                  ),
                ),
                Gap(10),
                FaIcon(
                  FontAwesomeIcons.angleDown,
                  size: 13,
                  color: _isHovered ? AppTheme.darkBorder : Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
