import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

@immutable
class MaxiPocketHomeSectionHeaderWidget extends StatelessWidget {
  const MaxiPocketHomeSectionHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(HomeWidgetConstants.weeklyRecapTitle, style: context.textTheme.titleLarge),
        Expanded(
          child: Text(
            HomeWidgetConstants.expenses,
            textAlign: TextAlign.end,
            style: context.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
