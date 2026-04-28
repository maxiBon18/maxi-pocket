import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/date_textfield_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/dialog_widget.dart'
    show showAlertDialog;
import 'package:maxi_pocket/core/presentation/ux/widgets/selector_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/textfield_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/fab_viewmodel.dart'
    show fabViewmodelProvider;
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart'
    show WidgetConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show
        MaxiPocketThemeMode,
        MaxiPocketExpensesType,
        MaxiPocketExpensesFrequency,
        MaxiPocketDialogType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart'
    show
        BuildContextExtension,
        DateExtensions,
        DateFromStringExtensions,
        DoubleExtension;
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart';

/// The bottom-sheet container for adding a new expense.
///
/// Bottom padding grows by [keyboardHeight] so the sheet shifts up when the
/// keyboard appears, keeping all form fields visible. Requires the bottom
/// sheet to be opened with [isScrollControlled] set to true.
class MaxiPocketAddExpensesWidget extends StatelessWidget {
  const MaxiPocketAddExpensesWidget({required this.themeMode, super.key});

  final MaxiPocketThemeMode themeMode;

  Color get _borderColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.surfaceVariantColor
      : ThemeDarkColors.listTileBorderColor;
  Color get _backgroundColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.bottomNavigationBarBackgroundColor
      : ThemeDarkColors.surfaceColor;

  BoxDecoration get _sheetDecoration => BoxDecoration(
    borderRadius: const BorderRadius.horizontal(
      left: Radius.circular(DesignConstants.radius24),
      right: Radius.circular(DesignConstants.radius24),
    ),
    border: Border(
      left: BorderSide(
        color: _borderColor,
        width: DesignConstants.bottomBarBorderWidth,
      ),
      right: BorderSide(
        color: _borderColor,
        width: DesignConstants.bottomBarBorderWidth,
      ),
      top: BorderSide(
        color: _borderColor,
        width: DesignConstants.bottomBarBorderWidth,
      ),
    ),
    color: _backgroundColor,
  );

  EdgeInsets _sheetPadding(double keyboardHeight) => EdgeInsets.only(
    left: DesignConstants.spacing16,
    right: DesignConstants.spacing16,
    top: DesignConstants.spacing16,
    bottom: DesignConstants.spacing16 + keyboardHeight,
  );

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double modalHeight = screenHeight.responsiveHeight(
      DesignConstants.modalHeight,
    );
    final double keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      padding: _sheetPadding(keyboardHeight),
      height: modalHeight,
      width: double.infinity,
      decoration: _sheetDecoration,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: <Widget>[
          _MaxiPocketAddExpensesHeaderWidget(
            themeMode: themeMode,
            borderColor: _borderColor,
          ),
          Expanded(
            child: _MaxiPocketAddExpensesBodyWidget(themeMode: themeMode),
          ),
        ],
      ),
    );
  }
}

