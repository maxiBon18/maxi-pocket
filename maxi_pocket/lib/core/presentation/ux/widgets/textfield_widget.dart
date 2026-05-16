/// Shared themed text form fields (plain and password) for core and features.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';
import 'package:maxi_pocket/core/shared/utils/loggers.dart'
    show customDebugPrint;

/// Styled [TextFormField] aligned with app theme tokens and optional password visibility.
///
/// When [onTimeValidation] is true and [validator] is set, validation runs on each change.
/// When [onFocusLossValidation] is true (default), validation runs when the field loses focus.
/// [isPassword] shows a visibility toggle and obscures text until toggled. Pass [controller]
/// and [externalFocusNode] to integrate with a parent [Form] or focus traversal.
///
/// ```dart
/// MaxiPocketTextFormFieldWidget(
///   themeMode: ref.watch(themeProvider),
///   label: 'Email',
///   validator: (String? v) => v?.isEmpty ?? true ? 'Required' : null,
/// )
/// ```
class MaxiPocketTextFormFieldWidget extends StatefulWidget {
  const MaxiPocketTextFormFieldWidget({
    required this.themeMode,
    super.key,
    this.validator,
    this.keyboardType,
    this.label,
    this.hint,
    this.error,
    this.onChanged,
    this.maxLength,
    this.externalFocusNode,
    this.suffixIcon,
    this.readOnly = false,
    this.autocorrect = false,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.enabled = true,
    this.onTimeValidation = false,
    this.onFocusLossValidation = true,
    this.isPassword = false,
    this.smartQuotesType = SmartQuotesType.disabled,
    this.smartDashesType = SmartDashesType.disabled,
    this.textInputAction = TextInputAction.none,
    this.controller,
    this.inputFormatters,
  });

  final String? Function(String?)? validator;
  final String? label;
  final String? hint;
  final String? error;
  final bool readOnly;
  final bool obscureText;
  final bool autocorrect;
  final bool enableSuggestions;
  final bool enabled;
  final bool onTimeValidation;
  final bool onFocusLossValidation;
  final bool isPassword;
  final int? maxLength;
  final FocusNode? externalFocusNode;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final SmartQuotesType smartQuotesType;
  final SmartDashesType smartDashesType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final MaxiPocketThemeMode themeMode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MaxiPocketTextFormFieldWidget> createState() =>
      _MaxiPocketTextFormFieldWidgetState();
}

class _MaxiPocketTextFormFieldWidgetState
    extends State<MaxiPocketTextFormFieldWidget> {
  late final GlobalKey<FormFieldState<dynamic>> _fieldFormKey;
  FocusNode? _focusNode;
  late bool _showPassword;

  @override
  void initState() {
    super.initState();
    _fieldFormKey = GlobalKey<FormFieldState<dynamic>>();
    _focusNode = widget.enabled
        ? widget.externalFocusNode ?? FocusNode()
        : null;
    _showPassword = false;

    try {
      _focusNode?.addListener(_validateFocusedNode);
    } catch (e, stacktrace) {
      customDebugPrint(
        '[MaxiPocketTextFormFieldWidget] FocusNode already disposed: $e\n $stacktrace',
      );
    }
  }

  @override
  void dispose() {
    if (_fieldFormKey.currentState != null) {
      _fieldFormKey.currentState?.dispose();
    }
    if (_focusNode != null) {
      _focusNode?.removeListener(_validateFocusedNode);
      _focusNode?.dispose();
      _focusNode = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldFormKey,
      keyboardType: widget.keyboardType,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      readOnly: widget.readOnly,
      style: context.textTheme.bodyLarge,
      keyboardAppearance: widget.themeMode == MaxiPocketThemeMode.light
          ? Brightness.light
          : Brightness.dark,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      obscureText: widget.isPassword ? !_showPassword : widget.obscureText,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLength != null
          ? MaxLengthEnforcement.enforced
          : null,
      smartQuotesType: widget.smartQuotesType,
      smartDashesType: widget.smartDashesType,
      focusNode: _focusNode,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      enableInteractiveSelection: true,
      validator: widget.validator,
      onChanged: widget.onChanged != null
          ? (String value) {
              widget.onChanged?.call(value);
              if (widget.validator != null && widget.onTimeValidation) {
                _validate();
              }
            }
          : null,
      onTapOutside: (PointerDownEvent event) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      cursorErrorColor: ThemeLightColors.errorColor,
      showCursor: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: widget.label,
        hintText: widget.hint,
        errorText: widget.error,
        hintStyle: context.textTheme.bodyLarge!.copyWith(
          color: widget.themeMode == MaxiPocketThemeMode.light
              ? ThemeLightColors.textPrimaryColor.withValues(alpha: 0.5)
              : ThemeDarkColors.textPrimaryColor.withValues(alpha: 0.5),
        ),
        labelStyle: context.textTheme.titleSmall!.copyWith(
          color: widget.enabled
              ? (widget.themeMode == MaxiPocketThemeMode.light
                    ? ThemeLightColors.textPrimaryColor
                    : ThemeDarkColors.textPrimaryColor)
              : (widget.themeMode == MaxiPocketThemeMode.light
                    ? ThemeLightColors.textDisabledColor
                    : ThemeDarkColors.textDisabledColor),
        ),
        errorStyle: context.textTheme.bodyMedium!.copyWith(
          color: ThemeLightColors.errorColor,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14.0,
        ),
        suffixIcon: _buildSuffixIcon(),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    final Widget passwordVisibility = GestureDetector(
      onTap: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      child: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: _showPassword
            ? Icon(
                Icons.visibility_off,
                color: widget.enabled
                    ? (widget.themeMode == MaxiPocketThemeMode.light
                          ? ThemeLightColors.onSurfaceVariantColor
                          : ThemeDarkColors.onSurfaceVariantColor)
                    : (widget.themeMode == MaxiPocketThemeMode.light
                          ? ThemeLightColors.onSurfaceVariantColor.withValues(
                              alpha: 0.5,
                            )
                          : ThemeDarkColors.onSurfaceVariantColor.withValues(
                              alpha: 0.5,
                            )),
                fontWeight: FontWeight.bold,
                size: 24.0,
              )
            : Icon(
                Icons.visibility,
                color: widget.enabled
                    ? (widget.themeMode == MaxiPocketThemeMode.light
                          ? ThemeLightColors.onSurfaceVariantColor
                          : ThemeDarkColors.onSurfaceVariantColor)
                    : (widget.themeMode == MaxiPocketThemeMode.light
                          ? ThemeLightColors.onSurfaceVariantColor.withValues(
                              alpha: 0.5,
                            )
                          : ThemeDarkColors.onSurfaceVariantColor.withValues(
                              alpha: 0.5,
                            )),
                fontWeight: FontWeight.bold,
                size: 24.0,
              ),
      ),
    );

    if (widget.isPassword) {
      return passwordVisibility;
    }
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    return null;
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
    final bool hasFocus = _focusNode?.hasFocus ?? false;
    if (!hasFocus) {
      if (widget.onFocusLossValidation && widget.validator != null) {
        _validate();
      }
    }
    return;
  }
}

/// Replaces every comma with a dot so decimal amounts entered with ',' are
/// parsed correctly by [double.parse] / [double.tryParse].
class CommaToDotInputFormatter extends TextInputFormatter {
  const CommaToDotInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String replaced = newValue.text.replaceAll(',', '.');
    if (replaced == newValue.text) return newValue;
    return newValue.copyWith(text: replaced);
  }
}
