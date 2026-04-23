import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode, MaxiPocketDialogType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';

Future<T?> showAlertDialog<T>({
  required BuildContext context,
  required MaxiPocketThemeMode themeMode,
  String? title,
  String? subtitle,
  String? confirmButtonText,
  String? cancelButtonText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
  Color? barrierColor,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  MaxiPocketDialogType dialogType = MaxiPocketDialogType.info,
}) => showDialog(
  context: context,
  barrierDismissible: barrierDismissible,
  barrierColor: barrierColor,
  useSafeArea: useSafeArea,
  useRootNavigator: useRootNavigator,
  builder: (BuildContext context) => MaxiPocketAlertDialog(
    themeMode: themeMode,
    title: title,
    subtitle: subtitle,
    confirmButtonText: confirmButtonText,
    cancelButtonText: cancelButtonText,
    onConfirm: onConfirm,
    onCancel: onCancel,
    dialogType: dialogType,
  ),
);

class MaxiPocketAlertDialog extends StatelessWidget {
  const MaxiPocketAlertDialog({
    required this.themeMode,
    super.key,
    this.title,
    this.subtitle,
    this.confirmButtonText,
    this.cancelButtonText,
    this.onConfirm,
    this.onCancel,
    this.dialogType = MaxiPocketDialogType.info,
  });

  final String? title;
  final String? subtitle;
  final String? confirmButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? cancelButtonText;
  final MaxiPocketThemeMode themeMode;
  final MaxiPocketDialogType dialogType;

  List<Widget> _buildActions() {
    final List<Widget> actions = <Widget>[];
    final bool hasCancel = cancelButtonText != null && cancelButtonText!.isNotEmpty && onCancel != null;
    final bool hasConfirm = confirmButtonText != null && confirmButtonText!.isNotEmpty && onConfirm != null;

    if (hasConfirm && hasCancel) {
      actions.add(
        MaxiPocketButtonWidget(
          label: cancelButtonText!,
          onPressed: onCancel,
          themeMode: themeMode,
          backgroundColor: ThemeLightColors.errorColor,
        ),
      );
      actions.add(
        MaxiPocketButtonWidget(
          label: confirmButtonText!,
          onPressed: onConfirm,
          themeMode: themeMode,
          backgroundColor: ThemeLightColors.secondaryColor,
        ),
      );
    } else {
      if (hasConfirm) {
        actions.add(
          MaxiPocketButtonWidget(
            label: confirmButtonText!,
            onPressed: onConfirm,
            width: double.infinity,
            themeMode: themeMode,
            backgroundColor: ThemeLightColors.secondaryColor,
          ),
        );
      }
      if (hasCancel) {
        actions.add(
          MaxiPocketButtonWidget(
            label: cancelButtonText!,
            onPressed: onCancel,
            width: double.infinity,
            themeMode: themeMode,
            backgroundColor: ThemeLightColors.errorColor,
          ),
        );
      }
    }
    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: subtitle == null || title == null ? const EdgeInsets.all(DesignConstants.spacing24) : null,
      actionsAlignment: MainAxisAlignment.spaceAround,
      titlePadding: const EdgeInsets.only(top: DesignConstants.spacing16, bottom: DesignConstants.spacing8),
      contentPadding: const EdgeInsets.fromLTRB(
        DesignConstants.spacing24,
        DesignConstants.spacing8,
        DesignConstants.spacing24,
        DesignConstants.spacing24,
      ),
      icon: _DialogIcon(dialogType: dialogType, themeMode: themeMode),
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            )
          : null,
      content: subtitle != null
          ? Text(subtitle!, textAlign: TextAlign.center, style: context.textTheme.bodyLarge)
          : null,
      actions: _buildActions(),
    );
  }
}

class _DialogIcon extends StatelessWidget {
  const _DialogIcon({required this.dialogType, required this.themeMode});

  final MaxiPocketDialogType dialogType;
  final MaxiPocketThemeMode themeMode;

  Widget get _getIcon => switch (dialogType) {
    MaxiPocketDialogType.error => const Icon(
      Icons.error_outline,
      color: ThemeLightColors.errorColor,
      size: DesignConstants.icon24,
    ),
    MaxiPocketDialogType.success => const Icon(
      Icons.check_circle_outline,
      color: ThemeLightColors.secondaryDarkColor,
      size: DesignConstants.icon24,
    ),
    MaxiPocketDialogType.info => const Icon(
      Icons.info,
      color: ThemeLightColors.tertiaryColor,
      size: DesignConstants.icon24,
    ),
  };

  Color get _getBackgroundColor => switch (dialogType) {
    MaxiPocketDialogType.error =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.dialogErrorBackgroundColor
          : ThemeDarkColors.dialogErrorBackgroundColor,
    MaxiPocketDialogType.success =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.dialogSuccessBackgroundColor
          : ThemeDarkColors.dialogSuccessBackgroundColor,
    MaxiPocketDialogType.info =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.dialogInfoBackgroundColor
          : ThemeDarkColors.dialogInfoBackgroundColor,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: _getBackgroundColor, shape: BoxShape.circle),
      child: _getIcon,
    );
  }
}
