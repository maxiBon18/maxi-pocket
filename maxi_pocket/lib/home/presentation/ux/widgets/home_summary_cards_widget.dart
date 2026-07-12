import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/card_widget.dart' show MaxiPocketSummaryCardWidget;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

/// A summary card showing the total expense amount for the current month.
@immutable
class MaxiPocketHomeSummaryCardsWidget extends StatelessWidget {
  const MaxiPocketHomeSummaryCardsWidget({required this.themeMode, required this.totalAmount, super.key});

  /// Controls the colour palette applied to both summary cards.
  final MaxiPocketThemeMode themeMode;

  /// Sum of all expenses due within the current calendar month.
  final double totalAmount;
  @override
  Widget build(BuildContext context) {
    return MaxiPocketSummaryCardWidget(
      themeMode: themeMode,
      label: HomeWidgetConstants.totalAmountCardSubtitle,
      amount: '${totalAmount.toStringAsFixed(2)} ${WidgetConstants.currencySymbol}',
      iconData: Icons.money_outlined,
    );
  }
}
