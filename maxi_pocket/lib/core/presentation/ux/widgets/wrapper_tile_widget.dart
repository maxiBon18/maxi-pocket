import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeDarkColors, ThemeLightColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/widgets/badge_widget.dart' show MaxiPocketBadgeWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart' show MaxiPocketListTileWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketExpensesType, MaxiPocketThemeMode, MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension;

/// A list tile displaying an expense or appointment item with edit and delete actions.
///
/// [isAppointment] hides the monetary amount and switches badge and date
/// labels to their appointment equivalents. Placeholder data is used until
/// a ViewModel is connected.
@immutable
class MaxiPocketWrapperTileWidget extends StatelessWidget {
  const MaxiPocketWrapperTileWidget({
    required this.themeMode,
    required this.entityToShow,
    required this.type,
    super.key,
    this.isAppointment = false,
  });

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;
  final CommitmentsEntity entityToShow;
  final MaxiPocketExpensesType type;

  Color get _iconColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.textSecondaryColor
      : ThemeDarkColors.onSurfaceVariantColor;

  Color get _amountColor =>
      themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.onSurfaceColor : ThemeDarkColors.onSurfaceColor;

  String _getTitle() {
    if (entityToShow is SubscriptionEntity) {
      return (entityToShow as SubscriptionEntity).commitmentEntity.name;
    } else if (entityToShow is FinancingEntity) {
      return (entityToShow as FinancingEntity).commitmentEntity.name;
    } else {
      return (entityToShow as AppointmentEntity).commitmentEntity.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaxiPocketListTileWidget(
      title: Text(_getTitle(), style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: _ExpenseTileSubtitle(
        iconColor: _iconColor,
        isAppointment: isAppointment,
        themeMode: themeMode,
        type: type,
        entityToShow: entityToShow,
      ),
      trailing: _MaxiPocketTileTrailing(
        isAppointment: isAppointment,
        iconColor: _iconColor,
        amountColor: _amountColor,
        type: type,
        entityToShow: entityToShow,
      ),
      isThreeLine: true,
      themeMode: themeMode,
    );
  }
}

/// Trailing column showing the formatted amount and edit/delete icon buttons.
///
/// The amount row is hidden when [isAppointment] is true.
@immutable
class _MaxiPocketTileTrailing extends StatelessWidget {
  const _MaxiPocketTileTrailing({
    required this.isAppointment,
    required this.iconColor,
    required this.amountColor,
    required this.type,
    required this.entityToShow,
  });

  final bool isAppointment;
  final Color iconColor;
  final Color amountColor;
  final MaxiPocketExpensesType type;
  final CommitmentsEntity entityToShow;

  double _getAmount() {
    if (entityToShow is SubscriptionEntity) {
      return (entityToShow as SubscriptionEntity).amount;
    } else if (entityToShow is FinancingEntity) {
      return (entityToShow as FinancingEntity).amount;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (!isAppointment)
          Text(
            _getAmount().toStringAsFixed(2),
            style: ThemeTextStyles.monetaryAmountSmallLight.copyWith(color: amountColor),
          ),
        if (!isAppointment) const SizedBox(height: DesignConstants.spacing8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.edit_outlined, color: iconColor, size: DesignConstants.icon24, applyTextScaling: false),
            ),
            const SizedBox(width: DesignConstants.spacing12),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.delete_outlined,
                color: iconColor,
                size: DesignConstants.icon24,
                applyTextScaling: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Subtitle showing type and frequency badges above the next-payment or next-appointment date.
@immutable
class _ExpenseTileSubtitle extends StatelessWidget {
  const _ExpenseTileSubtitle({
    required this.iconColor,
    required this.isAppointment,
    required this.themeMode,
    required this.type,
    required this.entityToShow,
  });

  final Color iconColor;
  final bool isAppointment;
  final MaxiPocketThemeMode themeMode;
  final MaxiPocketExpensesType type;
  final CommitmentsEntity entityToShow;

  String _getType() {
    if (entityToShow is SubscriptionEntity) {
      return (entityToShow as SubscriptionEntity).commitmentEntity.eventType.name;
    } else if (entityToShow is FinancingEntity) {
      return (entityToShow as FinancingEntity).commitmentEntity.eventType.name;
    } else {
      return (entityToShow as AppointmentEntity).commitmentEntity.eventType.name;
    }
  }

  MaxiPocketExpensesFrequency _getFrequency() {
    if (entityToShow is SubscriptionEntity) {
      return (entityToShow as SubscriptionEntity).frequency;
    } else {
      return MaxiPocketExpensesFrequency.monthly;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing12,
      children: <Widget>[
        Row(
          children: <Widget>[
            MaxiPocketBadgeWidget(label: _getType(), expensesType: type, themeMode: themeMode),
            if (!isAppointment) const SizedBox(width: DesignConstants.spacing4),
            if (!isAppointment)
              MaxiPocketBadgeWidget(
                label: _getFrequency().name,
                expensesFrequency: _getFrequency(),
                themeMode: themeMode,
              ),
            const Spacer(),
          ],
        ),
        _ExpenseTileDateRow(iconColor: iconColor, isAppointment: isAppointment, entityToShow: entityToShow, type: type),
      ],
    );
  }
}

@immutable
class _ExpenseTileDateRow extends StatelessWidget {
  const _ExpenseTileDateRow({
    required this.iconColor,
    required this.isAppointment,
    required this.entityToShow,
    required this.type,
  });

  final Color iconColor;
  final bool isAppointment;
  final CommitmentsEntity entityToShow;
  final MaxiPocketExpensesType type;

  String _getDate() {
    if (entityToShow is SubscriptionEntity) {
      return (entityToShow as SubscriptionEntity).nextPaymentDate.toString();
    } else if (entityToShow is FinancingEntity) {
      return (entityToShow as FinancingEntity).nextPaymentDate.toString();
    } else {
      return (entityToShow as AppointmentEntity).commitmentEntity.eventDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: DesignConstants.spacing4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.calendar_today_outlined, color: iconColor, size: DesignConstants.icon16, applyTextScaling: false),
        Flexible(
          child: Text(
            isAppointment
                ? '${WidgetConstants.nextAppointment} ${_getDate()}'
                : '${WidgetConstants.nextExpenses} ${_getDate()}',
            style: context.textTheme.bodyMedium?.copyWith(fontSize: DesignConstants.textSize12),
          ),
        ),
      ],
    );
  }
}
