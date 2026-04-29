import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/presentation/ux/widgets/wrapper_tile_widget.dart' show MaxiPocketWrapperTileWidget;

/// A scrollable separated list of [MaxiPocketWrapperTileWidget] tiles.
///
/// Currently renders [_placeholderItemCount] placeholder items.
/// Replace with data from a ViewModel once the domain layer is wired.
@immutable
class MaxiPocketListWidget extends StatelessWidget {
  const MaxiPocketListWidget({
    required this.themeMode,
    required this.entityToShow,
    required this.numberOfExpenses,
    super.key,
    this.isAppointment = false,
    this.isFromHome = false,
  });

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;
  final List<WrapperCommitmentsEntity> entityToShow;
  final int numberOfExpenses;
  final bool isFromHome;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) => MaxiPocketWrapperTileWidget(
          key: ValueKey<int>(index),
          themeMode: themeMode,
          isAppointment: isAppointment,
          entityToShow: entityToShow[index].commitments,
          type: entityToShow[index].type,
          isFromHome: isFromHome,
        ),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: DesignConstants.spacing12),
        itemCount: numberOfExpenses,
      ),
    );
  }
}
