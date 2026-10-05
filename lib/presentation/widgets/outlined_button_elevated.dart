import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';

class OutlinedButtonElevated extends StatelessWidget {
  const OutlinedButtonElevated({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.isActive = false,
  }) : iconData = null,
       label = null,
       size = null;

  const OutlinedButtonElevated.icon({
    super.key,
    this.iconData,
    required this.label,
    required this.onPressed,
    this.color,
    this.isActive = false,
  }) : child = null,
       size = null;

  const OutlinedButtonElevated.iconOnly({
    super.key,
    required this.iconData,
    required this.onPressed,
    this.size = 40.0,
    this.color,
    this.isActive = false,
  }) : child = null,
       label = null;

  final Widget? child;
  final FaIconData? iconData;
  final String? label;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final isSquare = size != null;
    final effectiveColor = isActive ? (color ?? AppTheme.blueGreyHoverColor) : color;
    final buttonStyle = OutlinedButton.styleFrom(
      backgroundColor: effectiveColor,
      disabledBackgroundColor: effectiveColor,
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      padding: isSquare ? EdgeInsets.zero : null,
      minimumSize: isSquare ? Size.square(size!) : null,
      fixedSize: isSquare ? Size.square(size!) : null,
    );

    return Transform.translate(
      offset: Offset(0, isActive ? 3 : 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(8),
          boxShadow: isActive
              ? []
              : [
                  BoxShadow(
                    color: AppTheme.darkBorder,
                    blurRadius: 0,
                    offset: Offset(0, 3),
                  ),
                ],
        ),
        child: isSquare
            ? OutlinedButton(
                onPressed: onPressed,
                style: buttonStyle,
                child: FaIcon(iconData, size: 13),
              )
            : child != null
                ? OutlinedButton(
                    onPressed: onPressed,
                    style: buttonStyle,
                    child: child!,
                  )
                : OutlinedButton.icon(
                    icon: FaIcon(iconData, size: 13),
                    label: Text(label!),
                    onPressed: onPressed,
                    style: buttonStyle,
                  ),
      ),
    );
  }
}
