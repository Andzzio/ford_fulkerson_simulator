import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';

class AppInfoBadge extends StatelessWidget {
  const AppInfoBadge({
    super.key,
    required this.child,
    this.height,
    this.padding = const EdgeInsets.all(4),
  });

  AppInfoBadge.text({
    super.key,
    required String text,
    this.height,
    this.padding = const EdgeInsets.all(4),
    TextStyle? style,
  }) : child = Text(text, style: style);

  final Widget child;
  final double? height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.darkBorder, width: 2),
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      alignment: height != null ? Alignment.center : null,
      child: child,
    );
  }
}
