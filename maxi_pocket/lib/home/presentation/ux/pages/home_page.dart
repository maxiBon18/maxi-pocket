import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/shared/constants/routes.dart' show Routes;

class MaxiPocketHome extends StatelessWidget {
  const MaxiPocketHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaxiPocketPage(
      routeName: Routes.initialRoute,
      child: Center(child: Text('Home')),
    );
  }
}
