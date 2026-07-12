import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_content.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/error_content.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode, MaxiPocketExpensesType;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_widget.dart' show MaxiPocketListWidget;
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart' show getHomeWrapperCommitments;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_section_header_widget.dart'
    show MaxiPocketHomeSectionHeaderWidget;
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart' show MaxiPocketLoadingWidget;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;
import 'package:maxi_pocket/routes.dart' show Routes;

/// The home page displaying the current month's expense recap and summary cards.
@immutable
class MaxiPocketHomePage extends ConsumerWidget {
  const MaxiPocketHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<HomeEntity?> homeEntities = ref.watch(homeNotifierProvider);

    return MaxiPocketPage(
      routeName: Routes.homeRoute,
      showAppBar: true,
      showLeading: false,
      showBottomBar: true,
      allowBack: false,
      title: MaxiPocketAppBarTitle(
        title: HomeWidgetConstants.homePageTitle,
        subtitle: HomeWidgetConstants.homePageSubtitle,
        themeMode: themeMode,
      ),
      showFloatingActionButton: true,
      child: homeEntities.when(
        data: (HomeEntity? data) {
          return _HomeContent(themeMode: themeMode, isInError: false, data: data);
        },
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        error: (Object error, StackTrace stackTrace) => _HomeContent(themeMode: themeMode, isInError: true, data: null),
      ),
    );
  }
}

/// Main content column for the home page, shown once data has loaded.
///
/// When [isInError] is true, replaces the expense list with [_HomeErrorContent].
class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.themeMode, required this.isInError, required this.data});
  final MaxiPocketThemeMode themeMode;
  final bool isInError;
  final HomeEntity? data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeNotifier notifier = ref.watch(homeNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing16, vertical: DesignConstants.spacing24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: DesignConstants.spacing24),
          MaxiPocketHomeSectionHeaderWidget(isInError: isInError, numberOfExpenses: notifier.getNumberOfEvents()),
          const SizedBox(height: DesignConstants.spacing12),
          isInError
              ? const Expanded(child: MaxiPocketErrorContentWidget())
              : Expanded(
                  child: data == null || notifier.getNumberOfEvents() == 0
                      ? const MaxiPocketEmptyContentWidget()
                      : MaxiPocketListWidget(
                          themeMode: themeMode,
                          isFromHome: true,
                          entityToShow: getHomeWrapperCommitments(data, MaxiPocketExpensesType.all),
                          numberOfExpenses: notifier.getNumberOfEvents(),
                        ),
                ),
        ],
      ),
    );
  }
}
