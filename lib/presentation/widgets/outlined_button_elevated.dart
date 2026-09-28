import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';

class OutlinedButtonElevated extends StatelessWidget {
  const OutlinedButtonElevated({
    super.key,
    required this.iconData,
    required this.label,
    required this.onPressed,
  });
  final FaIconData iconData;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBorder,
            blurRadius: 0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: OutlinedButton.icon(
        icon: FaIcon(iconData, size: 13),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
