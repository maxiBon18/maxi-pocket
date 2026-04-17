import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_widget.dart' show MaxiPocketListWidget;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_section_header_widget.dart'
    show MaxiPocketHomeSectionHeaderWidget;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_summary_cards_widget.dart'
    show MaxiPocketHomeSummaryCardsWidget;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;
import 'package:maxi_pocket/routes.dart' show Routes;

@immutable
class MaxiPocketHomePage extends ConsumerWidget {
  const MaxiPocketHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing16, vertical: DesignConstants.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaxiPocketHomeSummaryCardsWidget(themeMode: themeMode),
            const SizedBox(height: DesignConstants.spacing24),
            const MaxiPocketHomeSectionHeaderWidget(),
            const SizedBox(height: DesignConstants.spacing12),
            Expanded(child: MaxiPocketListWidget(themeMode: themeMode)),
          ],
        ),
      ),
    );
  }
}
