import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;

/// A fixed-size coloured container that centres an icon or badge widget.
///
/// Used throughout the app to render expense category icons and onboarding illustrations
/// in a consistently sized and shaped box.
class MaxiPocketIconContainerWidget extends StatelessWidget {
  const MaxiPocketIconContainerWidget({
    required this.child,
    required this.colorBackground,
    super.key,
    this.width = DesignConstants.containerSize48,
    this.height = DesignConstants.containerSize48,
    this.shape = BoxShape.rectangle,
    this.useBorderRadius = true,
  });

  /// Widget displayed centred inside the container, typically an icon.
  final Widget child;

  /// Fill colour of the container background.
  final Color colorBackground;

  /// Explicit width of the container in logical pixels.
  final double width;

  /// Explicit height of the container in logical pixels.
  final double height;

  /// Whether the container renders as a rectangle or circle; defaults to [BoxShape.rectangle].
  final BoxShape shape;

  /// When `true` and [shape] is [BoxShape.rectangle], applies a rounded corner radius.
  final bool useBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignConstants.spacing12),
      alignment: .center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        color: colorBackground,
        borderRadius: useBorderRadius
            ? BorderRadius.circular(DesignConstants.radius12)
            : null,
      ),
      child: child,
    );
  }
}
