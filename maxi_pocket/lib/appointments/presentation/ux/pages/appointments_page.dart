import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/appointments/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/routes.dart';

/// Entry point for the appointments feature, rendered inside the shared page shell.
///
/// Shows a placeholder until the appointments domain is connected. Hides the back
/// arrow and bottom navigation is always visible because this is a root destination.
class MaxiPocketAppointmentsPage extends ConsumerWidget {
  const MaxiPocketAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    return MaxiPocketPage(
      routeName: Routes.appointmentsRoute,
      allowBack: false,
      showLeading: false,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(
        title: AppointmentsWidgetConstants.appointmentsTitle,
        subtitle: AppointmentsWidgetConstants.appointmentsSubtitle,
        themeMode: themeMode,
      ),
      child: const Center(child: Text('Appointments page')),
    );
  }
}
