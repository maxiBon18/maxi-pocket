import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// Wraps [child] in a [DecoratedBox] with a themed top border and outer drop shadows.
class MaxiPocketBoxDecorationWidget extends StatelessWidget {
  const MaxiPocketBoxDecorationWidget({
    required this.child, required this.themeMode, required this.border, required this.boxShadows, super.key,
    this.borderRadius,
  });

  final Widget child;
  final MaxiPocketThemeMode themeMode;
  final BorderRadiusGeometry? borderRadius;
  final Border border;
  final List<BoxShadow> boxShadows;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, border: border, boxShadow: boxShadows),
      child: child,
    );
  }
}
