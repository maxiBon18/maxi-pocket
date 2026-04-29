import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_data_image_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

/// Centred placeholder shown when [homeNotifierProvider] returns an error.
class MaxiPocketErrorContentWidget extends StatelessWidget {
  const MaxiPocketErrorContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const MaxiPocketEmptyDataImageWidget(),
          const SizedBox(height: DesignConstants.spacing24),
          Text(
            HomeWidgetConstants.errorPlaceholderTitle,
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: DesignConstants.spacing8),
          Text(
            HomeWidgetConstants.errorPlaceholderDescription,
            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
