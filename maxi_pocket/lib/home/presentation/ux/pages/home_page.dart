import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/routes.dart' show Routes;

class MaxiPocketHomePage extends ConsumerWidget {
  const MaxiPocketHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxiPocketPage(
      routeName: Routes.homeRoute,
      child: Center(
        child: Column(
          children: [
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
