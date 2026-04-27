import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;

/// A fixed-size circular progress indicator using the primary brand colour.
class MaxiPocketLoadingWidget extends StatelessWidget {
  const MaxiPocketLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: DesignConstants.loadingSize,
      width: DesignConstants.loadingSize,
      child: CircularProgressIndicator(color: ThemeLightColors.primaryColor),
    );
  }
}

/// A fixed-size circular progress indicator styled for the splash screen background.
class MaxiPocketSplashLoadingWidget extends StatelessWidget {
  const MaxiPocketSplashLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: DesignConstants.loadingSize,
      width: DesignConstants.loadingSize,
      child: CircularProgressIndicator(color: ThemeLightColors.onSurfaceVariantColor),
    );
  }
}
