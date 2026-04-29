import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart' show HomeEntity;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart' show MaxiPocketLoadingWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_content.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/error_content.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/expenses/presentation/ux/widgets/tab_bar_expenses_widget.dart'
    show MaxiPocketTabBarExpensesWidget;
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/routes.dart';

/// Displays active subscription expenses grouped into monthly and yearly tabs.
class MaxiPocketSubscriptionsPage extends ConsumerWidget {
  const MaxiPocketSubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<HomeEntity?> homeEntities = ref.watch(homeNotifierProvider);
    return MaxiPocketPage(
      routeName: Routes.expensesSubscriptionsRoute,
      allowBack: true,
      showLeading: true,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(title: ExpensesWidgetConstants.subscriptionsTitle, themeMode: themeMode),
      child: homeEntities.when(
        data: (HomeEntity? data) {
          if (data == null || ref.read(homeNotifierProvider.notifier).getNumberOfExpenses() == 0) {
            return const MaxiPocketEmptyContentWidget();
          }
          return MaxiPocketTabBarExpensesWidget(themeMode: themeMode);
        },
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        error: (Object error, StackTrace stackTrace) => const MaxiPocketErrorContentWidget(),
      ),
    );
  }
}
