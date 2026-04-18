/// Generic single-select chip row with a section label.
library;

import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketExpensesType, MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension, DoubleExtension;

/// A labelled row of mutually exclusive selectable chips.
///
/// Each option is a record of `(displayLabel, value)`. The chip whose value equals
/// [selectedValue] is rendered in the selected style; tapping any chip calls [onChanged]
/// with the new value. Pass [themeMode] to apply correct light/dark colors.
///
/// ```dart
/// MaxiPocketSelectorWidget<MaxiPocketExpensesType>(
///   label: WidgetConstants.addExpensesTypeLabel,
///   options: const [
///     (WidgetConstants.addExpensesTypeSubscription, MaxiPocketExpensesType.subscription),
///     (WidgetConstants.addExpensesTypeFinancing, MaxiPocketExpensesType.financing),
///   ],
///   selectedValue: _selectedType,
///   onChanged: (v) => setState(() => _selectedType = v),
///   themeMode: widget.themeMode,
/// )
/// ```
class MaxiPocketSelectorWidget<T> extends StatelessWidget {
  const MaxiPocketSelectorWidget({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    required this.themeMode,
    super.key,
  });

  final String label;

  /// Each record: `(displayLabel, value)`.
  final List<(String, T)> options;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DesignConstants.spacing8,
      children: [
        Text(label, style: context.textTheme.titleSmall),
        _MaxiPocketSelectorChipsRow<T>(
          options: options,
          selectedValue: selectedValue,
          themeMode: themeMode,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

/// Responsive chip row that sizes each chip proportionally to the available width.
class _MaxiPocketSelectorChipsRow<T> extends StatelessWidget {
  const _MaxiPocketSelectorChipsRow({
    required this.options,
    required this.selectedValue,
    required this.themeMode,
    required this.onChanged,
  });

  final List<(String, T)> options;
  final T selectedValue;
  final MaxiPocketThemeMode themeMode;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int count = options.length;
        final double chipWidth = count > 1
            ? (constraints.maxWidth - DesignConstants.spacing8 * (count - 1)) / count
            : double.infinity;
        return Wrap(
          alignment: .center,
          spacing: DesignConstants.spacing8,
          runSpacing: DesignConstants.spacing8,
          children: options
              .map(
                ((String, T) option) => SizedBox(
                  width: chipWidth,
                  child: _MaxiPocketSelectorOptionWidget<T>(
                    label: option.$1,
                    isSelected: option.$2 == selectedValue,
                    themeMode: themeMode,
                    selectedValue: selectedValue,
                    onTap: () => onChanged(option.$2),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

/// A single selectable chip within [_MaxiPocketSelectorChipsRow].
///
/// Expense-type chips use category-specific border and fill colors; all other
/// types use the primary palette. Unselected chips are always transparent.
class _MaxiPocketSelectorOptionWidget<T> extends StatelessWidget {
  const _MaxiPocketSelectorOptionWidget({
    required this.label,
    required this.isSelected,
    required this.themeMode,
    required this.onTap,
    required this.selectedValue,
    super.key,
  });

  final String label;
  final bool isSelected;
  final MaxiPocketThemeMode themeMode;
  final VoidCallback onTap;
  final T selectedValue;

  Color get _backgroundColor {
    if (!isSelected) return Colors.transparent;

    final Color commonBackgroundColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.primarySurfaceColor
        : ThemeDarkColors.primarySurfaceColor;

    if (selectedValue is MaxiPocketExpensesType) {
      return switch (selectedValue) {
        MaxiPocketExpensesType.financing => ThemeLightColors.badgeFinancingBackgroundColor,
        MaxiPocketExpensesType.appointments => ThemeLightColors.appointmentsBadgeBackgroundColor,
        _ => commonBackgroundColor,
      };
    } else {
      return commonBackgroundColor;
    }
  }

  Color get _borderColor {
    final Color commonSelectedBorderColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.primaryColor
        : ThemeDarkColors.primaryColor;
    final Color commonUnselectedBorderColor = themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.surfaceVariantColor
        : ThemeDarkColors.surfaceVariantColor;
    if (isSelected) {
      if (selectedValue is MaxiPocketExpensesType) {
        return switch (selectedValue) {
          MaxiPocketExpensesType.financing => ThemeLightColors.secondaryDarkColor,
          MaxiPocketExpensesType.appointments => ThemeLightColors.textPrimaryColor,
          _ => commonSelectedBorderColor,
        };
      } else {
        return commonSelectedBorderColor;
      }
    }
    return commonUnselectedBorderColor;
  }

  Color get _textColor {
    if (isSelected) {
      if (selectedValue is MaxiPocketExpensesType) {
        return switch (selectedValue) {
          MaxiPocketExpensesType.financing => ThemeLightColors.secondaryDarkColor,
          MaxiPocketExpensesType.appointments => ThemeLightColors.textPrimaryColor,
          _ => ThemeLightColors.errorColor,
        };
      } else {
        return ThemeLightColors.errorColor;
      }
    }
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.textSecondaryColor
        : ThemeDarkColors.textSecondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double chipHeight = screenHeight.responsiveHeight(DesignConstants.containerSize48);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: chipHeight,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(DesignConstants.radius12),
          border: Border.all(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: context.textTheme.bodyLarge?.copyWith(color: _textColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
