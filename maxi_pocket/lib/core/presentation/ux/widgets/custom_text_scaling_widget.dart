import 'package:flutter/widgets.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';

/// Constrains or disables system text scaling for its subtree by injecting a custom [MediaQueryData].
///
/// Use [blockText] to completely prevent scaling (e.g. for fixed-layout icons or badges), or
/// leave it `false` to allow scaling up to [maxTextScalerValue].
class MaxiPocketCustomTextScaling extends StatelessWidget {
  const MaxiPocketCustomTextScaling({
    required this.child,
    super.key,
    this.blockText = false,
    this.maxTextScalerValue = DesignConstants.appMaxTextScaler,
  });

  /// When `true`, disables text scaling entirely for the subtree via [TextScaler.noScaling].
  final bool blockText;

  /// Upper bound for the text scale factor when [blockText] is `false`.
  final double maxTextScalerValue;

  /// Widget subtree whose text scaling is controlled by this widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final MediaQueryData modifiedMediaQueryData = blockText
        ? mediaQueryData.copyWith(textScaler: TextScaler.noScaling)
        : mediaQueryData.copyWith(
            textScaler: mediaQueryData.textScaler.clamp(
              maxScaleFactor: maxTextScalerValue,
            ),
          );
    return MediaQuery(data: modifiedMediaQueryData, child: child);
  }
}
