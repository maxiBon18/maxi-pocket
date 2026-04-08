import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;

class MaxiPocketIconContainerWidget extends StatelessWidget {
  const MaxiPocketIconContainerWidget({
    super.key,
    required this.child,
    required this.colorBackground,
    this.width = DesignConstants.containerSize48,
    this.height = DesignConstants.containerSize48,
    this.shape = BoxShape.rectangle,
    this.useBorderRadius = true,
  });

  final Widget child;
  final Color colorBackground;
  final double width;
  final double height;
  final BoxShape shape;
  final bool useBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DesignConstants.spacing12),
      alignment: .center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        color: colorBackground,
        borderRadius: useBorderRadius ? BorderRadius.circular(DesignConstants.radius12) : null,
      ),
      child: child,
    );
  }
}
