import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/domain/entities/financing_entity.dart';
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/date_textfield_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/dialog_widget.dart' show showAlertDialog;
import 'package:maxi_pocket/core/presentation/ux/widgets/textfield_widget.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/fab_viewmodel.dart' show fabViewmodelProvider;
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart' show homeNotifierProvider;
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart';
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart' show WidgetConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode, MaxiPocketExpensesFrequency, MaxiPocketDialogType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart'
    show BuildContextExtension, DateFromDateTimeExtensions, DateFromStringExtensions, DoubleExtension;
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart';
import 'package:maxi_pocket/expenses/presentation/viewmodel/expenses_viewmodel.dart' show expensesrProvider;

/// The bottom-sheet container for editing an existing expense.
///
/// Pre-fills all form fields from [entity] and submits the updated record via
/// [fabViewmodelProvider] when the user confirms. Bottom padding grows by the
/// keyboard inset so fields remain visible when the keyboard is open.
class MaxiPocketEditExpensesWidget extends StatelessWidget {
  const MaxiPocketEditExpensesWidget({
    required this.themeMode,
    required this.entity,
    required this.commonId,
    super.key,
  });

  final MaxiPocketThemeMode themeMode;
  final CommitmentsEntity entity;
  final BigInt commonId;

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
      left: BorderSide(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
      right: BorderSide(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
      top: BorderSide(color: _borderColor, width: DesignConstants.bottomBarBorderWidth),
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
    final double modalHeight = screenHeight.responsiveHeight(DesignConstants.modalHeight);
    final double keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      padding: _sheetPadding(keyboardHeight),
      height: modalHeight,
      width: double.infinity,
      decoration: _sheetDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _MaxiPocketEditExpensesHeaderWidget(themeMode: themeMode, borderColor: _borderColor),
          Expanded(
            child: _MaxiPocketEditExpensesBodyWidget(
              themeMode: themeMode,
              entity: entity,
              commonId: commonId,
            ),
          ),
        ],
      ),
    );
  }
}

/// Sheet header row with the "Edit expense" title and a dismiss button.
class _MaxiPocketEditExpensesHeaderWidget extends StatelessWidget {
  const _MaxiPocketEditExpensesHeaderWidget({required this.themeMode, required this.borderColor});

  final MaxiPocketThemeMode themeMode;
  final Color borderColor;

  Color get _closeIconColor => themeMode == MaxiPocketThemeMode.light
      ? ThemeLightColors.bottomNavigationBarShadowsColor
      : ThemeDarkColors.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor, width: DesignConstants.bottomBarBorderWidth)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: DesignConstants.spacing16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                WidgetConstants.editNewTitle,
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_outlined, size: DesignConstants.icon24, color: _closeIconColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stateful host for the edit-expense form.
///
/// Pre-fills controllers from [entity] in [initState] and owns [_selectedFrequency]
/// so the frequency selector reflects the persisted value on first render.
class _MaxiPocketEditExpensesBodyWidget extends StatefulWidget {
  const _MaxiPocketEditExpensesBodyWidget({
    required this.themeMode,
    required this.entity,
    required this.commonId,
  });

  final MaxiPocketThemeMode themeMode;
  final CommitmentsEntity entity;
  final BigInt commonId;

  @override
  State<_MaxiPocketEditExpensesBodyWidget> createState() => _MaxiPocketEditExpensesBodyWidgetState();
}

class _MaxiPocketEditExpensesBodyWidgetState extends State<_MaxiPocketEditExpensesBodyWidget> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;
  late final TextEditingController _financingInstallmentsController;
  late final TextEditingController _financingPaidInstallmentsController;
  late MaxiPocketExpensesFrequency _selectedFrequency;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
    _financingInstallmentsController = TextEditingController();
    _financingPaidInstallmentsController = TextEditingController();
    _prefillFromEntity(widget.entity);
  }

  void _prefillFromEntity(CommitmentsEntity entity) {
    switch (entity) {
      case final SubscriptionEntity s:
        _nameController.text = s.commitmentEntity.name;
        _amountController.text = s.amount.toString();
        _dateController.text = s.commitmentEntity.eventDate.formattedDate();
        _selectedFrequency = s.frequency;
      case final FinancingEntity f:
        _nameController.text = f.commitmentEntity.name;
        _amountController.text = f.amount.toString();
        _dateController.text = f.commitmentEntity.eventDate.formattedDate();
        _financingInstallmentsController.text = f.numberOfInstallments.toString();
        _financingPaidInstallmentsController.text = f.numberOfPaidInstallments.toString();
        _selectedFrequency = MaxiPocketExpensesFrequency.monthly;
      default:
        _selectedFrequency = MaxiPocketExpensesFrequency.monthly;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _financingInstallmentsController.dispose();
    _financingPaidInstallmentsController.dispose();
    super.dispose();
  }

  CommitmentsEntity get _updatedEntity => switch (widget.entity) {
    SubscriptionEntity _ => SubscriptionEntity(
      commitmentEntity: ExpenseCommitmentEntity(
        name: _nameController.text,
        eventDate: _dateController.text.parseFromStringDate(),
        eventType: (widget.entity as SubscriptionEntity).commitmentEntity.eventType,
      ),
      frequency: _selectedFrequency,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      id: widget.commonId,
    ),
    FinancingEntity _ => FinancingEntity(
      commitmentEntity: ExpenseCommitmentEntity(
        name: _nameController.text,
        eventDate: _dateController.text.parseFromStringDate(),
        eventType: (widget.entity as FinancingEntity).commitmentEntity.eventType,
      ),
      numberOfInstallments: int.tryParse(_financingInstallmentsController.text) ?? 0,
      numberOfPaidInstallments: int.tryParse(_financingPaidInstallmentsController.text) ?? 0,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      id: widget.commonId,
    ),
    _ => widget.entity,
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: _MaxiPocketEditExpensesFormContent(
        themeMode: widget.themeMode,
        nameController: _nameController,
        amountController: _amountController,
        dateController: _dateController,
        financingInstallmentsController: _financingInstallmentsController,
        financingPaidInstallmentsController: _financingPaidInstallmentsController,
        entity: widget.entity,
        commonId: widget.commonId,
        selectedFrequency: _selectedFrequency,
        onFrequencyChanged: (MaxiPocketExpensesFrequency v) => setState(() => _selectedFrequency = v),
        formKey: _formKey,
        getUpdatedEntity: () => _updatedEntity,
      ),
    );
  }
}

