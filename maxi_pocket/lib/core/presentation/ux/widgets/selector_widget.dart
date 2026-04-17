/// Generic single-select chip row with a section label.
library;

import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
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
        Row(
          spacing: DesignConstants.spacing8,
          children: options
              .map(
                ((String, T) option) => Expanded(
                  child: _MaxiPocketSelectorOptionWidget<T>(
                    label: option.$1,
                    isSelected: option.$2 == selectedValue,
                    themeMode: themeMode,
                    onTap: () => onChanged(option.$2),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _MaxiPocketSelectorOptionWidget<T> extends StatelessWidget {
  const _MaxiPocketSelectorOptionWidget({
    required this.label,
    required this.isSelected,
    required this.themeMode,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final MaxiPocketThemeMode themeMode;
  final VoidCallback onTap;

  Color get _backgroundColor {
    if (!isSelected) return Colors.transparent;
    return themeMode == MaxiPocketThemeMode.light
        ? ThemeLightColors.primarySurfaceColor
        : ThemeDarkColors.primarySurfaceColor;
  }

  Color get _borderColor => isSelected
      ? (themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.primaryColor : ThemeDarkColors.primaryColor)
      : (themeMode == MaxiPocketThemeMode.light
            ? ThemeLightColors.surfaceVariantColor
            : ThemeDarkColors.surfaceVariantColor);

  Color get _textColor => isSelected
      ? (themeMode == MaxiPocketThemeMode.light ? ThemeLightColors.primaryColor : ThemeDarkColors.primaryColor)
      : (themeMode == MaxiPocketThemeMode.light
            ? ThemeLightColors.textSecondaryColor
            : ThemeDarkColors.textSecondaryColor);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double modalHeight = screenHeight.responsiveHeight(DesignConstants.containerSize48);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: modalHeight,
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