/// Stateful host for the add-expense form.
///
/// Owns all [TextEditingController]s and the current expense type and frequency
/// selection. Resets controllers and form validation state when the type changes.
class _MaxiPocketAddExpensesBodyWidget extends StatefulWidget {
  const _MaxiPocketAddExpensesBodyWidget({required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  State<_MaxiPocketAddExpensesBodyWidget> createState() =>
      _MaxiPocketAddExpensesBodyWidgetState();
}

class _MaxiPocketAddExpensesBodyWidgetState
    extends State<_MaxiPocketAddExpensesBodyWidget> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;
  late final TextEditingController _financingInstallmentsController;
  late final TextEditingController _appointmentLocationController;
  late final TextEditingController _financingPaidInstallmentsController;

  MaxiPocketExpensesType _selectedType = MaxiPocketExpensesType.subscription;
  MaxiPocketExpensesFrequency _selectedFrequency =
      MaxiPocketExpensesFrequency.monthly;

  void _onTypeChanged(MaxiPocketExpensesType value) {
    _formKey.currentState?.reset();
    _nameController.clear();
    _amountController.clear();
    _dateController.clear();
    _financingInstallmentsController.clear();
    _financingPaidInstallmentsController.clear();
    _appointmentLocationController.clear();
    setState(() {
      _selectedType = value;
      _selectedFrequency = MaxiPocketExpensesFrequency.monthly;
    });
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
    _financingInstallmentsController = TextEditingController();
    _financingPaidInstallmentsController = TextEditingController();
    _appointmentLocationController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _financingInstallmentsController.dispose();
    _financingPaidInstallmentsController.dispose();
    _appointmentLocationController.dispose();
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
        financingInstallmentsController: _financingInstallmentsController,
        financingPaidInstallmentsController:
            _financingPaidInstallmentsController,
        appointmentLocationController: _appointmentLocationController,
        selectedType: _selectedType,
        selectedFrequency: _selectedFrequency,
        onTypeChanged: _onTypeChanged,
        onFrequencyChanged: (MaxiPocketExpensesFrequency value) =>
            setState(() => _selectedFrequency = value),
        formKey: _formKey,
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
    required this.financingInstallmentsController,
    required this.selectedType,
    required this.financingPaidInstallmentsController,
    required this.appointmentLocationController,
    required this.selectedFrequency,
    required this.onTypeChanged,
    required this.onFrequencyChanged,
    required this.formKey,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController dateController;
  final TextEditingController financingInstallmentsController;
  final TextEditingController financingPaidInstallmentsController;
  final TextEditingController appointmentLocationController;
  final MaxiPocketExpensesType selectedType;
  final MaxiPocketExpensesFrequency selectedFrequency;
  final ValueChanged<MaxiPocketExpensesType> onTypeChanged;
  final ValueChanged<MaxiPocketExpensesFrequency> onFrequencyChanged;
  final GlobalKey<FormState> formKey;
  MaxiPocketExpensesFrequency get _effectiveFrequency =>
      selectedType == MaxiPocketExpensesType.financing
      ? MaxiPocketExpensesFrequency.monthly
      : selectedFrequency;

  CommitmentsEntity get _commitmentsEntity => switch (selectedType) {
    MaxiPocketExpensesType.appointments => AppointmentEntity(
      commitmentEntity: ExpenseCommitmentEntity(
        name: nameController.text,
        eventDate: dateController.text.parseFromStringDate(),
        eventType: selectedType,
      ),
      location: appointmentLocationController.text,
    ),
    MaxiPocketExpensesType.financing => FinancingEntity(
      commitmentEntity: ExpenseCommitmentEntity(
        name: nameController.text,
        eventDate: dateController.text.parseFromStringDate(),
        eventType: selectedType,
      ),
      numberOfInstallments:
          int.tryParse(financingInstallmentsController.text) ?? 0,
      numberOfPaidInstallments:
          int.tryParse(financingPaidInstallmentsController.text) ?? 0,
      amount: double.tryParse(amountController.text) ?? 0.0,
    ),
    MaxiPocketExpensesType.subscription => SubscriptionEntity(
      commitmentEntity: ExpenseCommitmentEntity(
        name: nameController.text,
        eventDate: dateController.text.parseFromStringDate(),
        eventType: selectedType,
      ),
      frequency: selectedFrequency,
      amount: double.tryParse(amountController.text) ?? 0.0,
    ),
    _ => throw UnimplementedError(
      'Selected type not implemented: $selectedType',
    ),
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: DesignConstants.spacing16),
      child: Column(
        spacing: DesignConstants.spacing16,
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: <Widget>[
          _MaxiPocketAddExpensesSelectors(
            themeMode: themeMode,
            selectedType: selectedType,
            selectedFrequency: _effectiveFrequency,
            onTypeChanged: onTypeChanged,
            onFrequencyChanged: onFrequencyChanged,
          ),
          _MaxiPocketAddExpensesInputFields(
            themeMode: themeMode,
            nameController: nameController,
            amountController: amountController,
            dateController: dateController,
            appointmentLocationController: appointmentLocationController,
            financingInstallmentsController: financingInstallmentsController,
            financingPaidInstallmentsController:
                financingPaidInstallmentsController,
            selectedType: selectedType,
          ),
          _MaxiPocketAddExpensesSubmitButton(
            themeMode: themeMode,
            getCommitmentsEntity: () => _commitmentsEntity,
            formKey: formKey,
          ),
        ],
      ),
    );
  }
}

