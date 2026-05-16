import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maxi_pocket/appointments/presentation/viewmodel/appointment_viewmodel.dart';
import 'package:maxi_pocket/appointments/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/appointments/shared/exceptions/appointment_exceptions.dart'
    show NullOrEmptyAppointmentsExceptions;
import 'package:maxi_pocket/core/domain/entities/appointment_entity.dart';
import 'package:maxi_pocket/core/domain/entities/commitments_entity.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart'
    show ThemeLightColors, ThemeDarkColors;
import 'package:maxi_pocket/core/presentation/ux/pages/section_page.dart';
import 'package:maxi_pocket/core/presentation/ux/pages/wrapper_page.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/app_bar_title_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/circular_loading.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/dialog_widget.dart'
    show showAlertDialog;
import 'package:maxi_pocket/core/presentation/ux/widgets/edit_expenses_widget.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/empty_content.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/error_content.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/fab_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/loading_viewmodel.dart';
import 'package:maxi_pocket/core/presentation/viewmodel/theme_viewmodel.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart'
    show DesignConstants;
import 'package:maxi_pocket/core/shared/constants/widget_constants.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';
import 'package:maxi_pocket/core/shared/utils/enums.dart'
    show MaxiPocketThemeMode, MaxiPocketDialogType, MaxiPocketExpensesType;
import 'package:maxi_pocket/core/shared/utils/helpers_method.dart'
    show getAppointmentsWrapperCommitments;
import 'package:maxi_pocket/routes.dart';

/// Entry point for the appointments feature, rendered inside the shared page shell.
///
/// Shows a placeholder until the appointments domain is connected. Hides the back
/// arrow and bottom navigation is always visible because this is a root destination.
class MaxiPocketAppointmentsPage extends ConsumerWidget {
  const MaxiPocketAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MaxiPocketThemeMode themeMode = ref.watch(themeProvider);
    final AsyncValue<List<AppointmentEntity>> appointments = ref.watch(
      appointmentProvider,
    );
    return MaxiPocketPage(
      routeName: Routes.appointmentsRoute,
      allowBack: false,
      showLeading: false,
      showAppBar: true,
      showBottomBar: true,
      title: MaxiPocketAppBarTitle(
        title: AppointmentsWidgetConstants.appointmentsTitle,
        subtitle: AppointmentsWidgetConstants.appointmentsSubtitle,
        themeMode: themeMode,
      ),
      child: appointments.when(
        data: (List<AppointmentEntity> data) => MaxiPocketSectionPage(
          themeMode: themeMode,
          numberOfExpenses: data.length,
          entityToShow: getAppointmentsWrapperCommitments(data),
          onEdit: (CommitmentsEntity entity) => _onEdit(context, ref, entity),
          onDelete: (CommitmentsEntity entity) =>
              _onDelete(context, ref, entity),
          isAppointment: true,
        ),
        loading: () => const Center(child: MaxiPocketLoadingWidget()),
        error: (Object error, StackTrace stackTrace) =>
            error is NullOrEmptyAppointmentsExceptions
            ? const MaxiPocketEmptyContentWidget(isAppointment: true)
            : const MaxiPocketErrorContentWidget(),
      ),
    );
  }

  Future<void> _onEdit(
    BuildContext context,
    WidgetRef ref,
    CommitmentsEntity entity,
  ) async {
    if (entity is! AppointmentEntity || entity.id == null) return;
    await showEditExpensesBottomSheet(
      context,
      ref.read(themeProvider),
      entity,
      entity.id!,
      onSuccess: () => ref.invalidate(appointmentProvider),
    );
  }

  Future<void> _onDelete(
    BuildContext context,
    WidgetRef ref,
    CommitmentsEntity entity,
  ) async {
    if (entity is! AppointmentEntity || entity.id == null) return;
    final MaxiPocketThemeMode themeMode = ref.read(themeProvider);
    await showAlertDialog(
      context: context,
      themeMode: themeMode,
      title: WidgetConstants.deleteAppointmentDialogTitle,
      subtitle: WidgetConstants.deleteAppointmentDialogSubTitle,
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
              type: MaxiPocketExpensesType.appointments,
            );

        if (ref.read(fabViewmodelProvider).hasValue) {
          ref.invalidate(appointmentProvider);
        }
        getDI<LoadingViewmodel>().hideLoading();
      },
      onCancel: () => Navigator.of(context).pop(),
    );
  }
}
