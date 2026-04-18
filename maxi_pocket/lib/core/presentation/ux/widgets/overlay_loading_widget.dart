import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart';

class MaxiPocketOverlayLoadingWidget extends ConsumerWidget {
  const MaxiPocketOverlayLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return PopScope(
      canPop: false,
      child: Material(
        type: MaterialType.canvas,
        color: themeMode == MaxiPocketThemeMode.light
            ? ThemeLightColors.onSurfaceColor.withValues(alpha: 0.7)
            : ThemeDarkColors.onSurfaceColor.withValues(alpha: 0.7),
        child: const Center(child: MaxiPocketLoadingWidget()),
      ),
    );
  }
}

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
