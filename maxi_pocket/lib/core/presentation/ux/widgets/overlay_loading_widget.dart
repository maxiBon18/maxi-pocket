import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeColors;

class MaxiPocketOverlayLoadingWidget extends StatelessWidget {
  const MaxiPocketOverlayLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Material(
        type: MaterialType.canvas,
        color: ThemeColors.onSurfaceColor.withValues(alpha: 0.7),
        child: Center(child: MaxiPocketLoadingWidget()),
      ),
    );
  }
}

class MaxiPocketLoadingWidget extends StatelessWidget {
  const MaxiPocketLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 48, width: 48, child: CircularProgressIndicator(color: ThemeColors.primaryColor));
  }
}
