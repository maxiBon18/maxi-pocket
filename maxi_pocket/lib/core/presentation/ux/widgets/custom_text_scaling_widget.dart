import 'package:flutter/widgets.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';

class MaxiPocketCustomTextScaling extends StatelessWidget {
  const MaxiPocketCustomTextScaling({
    required this.child,
    super.key,
    this.blockText = false,
    this.maxTextScalerValue = DesignConstants.appMaxTextScaler,
  });

  final bool blockText;
  final double maxTextScalerValue;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final MediaQueryData modifiedMediaQueryData = blockText
        ? mediaQueryData.copyWith(textScaler: TextScaler.noScaling)
        : mediaQueryData.copyWith(
            textScaler: mediaQueryData.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: maxTextScalerValue),
          );
    return MediaQuery(data: modifiedMediaQueryData, child: child);
  }
}
