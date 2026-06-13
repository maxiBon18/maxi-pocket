import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeDarkColors, ThemeLightColors, ThemeTextStyles;
import 'package:maxi_pocket/core/presentation/ux/widgets/badge_widget.dart'
    show MaxiPocketBadgeWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/list_tile_widget.dart'
    show MaxiPocketListTileWidget;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart'
    show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show
        MaxiPocketExpensesType,
        MaxiPocketThemeMode,
        MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/extensions.dart'
    show BuildContextExtension, DateFromDateTimeExtensions;

/// A list tile displaying an expense or appointment item with edit and delete actions.
///
/// [isAppointment] hides the monetary amount and switches badge and date
/// labels to their appointment equivalents.
@immutable
class MaxiPocketWrapperTileWidget extends StatelessWidget {
  const MaxiPocketWrapperTileWidget({
    required this.themeMode,
    required this.entityToShow,
    required this.type,
    super.key,
    this.isAppointment = false,
    this.isFromHome = false,
    this.onEdit,
    this.onDelete,
  });

  final MaxiPocketThemeMode themeMode;
  final bool isAppointment;
  final CommitmentsEntity entityToShow;
  final MaxiPocketExpensesType type;
  final bool isFromHome;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  Color get _iconColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.textSecondaryColor
      : ThemeDarkColors.onSurfaceVariantColor;

  Color get _amountColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.onSurfaceColor
      : ThemeDarkColors.onSurfaceColor;

  String _getTitle() => switch (entityToShow) {
    final SubscriptionEntity s => s.commitmentEntity.name,
    final FinancingEntity f => f.commitmentEntity.name,
    final AppointmentEntity a => a.commitmentEntity.name,
    _ => throw UnimplementedError(
      'Unhandled entity type: ${entityToShow.runtimeType}',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return MaxiPocketListTileWidget(
      themeMode: themeMode,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Text(
            _getTitle(),
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (!isFromHome)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: onEdit,
                  child: Icon(
                    Icons.edit_outlined,
                    color: _iconColor,
                    size: DesignConstants.icon24,
                    applyTextScaling: false,
                  ),
                ),
                const SizedBox(width: DesignConstants.spacing12),
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete_outlined,
                    color: _iconColor,
                    size: DesignConstants.icon24,
                    applyTextScaling: false,
                  ),
                ),
              ],
            ),
        ],
      ),
      subtitle: _ExpenseTileSubtitle(
        iconColor: _iconColor,
        isAppointment: isAppointment,
        themeMode: themeMode,
        type: type,
        entityToShow: entityToShow,
        amountColor: _amountColor,
        isFromHome: isFromHome,
      ),
    );
  }
}

/// Trailing column showing the formatted amount and edit/delete icon buttons.
///
/// The amount row is hidden when [isAppointment] is true.
@immutable
class _MaxiPocketAmount extends StatelessWidget {
  const _MaxiPocketAmount({
    required this.isAppointment,
    required this.amountColor,
    required this.type,
    required this.entityToShow,
    required this.isFromHome,
    required this.themeMode,
  });

  final bool isAppointment;
  final Color amountColor;
  final MaxiPocketExpensesType type;
  final CommitmentsEntity entityToShow;
  final bool isFromHome;
  final MaxiPocketThemeMode themeMode;

  double _getAmount() => switch (entityToShow) {
    final SubscriptionEntity s => s.amount,
    final FinancingEntity f => f.amount,
    _ => 0.0,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: DesignConstants.spacing32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (!isAppointment)
            Text(
              '${_getAmount().toStringAsFixed(2)} ${WidgetConstants.currencySymbol}',
              style:
                  (themeMode == MaxiPocketThemeMode.light
                          ? ThemeTextStyles.monetaryAmountSmallLight
                          : ThemeTextStyles.monetaryAmountSmallDark)
                      .copyWith(color: amountColor),
            ),
          if (!isAppointment)
            const Flexible(child: SizedBox(height: DesignConstants.spacing8)),
        ],
      ),
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
    required this.amountColor,
    required this.isFromHome,
  });

  final Color iconColor;
  final bool isAppointment;
  final MaxiPocketThemeMode themeMode;
  final MaxiPocketExpensesType type;
  final CommitmentsEntity entityToShow;
  final Color amountColor;
  final bool isFromHome;

  String _getType() => switch (entityToShow) {
    final SubscriptionEntity _ => WidgetConstants.addExpensesTypeSubscription,
    final FinancingEntity _ => WidgetConstants.addExpensesTypeFinancing,
    final AppointmentEntity _ => WidgetConstants.addExpensesTypeAppointments,
    _ => throw UnimplementedError(
      'Unhandled entity type: ${entityToShow.runtimeType}',
    ),
  };

  String _getFrequencyLabel() => switch (entityToShow) {
    final SubscriptionEntity s =>
      s.frequency == MaxiPocketExpensesFrequency.monthly
          ? WidgetConstants.addExpensesFrequencyMonthly
          : WidgetConstants.addExpensesFrequencyAnnual,
    _ => WidgetConstants.addExpensesFrequencyMonthly,
  };

  MaxiPocketExpensesFrequency _getFrequency() => switch (entityToShow) {
    final SubscriptionEntity s => s.frequency,
    _ => MaxiPocketExpensesFrequency.monthly,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: DesignConstants.spacing8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!isAppointment)
              Expanded(
                child: MaxiPocketBadgeWidget(
                  label: _getType(),
                  expensesType: type,
                  themeMode: themeMode,
                ),
              )
            else
              MaxiPocketBadgeWidget(
                label: _getType(),
                expensesType: type,
                themeMode: themeMode,
              ),
            if (!isAppointment)
              Expanded(
                child: MaxiPocketBadgeWidget(
                  label: _getFrequencyLabel(),
                  expensesFrequency: _getFrequency(),
                  themeMode: themeMode,
                ),
              ),
            _MaxiPocketAmount(
              isAppointment: isAppointment,
              amountColor: amountColor,
              type: type,
              entityToShow: entityToShow,
              isFromHome: isFromHome,
              themeMode: themeMode,
            ),
          ],
        ),
        const SizedBox(height: DesignConstants.spacing4),
        _ExpenseTileDateRow(
          iconColor: iconColor,
          isAppointment: isAppointment,
          entityToShow: entityToShow,
          type: type,
        ),
      ],
    );
  }
}

/// Date row that renders the next-payment or next-appointment label and its formatted date.
///
/// For appointments the date is combined with the hour (e.g. "12/06/2026 - 09:00");
/// for other types the next-payment date is used.
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

  String _getDate() => switch (entityToShow) {
    final SubscriptionEntity s => s.nextPaymentDate.formattedDate(),
    final FinancingEntity f => f.nextPaymentDate.formattedDate(),
    final AppointmentEntity a =>
      '${a.commitmentEntity.eventDate.formattedDate()} - ${a.hour}',
    _ => throw UnimplementedError(
      'Unhandled entity type: ${entityToShow.runtimeType}',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: DesignConstants.spacing4,
            children: <Widget>[
              Icon(
                Icons.calendar_today_outlined,
                color: iconColor,
                size: DesignConstants.icon16,
                applyTextScaling: false,
              ),
              Expanded(
                child: Text(
                  isAppointment
                      ? WidgetConstants.nextAppointment
                      : WidgetConstants.nextExpenses,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: DesignConstants.textSize12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          _getDate(),
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: DesignConstants.textSize12,
          ),
        ),
      ],
    );
  }
}
