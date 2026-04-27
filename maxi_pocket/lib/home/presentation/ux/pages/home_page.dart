import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_data_image_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_widget.dart' show MaxiPocketListWidget;
import 'package:maxi_pocket/core/domain/entities/home_entity.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_section_header_widget.dart'
    show MaxiPocketHomeSectionHeaderWidget;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_summary_cards_widget.dart'
    show MaxiPocketHomeSummaryCardsWidget;
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart' show MaxiPocketLoadingWidget;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;
import 'package:maxi_pocket/routes.dart' show Routes;

/// The home page displaying the weekly expense recap and summary cards.
@immutable
class MaxiPocketHomePage extends ConsumerWidget {
  const MaxiPocketHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<List<HomeEntity>> homeEntities = ref.watch(homeNotifierProvider);

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
        data: (List<HomeEntity> data) {
          return _HomeContent(themeMode: themeMode, isInError: false);
        },
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        error: (Object error, StackTrace stackTrace) => _HomeContent(themeMode: themeMode, isInError: true),
      ),
    );
  }
}

/// Main content column for the home page, shown once data has loaded.
///
/// When [isInError] is true, replaces the expense list with [_HomeErrorContent].
class _HomeContent extends ConsumerWidget {
  const _HomeContent({required this.themeMode, required this.isInError});
  final MaxiPocketThemeMode themeMode;
  final bool isInError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeNotifier notifier = ref.watch(homeNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing16, vertical: DesignConstants.spacing24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MaxiPocketHomeSummaryCardsWidget(
            themeMode: themeMode,
            isInError: isInError,
            monthlyAmount: notifier.monthlyAmount,
            weeklyAmount: notifier.weeklyAmount,
          ),
          const SizedBox(height: DesignConstants.spacing24),
          MaxiPocketHomeSectionHeaderWidget(
            isInError: isInError,
            numberOfExpenses: notifier.getNumberOfExpenses(),
          ),
          const SizedBox(height: DesignConstants.spacing12),
          isInError
              ? const Expanded(child: _HomeErrorContent())
              : Expanded(
                  child: MaxiPocketListWidget(
                    themeMode: themeMode,
                    entityToShow: notifier.getHomeWeeklyWrapperCommitments(),
                    isAppointment: false,
                    numberOfExpenses: notifier.getNumberOfExpenses(),
                  ),
                ),
        ],
      ),
    );
  }
}

/// Centred placeholder shown when [homeNotifierProvider] returns an error.
class _HomeErrorContent extends StatelessWidget {
  const _HomeErrorContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const MaxiPocketEmptyDataImageWidget(),
          const SizedBox(height: DesignConstants.spacing24),
          Text(
            HomeWidgetConstants.errorPlaceholderTitle,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: DesignConstants.spacing8),
          Text(
            HomeWidgetConstants.errorPlaceholderDescription,
            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