/// Scrollable body of the edit-expense form.
///
/// Receives pre-filled controllers and callbacks from [_MaxiPocketEditExpensesBodyWidgetState]
/// so this widget stays stateless and only rebuilds on input changes.
class _MaxiPocketEditExpensesFormContent extends StatelessWidget {
  const _MaxiPocketEditExpensesFormContent({
    required this.themeMode,
    required this.nameController,
    required this.amountController,
    required this.dateController,
    required this.financingInstallmentsController,
    required this.financingPaidInstallmentsController,
    required this.entity,
    required this.commonId,
    required this.selectedFrequency,
    required this.onFrequencyChanged,
    required this.formKey,
    required this.getUpdatedEntity,
  });

  final MaxiPocketThemeMode themeMode;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController dateController;
  final TextEditingController financingInstallmentsController;
  final TextEditingController financingPaidInstallmentsController;
  final CommitmentsEntity entity;
  final BigInt commonId;
  final MaxiPocketExpensesFrequency selectedFrequency;
  final ValueChanged<MaxiPocketExpensesFrequency> onFrequencyChanged;
  final GlobalKey<FormState> formKey;
  final CommitmentsEntity Function() getUpdatedEntity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: DesignConstants.spacing16),
      child: Column(
        spacing: DesignConstants.spacing16,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            label: WidgetConstants.addExpensesDate,
            validator: dateValidator,
            hint: WidgetConstants.addExpensesDate,
          ),
          if (entity is SubscriptionEntity || entity is FinancingEntity)
            MaxiPocketTextFormFieldWidget(
              themeMode: themeMode,
              controller: amountController,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
              label: entity is FinancingEntity
                  ? WidgetConstants.addFinancingAmount
                  : WidgetConstants.addSubscriptionsAmount,
              enabled: true,
              validator: amountValidator,
              suffixIcon: Icon(
                Icons.euro_outlined,
                color: themeMode == MaxiPocketThemeMode.light
                    ? ThemeLightColors.onSurfaceVariantColor
                    : ThemeDarkColors.onSurfaceVariantColor,
                size: 24.0,
                applyTextScaling: false,
              ),
            ),
          if (entity is FinancingEntity) ...<Widget>[
            MaxiPocketTextFormFieldWidget(
              themeMode: themeMode,
              controller: financingInstallmentsController,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
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
              keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
              label: WidgetConstants.addExpensesFinancingPaidInstallments,
              enabled: true,
              validator: financingPaidInstallmentsValidator,
            ),
          ],
          _MaxiPocketEditExpensesSubmitButton(
            themeMode: themeMode,
            commonId: commonId,
            formKey: formKey,
            getUpdatedEntity: getUpdatedEntity,
          ),
        ],
      ),
    );
  }
}

/// Submit button that validates the form and persists the updated expense via [fabViewmodelProvider].
///
/// Listens for provider errors and shows an alert dialog before hiding the loader.
/// On success, invalidates both [homeNotifierProvider] and [expensesrProvider] so
/// all screens reflect the change, then pops the bottom sheet.
class _MaxiPocketEditExpensesSubmitButton extends ConsumerWidget {
  const _MaxiPocketEditExpensesSubmitButton({
    required this.themeMode,
    required this.commonId,
    required this.formKey,
    required this.getUpdatedEntity,
  });

  final MaxiPocketThemeMode themeMode;
  final BigInt commonId;
  final GlobalKey<FormState> formKey;
  final CommitmentsEntity Function() getUpdatedEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(fabViewmodelProvider, (AsyncValue<void>? previous, AsyncValue<void> next) {
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
      label: WidgetConstants.editExpensesButton,
      height: DesignConstants.buttonHeight,
      width: double.infinity,
      onPressed: () async {
        getDI<LoadingViewmodel>().showLoading(context: context);
        final Set<FormFieldState<Object?>>? validateFields = formKey.currentState?.validateGranularly();
        if (validateFields != null && validateFields.isEmpty) {
          await ref.read(fabViewmodelProvider.notifier).updateCommitment(
            commonId: commonId,
            object: getUpdatedEntity(),
          );
          if (context.mounted) {
            if (ref.read(fabViewmodelProvider).hasValue) {
              ref.invalidate(homeNotifierProvider);
              ref.invalidate(expensesrProvider);
            }
            Navigator.pop(context);
          }
        }
        getDI<LoadingViewmodel>().hideLoading();
      },
    );
  }
}

/// Opens the edit-expense bottom sheet for [entity] identified by [commonId].
///
/// Uses [isScrollControlled] so [MaxiPocketEditExpensesWidget] can shift above
/// the keyboard via its own [MediaQuery.viewInsetsOf] bottom padding.
Future<void> showEditExpensesBottomSheet(
  BuildContext context,
  MaxiPocketThemeMode themeMode,
  CommitmentsEntity entity,
  BigInt commonId,
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
    builder: (BuildContext context) => MaxiPocketEditExpensesWidget(
      themeMode: themeMode,
      entity: entity,
      commonId: commonId,
    ),
  );
}
