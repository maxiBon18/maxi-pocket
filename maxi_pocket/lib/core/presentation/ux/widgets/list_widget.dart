import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/presentation/ux/widgets/wrapper_tile_widget.dart' show MaxiPocketWrapperTileWidget;

/// A scrollable separated list of [MaxiPocketWrapperTileWidget] tiles.
///
/// Currently renders [_placeholderItemCount] placeholder items.
/// Replace with data from a ViewModel once the domain layer is wired.
@immutable
class MaxiPocketListWidget extends StatelessWidget {
  const MaxiPocketListWidget({super.key, required this.themeMode, this.isAppointment = false});

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;

  static const int _placeholderItemCount = 6;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            MaxiPocketWrapperTileWidget(key: ValueKey(index), themeMode: themeMode, isAppointment: isAppointment),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: DesignConstants.spacing12),
        itemCount: _placeholderItemCount,
      ),
    );
  }
}
