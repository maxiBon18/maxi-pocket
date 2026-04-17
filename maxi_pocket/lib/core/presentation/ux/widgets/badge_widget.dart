import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension, DoubleExtension;

@immutable
class MaxiPocketBadgeWidget extends StatelessWidget {
  const MaxiPocketBadgeWidget({
    super.key,
    required this.label,
    this.expensesType = MaxiPocketExpensesType.subscription,
  });

  final String label;
  final MaxiPocketExpensesType expensesType;

  Color _getBackgroundColor() {
    switch (expensesType) {
      case MaxiPocketExpensesType.subscription:
        return ThemeLightColors.primaryLightColor;
      case MaxiPocketExpensesType.financing:
        return ThemeLightColors.badgeFinancingBackgroundColor;
      case MaxiPocketExpensesType.appointments:
        return ThemeLightColors.appointmentsBadgeBackgroundColor;
      default:
        return ThemeLightColors.primaryLightColor;
    }
  }

  Color _getTextColor() {
    switch (expensesType) {
      case MaxiPocketExpensesType.subscription:
        return ThemeLightColors.errorColor;
      case MaxiPocketExpensesType.financing:
        return ThemeLightColors.secondaryDarkColor;
      case MaxiPocketExpensesType.appointments:
        return ThemeLightColors.textPrimaryColor;
      default:
        return ThemeLightColors.errorColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: DesignConstants.spacing8, vertical: DesignConstants.spacing4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(DesignConstants.radius40)),
      ),
      height: screenSize.responsiveHeight(DesignConstants.containerSize24),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(color: _getTextColor()),
        textAlign: .center,
      ),
    );
  }
}
