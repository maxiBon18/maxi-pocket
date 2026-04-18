import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/recap_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/wrapper_tile_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;

/// A section layout combining a recap card with a scrollable tile list.
///
/// [isAppointment] switches labels and color tokens to appointment-specific
/// values and adds extra horizontal padding suited to the appointments page.
class MaxiPocketSectionPage extends StatelessWidget {
  const MaxiPocketSectionPage({required this.themeMode, super.key, this.isAppointment = false});

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignConstants.spacing16),
      child: isAppointment == false
          ? _MaxiPocketSectionContent(themeMode: themeMode, isAppointment: isAppointment)
          : Padding(
              padding: const EdgeInsets.all(DesignConstants.spacing16),
              child: _MaxiPocketSectionContent(themeMode: themeMode, isAppointment: isAppointment),
            ),
    );
  }
}

class _MaxiPocketSectionContent extends StatelessWidget {
  const _MaxiPocketSectionContent({required this.themeMode, required this.isAppointment});

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaxiPocketRecapWidget(value: 100, themeMode: themeMode, isAppointment: isAppointment),
        const SizedBox(height: DesignConstants.spacing16),
        MaxiPocketWrapperTileWidget(themeMode: themeMode, isAppointment: isAppointment),
      ],
    );
  }
}
