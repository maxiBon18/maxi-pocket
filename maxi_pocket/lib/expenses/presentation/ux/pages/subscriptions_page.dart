import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart'
    show CommitmentsEntity;
import 'package:maxi_pocket/core/domain/entities/home_entity.dart'
    show HomeEntity;
import 'package:maxi_pocket/core/domain/entities/subscription_entity.dart'
    show SubscriptionEntity;
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart'
    show MaxiPocketLoadingWidget;
import 'package:maxi_pocket/core/presentation/ux/widgets/dialog_widget.dart'
    show showAlertDialog;
import 'package:maxi_pocket/core/presentation/ux/widgets/edit_expenses_widget.dart'
    show showEditExpensesBottomSheet;
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_content.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/error_content.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/fab_viewmodel.dart'
    show fabViewmodelProvider;
import 'package:maxi_pocket/core/presentation/viewmodel/home_viewmodel.dart'
    show homeNotifierProvider;
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart'
    show WidgetConstants;
import 'package:maxi_pocket/core/shared/controllers/di.dart' show getDI;
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode, MaxiPocketExpensesType, MaxiPocketDialogType;
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart'
    show getHomeWrapperCommitments;
import 'package:maxi_pocket/expenses/presentation/ux/widgets/tab_bar_expenses_widget.dart'
    show MaxiPocketTabBarExpensesWidget;
import 'package:maxi_pocket/expenses/presentation/viewmodel/expenses_viewmodel.dart';
import 'package:maxi_pocket/expenses/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/expenses/shared/exceptions/expenses_exceptions.dart'
    show ErrorRetrievingExpensesExceptions;
import 'package:maxi_pocket/routes.dart';

/// Displays active subscription expenses grouped into monthly and yearly tabs.
class MaxiPocketSubscriptionsPage extends ConsumerWidget {
  const MaxiPocketSubscriptionsPage({super.key});

  Future<void> _onEdit(
    BuildContext context,
    WidgetRef ref,
    CommitmentsEntity entity,
  ) async {
    if (entity is! SubscriptionEntity || entity.id == null) return;
    await showEditExpensesBottomSheet(
      context,
      ref.read(themeProvider),
      entity,
      entity.id!,
      onSuccess: () {
        ref.invalidate(homeNotifierProvider);
        ref.invalidate(expensesrProvider);
      },
    );
  }

  Future<void> _onDelete(
    BuildContext context,
    WidgetRef ref,
    CommitmentsEntity entity,
  ) async {
    if (entity is! SubscriptionEntity || entity.id == null) return;
    final MaxiPocketThemeMode themeMode = ref.read(themeProvider);
    await showAlertDialog(
      context: context,
      themeMode: themeMode,
      title: WidgetConstants.deleteDialogTitle,
      subtitle: WidgetConstants.deleteDialogSubTitle,
      confirmButtonText: WidgetConstants.deleteDialogConfirm,
      cancelButtonText: WidgetConstants.deleteDialogCancel,
      dialogType: MaxiPocketDialogType.error,
      barrierColor: themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.dialogBarrierColor.withValues(
              alpha: DesignConstants.alpha50,
            )
          : ThemeDarkColors.dialogBarrierColor.withValues(
              alpha: DesignConstants.alpha50,
            ),
      onConfirm: () async {
        Navigator.of(context).pop();
        getDI<LoadingViewmodel>().showLoading(context: context);
        await ref
            .read(fabViewmodelProvider.notifier)
            .deleteCommitment(
              commonId: entity.id!,
              type: MaxiPocketExpensesType.subscription,
            );
        getDI<LoadingViewmodel>().hideLoading();
        if (ref.read(fabViewmodelProvider).hasValue) {
          ref.invalidate(homeNotifierProvider);
          ref.invalidate(expensesrProvider);
        }
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<HomeEntity> expenses = ref.watch(expensesrProvider);
    return MaxiPocketPage(
      routeName: Routes.expensesSubscriptionsRoute,
      allowBack: true,
      showLeading: true,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(
        title: ExpensesWidgetConstants.subscriptionsTitle,
        themeMode: themeMode,
      ),
      child: expenses.when(
        data: (HomeEntity data) => MaxiPocketTabBarExpensesWidget(
          themeMode: themeMode,
          numberOfMonthlyExpenses: ref
              .read(expensesrProvider.notifier)
              .numberOfMonthlySubscriptions,
          numberOfYearlyExpenses: ref
              .read(expensesrProvider.notifier)
              .numberOfYearlySubscriptions,
          totalAmountOfMonthlyExpenses: ref
              .read(expensesrProvider.notifier)
              .getTotalAmountOfMonthlySubscriptions(data),
          totalAmountOfYearlyExpenses: ref
              .read(expensesrProvider.notifier)
              .getTotalAmountOfYearlySubscriptions(data),
          entityToShow: getHomeWrapperCommitments(
            data,
            MaxiPocketExpensesType.subscription,
          ),
          onEdit: (CommitmentsEntity entity) => _onEdit(context, ref, entity),
          onDelete: (CommitmentsEntity entity) =>
              _onDelete(context, ref, entity),
        ),
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        error: (Object error, StackTrace stackTrace) =>
            error is ErrorRetrievingExpensesExceptions
            ? const MaxiPocketErrorContentWidget()
            : const MaxiPocketEmptyContentWidget(),
      ),
    );
  }
}
