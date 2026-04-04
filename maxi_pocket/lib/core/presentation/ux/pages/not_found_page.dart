import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_data_image_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/routes.dart' show Routes;

/// Fallback page shown when a route is not found.
class MaxiPocketNotFoundPage extends StatelessWidget {
  const MaxiPocketNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxiPocketPage(
      routeName: Routes.notFoundRoute,
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          const MaxiPocketEmptyDataImageWidget(),
          const SizedBox(height: DesignConstants.spacingMedium),
          Text(
            WidgetConstants.notFoundErrorCode,
            style: context.textTheme.displayLarge!.copyWith(color: ThemeLightColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignConstants.spacing),
          Text(WidgetConstants.notFoundPageTitle, style: context.textTheme.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: DesignConstants.spacing),
          Text(
            WidgetConstants.notFoundPageDescription,
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