/// Type and frequency chip-row selectors for a new expense.
///
/// Hides the frequency selector when [selectedType] is appointments, since
/// appointments have no billing cycle.
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

  static const List<(String, MaxiPocketExpensesType)> _typeOptions =
      <(String, MaxiPocketExpensesType)>[
        (
          WidgetConstants.addExpensesTypeSubscription,
          MaxiPocketExpensesType.subscription,
        ),
        (
          WidgetConstants.addExpensesTypeFinancing,
          MaxiPocketExpensesType.financing,
        ),
        (
          WidgetConstants.addExpensesTypeAppointments,
          MaxiPocketExpensesType.appointments,
        ),
      ];

  static const List<(String, MaxiPocketExpensesFrequency)> _frequencyOptions =
      <(String, MaxiPocketExpensesFrequency)>[
        (
          WidgetConstants.addExpensesFrequencyWeekly,
          MaxiPocketExpensesFrequency.annual,
        ),
        (
          WidgetConstants.addExpensesFrequencyMonthly,
          MaxiPocketExpensesFrequency.monthly,
        ),
      ];
  static const List<(String, MaxiPocketExpensesFrequency)>
  _frequencyOptionsFinancing = <(String, MaxiPocketExpensesFrequency)>[
    (
      WidgetConstants.addExpensesFrequencyMonthly,
      MaxiPocketExpensesFrequency.monthly,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing16,
      crossAxisAlignment: .start,
      children: <Widget>[
        MaxiPocketSelectorWidget<MaxiPocketExpensesType>(
          label: WidgetConstants.addExpensesTypeLabel,
          options: _typeOptions,
          selectedValue: selectedType,
          onChanged: onTypeChanged,
          themeMode: themeMode,
        ),
        if (selectedType != MaxiPocketExpensesType.appointments)
          MaxiPocketSelectorWidget<MaxiPocketExpensesFrequency>(
            label: WidgetConstants.addExpensesFrequencyLabel,
            options: selectedType == MaxiPocketExpensesType.financing
                ? _frequencyOptionsFinancing
                : _frequencyOptions,
            selectedValue: selectedFrequency,
            onChanged: onFrequencyChanged,
            themeMode: themeMode,
          ),
      ],
    );
  }
}

/// Input fields for a new expense.
///
/// Delegates to [_MaxiPocketAddExpensesCommonFields] for shared fields and
/// [_MaxiPocketAddExpensesTypeSpecificFields] for the fields that vary by type.
class _MaxiPocketAddExpensesInputFields extends StatelessWidget {
  const _MaxiPocketAddExpensesInputFields({
    required this.themeMode,
    required this.nameController,
    required this.amountController,
    required this.dateController,
    required this.selectedType,
    required this.financingInstallmentsController,
    required this.financingPaidInstallmentsController,
    required this.appointmentLocationController,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController dateController;
  final MaxiPocketExpensesType selectedType;
  final TextEditingController financingInstallmentsController;
  final TextEditingController financingPaidInstallmentsController;
  final TextEditingController appointmentLocationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing16,
      crossAxisAlignment: .start,
      children: <Widget>[
        _MaxiPocketAddExpensesCommonFields(
          themeMode: themeMode,
          nameController: nameController,
          dateController: dateController,
          selectedType: selectedType,
        ),
        _MaxiPocketAddExpensesTypeSpecificFields(
          themeMode: themeMode,
          selectedType: selectedType,
          amountController: amountController,
          financingInstallmentsController: financingInstallmentsController,
          appointmentLocationController: appointmentLocationController,
          financingPaidInstallmentsController:
              financingPaidInstallmentsController,
        ),
      ],
    );
  }
}

