import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/expenses/presentation/ux/widgets/expenses_tile_widget.dart';
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/routes.dart';

/// Displays active subscription expenses grouped into monthly and yearly tabs.
class MaxiPocketSubscriptionsPage extends ConsumerWidget {
  const MaxiPocketSubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return MaxiPocketPage(
      routeName: Routes.expensesSubscriptionsRoute,
      allowBack: true,
      showLeading: true,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(title: ExpensesWidgetConstants.subscriptionsTitle, themeMode: themeMode),
      child: MaxiPocketExpensesTileWidget(themeMode: themeMode),
    );
  }
}
