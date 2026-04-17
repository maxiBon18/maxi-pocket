import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/date_textfield_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/selector_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/textfield_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode, MaxiPocketExpensesType, MaxiPocketExpensesFrequency;
import 'package:maxi_pocket/core/shared/utils/extensions.dart' show BuildContextExtension, DoubleExtension;
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart';

/// The bottom-sheet container for adding a new expense.
///
/// Bottom padding grows by [keyboardHeight] so the sheet shifts up when the
/// keyboard appears, keeping all form fields visible. Requires the bottom
/// sheet to be opened with [isScrollControlled] set to true.
class MaxiPocketAddExpensesWidget extends StatelessWidget {
  const MaxiPocketAddExpensesWidget({super.key, required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  Color get _borderColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.surfaceVariantColor
      : ThemeDarkColors.listTileBorderColor;
  Color get _backgroundColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.bottomNavigationBarBackgroundColor
      : ThemeDarkColors.surfaceColor;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double modalHeight = screenHeight.responsiveHeight(DesignConstants.modalHeight);
    final double keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      padding: EdgeInsets.only(
        left: DesignConstants.spacing16,
        right: DesignConstants.spacing16,
        top: DesignConstants.spacing16,
        bottom: DesignConstants.spacing16 + keyboardHeight,
      ),
      height: modalHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(DesignConstants.radius24),
          right: Radius.circular(DesignConstants.radius24),
        ),
        border: Border(
          left: BorderSide(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
          right: BorderSide(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
          top: BorderSide(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
        ),
        color: _backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          _MaxiPocketAddExpensesHeaderWidget(themeMode: themeMode, borderColor: _borderColor),
          Expanded(child: _MaxiPocketAddExpensesBodyWidget(themeMode: themeMode)),
        ],
      ),
      
    );
  }
}

class _MaxiPocketAddExpensesBodyWidget extends StatefulWidget {
  const _MaxiPocketAddExpensesBodyWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  State<_MaxiPocketAddExpensesBodyWidget> createState() => _MaxiPocketAddExpensesBodyWidgetState();
}

class _MaxiPocketAddExpensesBodyWidgetState extends State<_MaxiPocketAddExpensesBodyWidget> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;
  MaxiPocketExpensesType _selectedType = MaxiPocketExpensesType.subscription;
  MaxiPocketExpensesFrequency _selectedFrequency = MaxiPocketExpensesFrequency.monthly;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: _MaxiPocketAddExpensesFormContent(
        themeMode: widget.themeMode,
        nameController: _nameController,
        amountController: _amountController,
        dateController: _dateController,
        selectedType: _selectedType,
        selectedFrequency: _selectedFrequency,
        onTypeChanged: (MaxiPocketExpensesType value) => setState(() => _selectedType = value),
        onFrequencyChanged: (MaxiPocketExpensesFrequency value) => setState(() => _selectedFrequency = value),
      ),
    );
  }
}

