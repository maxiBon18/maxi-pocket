import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/presentation/ux/widgets/add_expenses_widget.dart' show showAddExpensesBottomSheet;

/// The app-wide floating action button for adding a new expense.
///
/// Reads the active theme via [themeProvider] and delegates to
/// [showAddExpensesBottomSheet] on tap.
class MaxiPocketFloatingActionButtonWidget extends ConsumerWidget {
  const MaxiPocketFloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return FloatingActionButton.small(
      onPressed: () => showAddExpensesBottomSheet(context, themeMode),
      backgroundColor: ThemeDarkColors.primaryDarkColor,
      tooltip: WidgetConstants.floatingActionButtonTooltip,
      enableFeedback: true,
      splashColor: ThemeLightColors.primaryColor.withValues(alpha: DesignConstants.alpha30),
      elevation: 5,
      child: const Icon(
        Icons.add,
        color: ThemeLightColors.backgroundColor,
        size: DesignConstants.icon24,
        applyTextScaling: false,
      ),
    );
  }
}
