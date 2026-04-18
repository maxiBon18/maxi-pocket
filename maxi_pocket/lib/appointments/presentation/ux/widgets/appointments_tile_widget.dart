import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/wrapper_tile_widget.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// A list tile representing a single appointment entry.
@immutable
class MaxiPocketAppointmentsTileWidget extends StatelessWidget {
  const MaxiPocketAppointmentsTileWidget({required this.themeMode, super.key});

  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaxiPocketWrapperTileWidget(themeMode: themeMode, isAppointment: true);
  }
}
