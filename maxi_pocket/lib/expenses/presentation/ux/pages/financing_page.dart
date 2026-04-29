import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/section_page.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_content.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/error_content.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/routes.dart';

/// Displays active financing expenses grouped into monthly and yearly tabs.
class MaxiPocketFinancingPage extends ConsumerWidget {
  const MaxiPocketFinancingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<HomeEntity?> homeEntities = ref.watch(homeNotifierProvider);
    return MaxiPocketPage(
      routeName: Routes.expensesFinancingRoute,
      allowBack: true,
      showLeading: true,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(title: ExpensesWidgetConstants.financingsTitle, themeMode: themeMode),
      child: homeEntities.when(
        data: (HomeEntity? data) {
          if (data == null || ref.read(homeNotifierProvider.notifier).getNumberOfExpenses() == 0) {
            return const MaxiPocketEmptyContentWidget();
          }
          return MaxiPocketSectionPage(themeMode: themeMode);
        },
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        error: (Object error, StackTrace stackTrace) => const MaxiPocketErrorContentWidget(),
      ),
    );
  }
}
