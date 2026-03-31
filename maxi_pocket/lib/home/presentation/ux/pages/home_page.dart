import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/routes.dart' show Routes;

class MaxiPocketHomePage extends StatelessWidget {
  const MaxiPocketHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaxiPocketPage(
      routeName: Routes.homeRoute,
      child: Center(child: Text('Home')),
    );
  }
}
