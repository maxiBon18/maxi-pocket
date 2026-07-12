import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

/// Section header row showing the monthly recap title and the current expense count.
///
/// Displays a fallback placeholder when [isInError] is true instead of the live count.
@immutable
class MaxiPocketHomeSectionHeaderWidget extends StatelessWidget {
  const MaxiPocketHomeSectionHeaderWidget({required this.isInError, required this.numberOfExpenses, super.key});

  /// When true, replaces the expense count with an error placeholder string.
  final bool isInError;

  /// Total number of commitments due within the current month.
  final int numberOfExpenses;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(HomeWidgetConstants.monthlyRecapTitle, style: context.textTheme.titleLarge),
        Expanded(
          child: Text(
            isInError
                ? HomeWidgetConstants.expensesErrorPlaceholder
                : '${HomeWidgetConstants.events} $numberOfExpenses ',
            textAlign: TextAlign.end,
            style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