/// The scrollable body of the add-expense form.
///
/// Receives all mutable state and callbacks from [_MaxiPocketAddExpensesBodyWidgetState]
/// so this widget stays stateless and rebuilds only when its inputs change.
class _MaxiPocketAddExpensesFormContent extends StatelessWidget {
  const _MaxiPocketAddExpensesFormContent({
    required this.themeMode,
    required this.nameController,
    required this.amountController,
    required this.dateController,
    required this.selectedType,
    required this.selectedFrequency,
    required this.onTypeChanged,
    required this.onFrequencyChanged,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController dateController;
  final MaxiPocketExpensesType selectedType;
  final MaxiPocketExpensesFrequency selectedFrequency;
  final ValueChanged<MaxiPocketExpensesType> onTypeChanged;
  final ValueChanged<MaxiPocketExpensesFrequency> onFrequencyChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: DesignConstants.spacing16),
      child: Column(
        spacing: DesignConstants.spacing16,
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          _MaxiPocketAddExpensesSelectors(
            themeMode: themeMode,
            selectedType: selectedType,
            selectedFrequency: selectedFrequency,
            onTypeChanged: onTypeChanged,
            onFrequencyChanged: onFrequencyChanged,
          ),
          _MaxiPocketAddExpensesInputFields(
            themeMode: themeMode,
            nameController: nameController,
            amountController: amountController,
            dateController: dateController,
          ),
          MaxiPocketButtonWidget(
            themeMode: themeMode,
            label: WidgetConstants.addExpensesButton,
            height: DesignConstants.buttonHeight,
            width: double.infinity,
            enabled: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/// The type and frequency chip-row selectors for a new expense.
///
/// Extracted to keep [_MaxiPocketAddExpensesFormContent.build] within the
/// 30-line limit while grouping the two logically related selector fields.
class _MaxiPocketAddExpensesSelectors extends StatelessWidget {
  const _MaxiPocketAddExpensesSelectors({
    required this.themeMode,
    required this.selectedType,
    required this.selectedFrequency,
    required this.onTypeChanged,
    required this.onFrequencyChanged,
  });

  final MaxiPocketThemeMode themeMode;
  final MaxiPocketExpensesType selectedType;
  final MaxiPocketExpensesFrequency selectedFrequency;
  final ValueChanged<MaxiPocketExpensesType> onTypeChanged;
  final ValueChanged<MaxiPocketExpensesFrequency> onFrequencyChanged;

  static const List<(String, MaxiPocketExpensesType)> _typeOptions = [
    (WidgetConstants.addExpensesTypeSubscription, MaxiPocketExpensesType.subscription),
    (WidgetConstants.addExpensesTypeFinancing, MaxiPocketExpensesType.financing),
  ];

  static const List<(String, MaxiPocketExpensesFrequency)> _frequencyOptions = [
    (WidgetConstants.addExpensesFrequencyWeekly, MaxiPocketExpensesFrequency.weekly),
    (WidgetConstants.addExpensesFrequencyMonthly, MaxiPocketExpensesFrequency.monthly),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing16,
      crossAxisAlignment: .start,
      children: [
        MaxiPocketSelectorWidget<MaxiPocketExpensesType>(
          label: WidgetConstants.addExpensesTypeLabel,
          options: _typeOptions,
          selectedValue: selectedType,
          onChanged: onTypeChanged,
          themeMode: themeMode,
        ),
        MaxiPocketSelectorWidget<MaxiPocketExpensesFrequency>(
          label: WidgetConstants.addExpensesFrequencyLabel,
          options: _frequencyOptions,
          selectedValue: selectedFrequency,
          onChanged: onFrequencyChanged,
          themeMode: themeMode,
        ),
      ],
    );
  }
}

/// The name, amount, and date text fields for a new expense.
///
/// Extracted to keep [_MaxiPocketAddExpensesFormContent.build] within the
/// 30-line limit while grouping the three input fields.
class _MaxiPocketAddExpensesInputFields extends StatelessWidget {
  const _MaxiPocketAddExpensesInputFields({
    required this.themeMode,
    required this.nameController,
    required this.amountController,
    required this.dateController,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing16,
      crossAxisAlignment: .start,
      children: [
        MaxiPocketTextFormFieldWidget(
          themeMode: themeMode,
          controller: nameController,
          autocorrect: false,
          enableSuggestions: true,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          label: WidgetConstants.addExpensesName,
          enabled: true,
          validator: nameValidator,
        ),
        MaxiPocketTextFormFieldWidget(
          themeMode: themeMode,
          controller: amountController,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
          label: WidgetConstants.addExpensesAmount,
          enabled: true,
          validator: amountValidator,
        ),
        MaxiPocketDateTextField(
          themeMode: themeMode,
          controller: dateController,
          label: WidgetConstants.addExpensesDate,
          validator: dateValidator,
          hint: WidgetConstants.addExpensesDate,
        ),
      ],
    );
  }
}

class _MaxiPocketAddExpensesHeaderWidget extends StatelessWidget {
  const _MaxiPocketAddExpensesHeaderWidget({required this.themeMode, required this.borderColor});

  final MaxiPocketThemeMode themeMode;
  final Color borderColor;

  Color get _closeIconColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.bottomNavigationBarShadowsColor
      : ThemeDarkColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: borderColor, width: DesignConstants.bottomBarBorderWidth),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: DesignConstants.spacing16),
        child: Row(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Text(
                WidgetConstants.addExpensesTitle,
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.close_outlined, size: DesignConstants.icon24, color: _closeIconColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Opens the add-expense bottom sheet anchored to [context].
///
/// Uses [isScrollControlled] so [MaxiPocketAddExpensesWidget] can shift above
/// the keyboard via its own [MediaQuery.viewInsetsOf] bottom padding.
Future<void> showAddExpensesBottomSheet(BuildContext context, MaxiPocketThemeMode themeMode) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: ThemeLightColors.bottomNavigationBarShadowsColor.withValues(alpha: DesignConstants.alpha50),
    elevation: DesignConstants.elevation5,
    builder: (BuildContext context) => MaxiPocketAddExpensesWidget(themeMode: themeMode),
  );
}
