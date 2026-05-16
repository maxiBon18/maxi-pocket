import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart';

/// Full-screen overlay that blocks all interaction while an operation is in progress.
///
/// Prevents the user from navigating away via [PopScope] and tints the background
/// using the active theme's on-surface colour at 70 % opacity.
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