/// Name and date fields shown for every expense type.
class _MaxiPocketAddExpensesCommonFields extends StatelessWidget {
  const _MaxiPocketAddExpensesCommonFields({
    required this.themeMode,
    required this.nameController,
    required this.dateController,
    required this.selectedType,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController nameController;
  final TextEditingController dateController;
  final MaxiPocketExpensesType selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing16,
      crossAxisAlignment: .start,
      children: <Widget>[
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
        MaxiPocketDateTextField(
          themeMode: themeMode,
          controller: dateController,
          label: selectedType == MaxiPocketExpensesType.appointments
              ? WidgetConstants.appointmentDate
              : WidgetConstants.addExpensesDate,
          validator: dateValidator,
          hint: WidgetConstants.addExpensesDate,
        ),
      ],
    );
  }
}

/// Conditional fields driven by the selected expense type.
class _MaxiPocketAddExpensesTypeSpecificFields extends StatelessWidget {
  const _MaxiPocketAddExpensesTypeSpecificFields({
    required this.themeMode,
    required this.selectedType,
    required this.amountController,
    required this.financingInstallmentsController,
    required this.appointmentLocationController,
    required this.financingPaidInstallmentsController,
  });

  final MaxiPocketThemeMode themeMode;
  final MaxiPocketExpensesType selectedType;
  final TextEditingController amountController;
  final TextEditingController financingInstallmentsController;
  final TextEditingController financingPaidInstallmentsController;
  final TextEditingController appointmentLocationController;

  @override
  Widget build(BuildContext context) {
    return switch (selectedType) {
      MaxiPocketExpensesType.appointments => _MaxiPocketAppointmentFields(
        themeMode: themeMode,
        locationController: appointmentLocationController,
      ),
      MaxiPocketExpensesType.financing => _MaxiPocketFinancingFields(
        themeMode: themeMode,
        amountController: amountController,
        installmentsController: financingInstallmentsController,
        financingPaidInstallmentsController:
            financingPaidInstallmentsController,
      ),
      _ => _MaxiPocketSubscriptionFields(
        themeMode: themeMode,
        amountController: amountController,
      ),
    };
  }
}

/// Amount field for subscription (and all) expense types.
class _MaxiPocketSubscriptionFields extends StatelessWidget {
  const _MaxiPocketSubscriptionFields({
    required this.themeMode,
    required this.amountController,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return MaxiPocketTextFormFieldWidget(
      themeMode: themeMode,
      controller: amountController,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      label: WidgetConstants.addExpensesAmount,
      enabled: true,
      validator: amountValidator,
    );
  }
}

/// Amount and installments fields for financing expense type.
class _MaxiPocketFinancingFields extends StatelessWidget {
  const _MaxiPocketFinancingFields({
    required this.themeMode,
    required this.amountController,
    required this.installmentsController,
    required this.financingPaidInstallmentsController,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController amountController;
  final TextEditingController installmentsController;
  final TextEditingController financingPaidInstallmentsController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: DesignConstants.spacing16,
      crossAxisAlignment: .start,
      children: <Widget>[
        MaxiPocketTextFormFieldWidget(
          themeMode: themeMode,
          controller: amountController,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
            signed: false,
          ),
          label: WidgetConstants.addExpensesAmount,
          enabled: true,
          validator: amountValidator,
        ),
        MaxiPocketTextFormFieldWidget(
          themeMode: themeMode,
          controller: installmentsController,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
          label: WidgetConstants.addExpensesFinancingInstallments,
          enabled: true,
          validator: financingInstallmentsValidator,
        ),
        MaxiPocketTextFormFieldWidget(
          themeMode: themeMode,
          controller: financingPaidInstallmentsController,
          autocorrect: false,
          enableSuggestions: false,
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
          label: WidgetConstants.addExpensesFinancingPaidInstallments,
          enabled: true,
          validator: financingPaidInstallmentsValidator,
        ),
      ],
    );
  }
}

