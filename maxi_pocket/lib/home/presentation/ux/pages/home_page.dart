import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/switch_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/routes.dart' show Routes;

class MaxiPocketHomePage extends ConsumerWidget {
  const MaxiPocketHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final bool isDarkMode = themeMode == MaxiPocketThemeMode.dark;
    return MaxiPocketPage(
      routeName: Routes.homeRoute,
      child: Center(
        child: Column(
          children: [
            MaxiPocketSwitchWidget(
              value: isDarkMode,
              onChanged: (bool? value) {
                if (value != null) {
                  ref
                      .read(themeProvider.notifier)
                      .setThemeMode(value ? MaxiPocketThemeMode.dark : MaxiPocketThemeMode.light);
                }
              },
            ),
            // TODO: delete this
            FilledButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.notFoundRoute),
              child: Text(WidgetConstants.notFoundPageTitle),
            ),
          ],
        ),
      ),
    );
  }
}
