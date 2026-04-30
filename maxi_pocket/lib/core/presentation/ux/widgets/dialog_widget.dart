import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/presentation/theme/theme.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/button_widget.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode, MaxiPocketDialogType;
import 'package:maxi_pocket/core/shared/utils/extensions.dart';

/// Presents a themed adaptive alert dialog and returns the value the caller chooses.
///
/// Delegates to [showAdaptiveDialog] so the dialog follows platform conventions
/// (Material on Android, Cupertino on iOS). [dialogType] drives the icon and
/// button background colors; pass callbacks for [onConfirm] and [onCancel] to
/// make the respective buttons appear.
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
}) => showAdaptiveDialog(
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

/// Themed alert dialog used across all features for confirmations and error feedback.
///
/// Renders an icon, title, body text, and up to two action buttons whose colors
/// adapt to [dialogType] and [themeMode]. Use [showAlertDialog] to display it.
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

  List<Color> _getActionBackgroundColor() {
    final bool hasCancel = cancelButtonText != null && cancelButtonText!.isNotEmpty && onCancel != null;
    final bool hasConfirm = confirmButtonText != null && confirmButtonText!.isNotEmpty && onConfirm != null;
    final List<Color> actionBackgroundColors = <Color>[];

    switch (dialogType) {
      case MaxiPocketDialogType.error:
        if (hasCancel && hasConfirm) {
          if (themeMode == MaxiPocketThemeMode.light) {
            actionBackgroundColors.add(ThemeLightColors.dialogCancelBackgroundColor);
            actionBackgroundColors.add(ThemeLightColors.dialogErrorBackgroundColor);
          } else {
            actionBackgroundColors.add(ThemeDarkColors.dialogErrorBackgroundColor);
            actionBackgroundColors.add(ThemeLightColors.dialogErrorBackgroundColor);
          }
          return actionBackgroundColors;
        }
        if (!hasCancel && hasConfirm) {
          actionBackgroundColors.add(ThemeLightColors.dialogErrorBackgroundColor);
          return actionBackgroundColors;
        }
        if (hasCancel && !hasConfirm) {
          if (themeMode == MaxiPocketThemeMode.light) {
            actionBackgroundColors.add(ThemeLightColors.dialogCancelBackgroundColor);
          } else {
            actionBackgroundColors.add(ThemeDarkColors.dialogErrorBackgroundColor);
          }

          return actionBackgroundColors;
        }
        return actionBackgroundColors;
      case MaxiPocketDialogType.success:
        if (hasCancel && hasConfirm) {
          if (themeMode == MaxiPocketThemeMode.light) {
            actionBackgroundColors.add(ThemeLightColors.dialogCancelBackgroundColor);
            actionBackgroundColors.add(ThemeLightColors.secondaryColor);
          } else {
            actionBackgroundColors.add(ThemeDarkColors.dialogErrorBackgroundColor);
            actionBackgroundColors.add(ThemeDarkColors.secondaryColor);
          }
          return actionBackgroundColors;
        }
        if (!hasCancel && hasConfirm) {
          actionBackgroundColors.add(ThemeLightColors.secondaryColor);
          return actionBackgroundColors;
        }
        if (hasCancel && !hasConfirm) {
          if (themeMode == MaxiPocketThemeMode.light) {
            actionBackgroundColors.add(ThemeLightColors.dialogCancelBackgroundColor);
          } else {
            actionBackgroundColors.add(ThemeDarkColors.dialogErrorBackgroundColor);
          }
          return actionBackgroundColors;
        }
        return actionBackgroundColors;
      case MaxiPocketDialogType.info:
        return actionBackgroundColors;
    }
  }

  List<Widget> _buildActions() {
    final List<Widget> actions = <Widget>[];
    final bool hasCancel = cancelButtonText != null && cancelButtonText!.isNotEmpty && onCancel != null;
    final bool hasConfirm = confirmButtonText != null && confirmButtonText!.isNotEmpty && onConfirm != null;
    final List<Color> actionBackgroundColors = _getActionBackgroundColor();

    if (hasConfirm && hasCancel) {
      actions.add(
        Row(
          children: <Widget>[
            Expanded(
              child: MaxiPocketButtonWidget(
                label: cancelButtonText!,
                onPressed: onCancel,
                themeMode: themeMode,
                backgroundColor: actionBackgroundColors[0],
              ),
            ),
            const SizedBox(width: DesignConstants.spacing8),
            Expanded(
              child: MaxiPocketButtonWidget(
                label: confirmButtonText!,
                onPressed: onConfirm,
                themeMode: themeMode,
                backgroundColor: actionBackgroundColors[1],
              ),
            ),
          ],
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
            backgroundColor: actionBackgroundColors[0],
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
            backgroundColor: actionBackgroundColors[0],
          ),
        );
      }
    }
    return actions;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.bottomNavigationBarBackgroundColor
          : ThemeDarkColors.bottomNavigationBarBackgroundColor,
      icon: _DialogIcon(dialogType: dialogType, themeMode: themeMode),
      titleTextStyle: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      title: title != null ? Text(title!, textAlign: TextAlign.center) : null,
      content: subtitle != null ? Text(subtitle!, textAlign: .center) : null,
      contentTextStyle: context.textTheme.bodyLarge,
      actions: _buildActions(),
      actionsAlignment: .center,
      actionsOverflowAlignment: OverflowBarAlignment.end,
      actionsOverflowDirection: VerticalDirection.down,
      actionsOverflowButtonSpacing: DesignConstants.spacing8,
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
      color: ThemeLightColors.primaryColor,
      size: DesignConstants.icon32,
    ),
    MaxiPocketDialogType.success => const Icon(
      Icons.check_circle_outline,
      color: ThemeLightColors.secondaryDarkColor,
      size: DesignConstants.icon32,
    ),
    MaxiPocketDialogType.info => const Icon(
      Icons.info,
      color: ThemeLightColors.tertiaryColor,
      size: DesignConstants.icon32,
    ),
  };

  Color get _getBackgroundColor => switch (dialogType) {
    MaxiPocketDialogType.error =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.primarySurfaceColor
          : ThemeDarkColors.dialogErrorBackgroundColor,
    MaxiPocketDialogType.success =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.badgeFinancingBackgroundColor
          : ThemeDarkColors.dialogSuccessBackgroundColor,
    MaxiPocketDialogType.info =>
      themeMode == MaxiPocketThemeMode.light
          ? ThemeLightColors.dialogInfoBackgroundColor
          : ThemeDarkColors.dialogInfoBackgroundColor,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DesignConstants.containerSize56,
      width: DesignConstants.containerSize56,
      decoration: BoxDecoration(color: _getBackgroundColor, shape: BoxShape.circle),
      child: _getIcon,
    );
  }
}
