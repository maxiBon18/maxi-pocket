/// Shared time input that uses the system time picker and app theme colors.
library;

import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart'
    show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart';
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart';

/// Read-only time field that opens the platform [showTimePicker] on tap or via the clock action.
///
/// Pass [controller] to control or observe the text from outside; otherwise an internal
/// controller is created and owned by this widget. Validation runs when focus is lost if
/// [validator] is non-null. [themeMode] drives label and hint colors to match the app theme.
///
/// ```dart
/// MaxiPocketHourTextField(
///   label: 'Appointment hour',
///   hint: 'Select a time',
///   themeMode: ref.watch(themeProvider),
///   onChanged: (DateTime? value) { },
/// )
/// ```
class MaxiPocketHourTextField extends StatefulWidget {
  const MaxiPocketHourTextField({
    required this.label,
    required this.hint,
    required this.themeMode,
    super.key,
    this.initialHour,
    this.helperText,
    this.onChanged,
    this.validator,
    this.controller,
    this.textInputAction = TextInputAction.none,
  });

  final String label;
  final String hint;
  final TimeOfDay? initialHour;
  final String? helperText;
  final TextInputAction textInputAction;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final MaxiPocketThemeMode themeMode;

  @override
  State<MaxiPocketHourTextField> createState() =>
      _MaxiPocketHourTextFieldState();
}

class _MaxiPocketHourTextFieldState extends State<MaxiPocketHourTextField> {
  late final TextEditingController _controller;
  late final GlobalKey<FormFieldState<dynamic>> _fieldFormKey;
  String? _error;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _fieldFormKey = GlobalKey<FormFieldState<dynamic>>();
    _focusNode = FocusNode();

    try {
      _focusNode.addListener(_validateFocusedNode);
    } catch (e, stacktrace) {
      customDebugPrint(
        '[MaxiPocketDateTextField] FocusNode already disposed: $e\n $stacktrace',
      );
    }
  }

  @override
  void dispose() {
    if (_fieldFormKey.currentState != null) {
      _fieldFormKey.currentState?.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_validateFocusedNode);
    _focusNode.dispose();
    super.dispose();
  }

  /// Opens the system time picker and writes the selected time into [_controller].
  ///
  /// Forces 24-hour format via a [MediaQuery] override so the display is locale-independent.
  /// Triggers validation immediately after a selection so the error clears without waiting
  /// for the field to lose focus.
  Future<void> _openPicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.initialHour ?? TimeOfDay.now(),
      helpText: widget.label,
      barrierColor: widget.themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.onSurfaceColor.withValues(alpha: 0.7)
          : ThemeDarkColors.onSurfaceColor.withValues(alpha: 0.7),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _controller.text = picked.format(context);
      });
      _validateFocusedNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      button: true,
      child: TextFormField(
        key: _fieldFormKey,
        controller: _controller,
        focusNode: _focusNode,
        readOnly: true,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: context.textTheme.bodyLarge,
        autocorrect: false,
        enableSuggestions: false,
        enableInteractiveSelection: false,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        onTap: _openPicker,
        onTapOutside: (PointerDownEvent event) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.label,
          hintText: widget.hint,
          errorText: _error,
          hintStyle: context.textTheme.bodyLarge!.copyWith(
            color: widget.themeMode == MaxiPocketThemeMode.light
                ? ThemeLightColors.textPrimaryColor.withValues(alpha: 0.5)
                : ThemeDarkColors.textPrimaryColor.withValues(alpha: 0.5),
          ),
          labelStyle: context.textTheme.titleSmall!.copyWith(
            color: widget.themeMode == MaxiPocketThemeMode.light
                ? ThemeLightColors.textPrimaryColor
                : ThemeDarkColors.textPrimaryColor,
          ),
          errorStyle: context.textTheme.bodyMedium!.copyWith(
            color: ThemeLightColors.errorColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14.0,
          ),
          suffixIcon: IconButton(
            tooltip: WidgetConstants.dateTextFieldPickDate,
            icon: Icon(
              Icons.access_time_outlined,
              color: widget.themeMode == MaxiPocketThemeMode.light
                  ? ThemeLightColors.onSurfaceVariantColor
                  : ThemeDarkColors.onSurfaceVariantColor,
              fontWeight: FontWeight.bold,
              size: 24.0,
              applyTextScaling: false,
            ),
            onPressed: _openPicker,
          ),
        ),
      ),
    );
  }

  /// Runs the form-field validator and triggers a rebuild to surface the error text.
  void _validate() {
    if (_fieldFormKey.currentState == null) {
      return;
    }
    final bool? validation = _fieldFormKey.currentState?.validate();
    if (validation != null) {
      setState(() {});
    }
  }

  /// Validates the field when it loses focus, deferring validation while the field is active.
  void _validateFocusedNode() {
    if (!_focusNode.hasFocus) {
      if (widget.validator != null) {
        _validate();
      }
    }
    return;
  }
}