/// Location field for appointment expense type.
class _MaxiPocketAppointmentFields extends StatelessWidget {
  const _MaxiPocketAppointmentFields({
    required this.themeMode,
    required this.locationController,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return MaxiPocketTextFormFieldWidget(
      themeMode: themeMode,
      controller: locationController,
      autocorrect: false,
      enableSuggestions: true,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      label: WidgetConstants.addExpensesAppointmentLocation,
      enabled: true,
      validator: appointmentLocationValidator,
    );
  }
}

/// Submit button that validates the form and persists the new expense via [fabViewmodelProvider].
///
/// Listens for provider errors and shows an alert dialog before hiding the loader.
/// On success it pops the bottom sheet.
class _MaxiPocketAddExpensesSubmitButton extends ConsumerWidget {
  const _MaxiPocketAddExpensesSubmitButton({
    required this.themeMode,
    required this.getCommitmentsEntity,
    required this.formKey,
  });

  final MaxiPocketThemeMode themeMode;
  final CommitmentsEntity Function() getCommitmentsEntity;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(fabViewmodelProvider, (
      AsyncValue<void>? previous,
      AsyncValue<void> next,
    ) {
      next.whenOrNull(
        error: (Object e, StackTrace? st) async {
          getDI<LoadingViewmodel>().hideLoading();
          await showAlertDialog(
            context: context,
            barrierColor: themeMode == MaxiPocketThemeMode.light
                ? ThemeLightColors.onSurfaceColor.withValues(alpha: 0.7)
                : ThemeDarkColors.onSurfaceColor.withValues(alpha: 0.7),
            title: WidgetConstants.addExpensesErrorTitle,
            subtitle: WidgetConstants.addExpensesErrorSubTitle,
            confirmButtonText: WidgetConstants.buttonOk,
            themeMode: themeMode,
            dialogType: MaxiPocketDialogType.error,
            onConfirm: () {
              ref.invalidate(fabViewmodelProvider);
              Navigator.of(context).pop();
            },
          );
        },
      );
    });
    return MaxiPocketButtonWidget(
      themeMode: themeMode,
      label: WidgetConstants.addExpensesButton,
      height: DesignConstants.buttonHeight,
      width: double.infinity,
      onPressed: () async {
        getDI<LoadingViewmodel>().showLoading(context: context);
        final Set<FormFieldState<Object?>>? validateFields = formKey
            .currentState
            ?.validateGranularly();
        if (validateFields != null && validateFields.isEmpty) {
          await ref
              .read(fabViewmodelProvider.notifier)
              .insertCommitments(getCommitmentsEntity());
          if (context.mounted) {
            Navigator.pop(context);
          }
        }

        getDI<LoadingViewmodel>().hideLoading();
      },
    );
  }
}

/// Sheet header with the form title and a close button, separated from the body by a bottom border.
class _MaxiPocketAddExpensesHeaderWidget extends StatelessWidget {
  const _MaxiPocketAddExpensesHeaderWidget({
    required this.themeMode,
    required this.borderColor,
  });

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
          bottom: BorderSide(
            color: borderColor,
            width: DesignConstants.bottomBarBorderWidth,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: DesignConstants.spacing16),
        child: Row(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: <Widget>[
            Expanded(
              child: Text(
                WidgetConstants.addNewTitle,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: _MaxiPocketAddExpensesCloseButton(
                iconColor: _closeIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaxiPocketAddExpensesCloseButton extends StatelessWidget {
  const _MaxiPocketAddExpensesCloseButton({required this.iconColor});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.close_outlined,
          size: DesignConstants.icon24,
          color: iconColor,
        ),
      ),
    );
  }
}

/// Opens the add-expense bottom sheet anchored to [context].
///
/// Uses [isScrollControlled] so [MaxiPocketAddExpensesWidget] can shift above
/// the keyboard via its own [MediaQuery.viewInsetsOf] bottom padding.
Future<void> showAddExpensesBottomSheet(
  BuildContext context,
  MaxiPocketThemeMode themeMode,
) {
  final Color barrierColor = themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.bottomNavigationBarShadowsColor
      : ThemeDarkColors.bottomNavigationBarShadowsColor;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor.withValues(alpha: DesignConstants.alpha50),
    elevation: DesignConstants.elevation5,
    builder: (BuildContext context) =>
        MaxiPocketAddExpensesWidget(themeMode: themeMode),
  );
}
