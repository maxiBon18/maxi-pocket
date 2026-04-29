import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_data_image_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart' show HomeWidgetConstants;

class MaxiPocketEmptyContentWidget extends StatelessWidget {
  const MaxiPocketEmptyContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const MaxiPocketEmptyDataImageWidget(),
          const SizedBox(height: DesignConstants.spacing24),
          Text(
            HomeWidgetConstants.emptyDataTitle,
            style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
