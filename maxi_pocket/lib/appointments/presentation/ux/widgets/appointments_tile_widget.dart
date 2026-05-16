import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode;

/// A list tile representing a single appointment entry.
@immutable
class MaxiPocketAppointmentsTileWidget extends StatelessWidget {
  const MaxiPocketAppointmentsTileWidget({required this.themeMode, super.key});

  /// Controls the color palette applied to the tile.
  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
