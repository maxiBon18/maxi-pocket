import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/list_widget.dart' show MaxiPocketListWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/recap_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_summary_cards_widget.dart'
    show MaxiPocketHomeSummaryCardsWidget;

/// A section layout combining a recap card with a scrollable tile list.
///
/// [isAppointment] switches labels and color tokens to appointment-specific
/// values and adds extra horizontal padding suited to the appointments page.
class MaxiPocketSectionPage extends StatelessWidget {
  const MaxiPocketSectionPage({
    required this.themeMode,
    required this.numberOfExpenses,
    required this.entityToShow,
    super.key,
    this.totalAmountOfExpense,
    this.isAppointment = false,
    this.onEdit,
    this.onDelete,
  });

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;
  final double? totalAmountOfExpense;
  final int numberOfExpenses;
  final List<WrapperCommitmentsEntity> entityToShow;
  final void Function(CommitmentsEntity entity)? onEdit;
  final void Function(CommitmentsEntity entity)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignConstants.spacing16),
      child: _MaxiPocketSectionContent(
        themeMode: themeMode,
        isAppointment: isAppointment,
        totalAmountOfExpense: totalAmountOfExpense,
        numberOfCommitments: numberOfExpenses,
        entityToShow: entityToShow,
        onEdit: onEdit,
        onDelete: onDelete,
      ),
    );
  }
}

/// Renders the recap card for appointments or the summary cards for expenses,
/// followed by the shared tile list.
class _MaxiPocketSectionContent extends StatelessWidget {
  const _MaxiPocketSectionContent({
    required this.themeMode,
    required this.isAppointment,
    required this.numberOfCommitments,
    required this.entityToShow,
    this.totalAmountOfExpense,
    this.onEdit,
    this.onDelete,
  });

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;
  final double? totalAmountOfExpense;
  final int numberOfCommitments;
  final List<WrapperCommitmentsEntity> entityToShow;
  final void Function(CommitmentsEntity entity)? onEdit;
  final void Function(CommitmentsEntity entity)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (isAppointment)
          MaxiPocketRecapWidget(
            numberOfCommitments: numberOfCommitments,
            amount: totalAmountOfExpense,
            themeMode: themeMode,
            isAppointment: isAppointment,
          ),
        if (!isAppointment)
          MaxiPocketHomeSummaryCardsWidget(themeMode: themeMode, totalAmount: totalAmountOfExpense ?? 0),
        const SizedBox(height: DesignConstants.spacing16),
        Expanded(
          child: MaxiPocketListWidget(
            themeMode: themeMode,
            isFromHome: false,
            numberOfExpenses: numberOfCommitments,
            entityToShow: entityToShow,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ),
      ],
    );
  }
}
