import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;

/// Small filled circle used as a bullet in pointed lists.
class MaxiPocketBulletPointWidget extends StatelessWidget {
  const MaxiPocketBulletPointWidget({required this.color, super.key, this.size = DesignConstants.spacing8});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox(width: size, height: size),
    );
  }
}
