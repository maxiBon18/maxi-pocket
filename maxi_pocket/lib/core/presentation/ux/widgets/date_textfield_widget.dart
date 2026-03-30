import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:maxi_pocket/core/presentation/theme/theme.dart' show ThemeColors;
import 'package:maxi_pocket/core/shared/constants/app_constants.dart' show AppConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart';

class MaxiPocketDateTextField extends StatefulWidget {
  const MaxiPocketDateTextField({
    required this.label,
    required this.hint,
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.helperText,
    this.onChanged,
    this.validator,
    this.format,
    this.controller,
    this.textInputAction = TextInputAction.none,
  });

  final String label;
  final String hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? helperText;
  final TextInputAction textInputAction;
  final ValueChanged<DateTime?>? onChanged;
  final String? Function(String?)? validator;
  final DateFormat? format;
  final TextEditingController? controller;

  @override
  State<MaxiPocketDateTextField> createState() => _MaxiPocketDateTextFieldState();
}

class _MaxiPocketDateTextFieldState extends State<MaxiPocketDateTextField> {
  late final TextEditingController _controller;
  late final GlobalKey<FormFieldState<dynamic>> _fieldFormKey;
  late final DateFormat _dateFormat;
  DateTime? _value;
  String? _error;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _dateFormat = widget.format ?? DateFormat.yMd(AppConstants.languageCode);
    _value = widget.initialDate ?? DateTime.now();
    _controller = widget.controller ?? TextEditingController();
    _fieldFormKey = GlobalKey<FormFieldState<dynamic>>();
    _focusNode = FocusNode();

    try {
      _focusNode.addListener(_validateFocusedNode);
    } catch (e, stacktrace) {
      customDebugPrint('[MaxiPocketDateTextField] FocusNode already disposed: $e\n $stacktrace');
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

  Future<void> _openPicker() async {
    final DateTime now = DateTime.now();
    final DateTime initial = _value ?? widget.initialDate ?? now;
    final DateTime first = widget.firstDate ?? DateTime(now.year - 100);
    final DateTime last = widget.lastDate ?? DateTime(now.year + 10);

    final DateTime? picked = await showDatePicker(
      context: context,
      currentDate: now,
      initialDate: initial.isBefore(first) ? first : initial,
      firstDate: first,
      lastDate: last,
      helpText: widget.label,
      locale: const Locale(AppConstants.languageCode, AppConstants.countryCode),
      barrierColor: ThemeColors.onSurfaceColor.withValues(alpha: 0.7),
      keyboardType: TextInputType.datetime,
      builder: (BuildContext context, Widget? child) {
        return child ?? const SizedBox();
      },
    );

    if (picked != null) {
      setState(() {
        _value = picked;
        _controller.text = _dateFormat.format(picked);
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
        onTapOutside: (PointerDownEvent event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.label,
          hintText: widget.hint,
          errorText: _error,
          hintStyle: context.textTheme.bodyLarge!.copyWith(
            color: ThemeColors.textLightPrimaryColor.withValues(alpha: 0.5),
          ),
          labelStyle: context.textTheme.titleSmall!.copyWith(color: ThemeColors.textLightPrimaryColor),
          errorStyle: context.textTheme.bodyMedium!.copyWith(color: ThemeColors.errorColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14.0),
          suffixIcon: IconButton(
            tooltip: WidgetConstants.dateTextFieldPickDate,
            icon: const Icon(
              Icons.calendar_month,
              color: ThemeColors.textLightPrimaryColor,
              fontWeight: FontWeight.bold,
              size: 24.0,
            ),
            onPressed: _openPicker,
          ),
        ),
      ),
    );
  }

  void _validate() {
    if (_fieldFormKey.currentState == null) {
      return;
    }
    final bool? validation = _fieldFormKey.currentState?.validate();
    if (validation != null) {
      setState(() {});
    }
  }

  void _validateFocusedNode() {
    if (!_focusNode.hasFocus) {
      if (widget.validator != null) {
        _validate();
      }
    }
    return;
  }
}
