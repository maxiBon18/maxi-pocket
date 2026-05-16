import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_data_image_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/extensions.dart'
    show BuildContextExtension;
import 'package:maxi_pocket/home/shared/constants/widget_constants.dart'
    show HomeWidgetConstants;

/// Centred placeholder shown when a list has no data to display.
///
/// Renders the empty-state animation and a context-appropriate message — either
/// the appointments empty label or the generic data empty label depending on [isAppointment].
class MaxiPocketEmptyContentWidget extends StatelessWidget {
  const MaxiPocketEmptyContentWidget({super.key, this.isAppointment = false});

  /// When `true`, displays the appointments-specific empty message instead of the generic one.
  final bool isAppointment;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Flexible(
            fit: FlexFit.loose,
            child: MaxiPocketEmptyDataImageWidget(),
          ),
          const SizedBox(height: DesignConstants.spacing8),
          Text(
            isAppointment
                ? HomeWidgetConstants.emptyAppointmentsTitle
                : HomeWidgetConstants.emptyDataTitle,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
