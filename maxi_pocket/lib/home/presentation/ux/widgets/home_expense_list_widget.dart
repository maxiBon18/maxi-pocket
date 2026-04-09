import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;
import 'package:maxi_pocket/core/shared/utils/enums.dart' show MaxiPocketThemeMode;
import 'package:maxi_pocket/home/presentation/ux/widgets/home_expense_tile_widget.dart'
    show MaxiPocketHomeExpenseTileWidget;

@immutable
class MaxiPocketHomeExpenseListWidget extends StatelessWidget {
  const MaxiPocketHomeExpenseListWidget({super.key, required this.themeMode});

  final MaxiPocketThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) =>
            MaxiPocketHomeExpenseTileWidget(key: ValueKey(index), themeMode: themeMode),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: DesignConstants.spacing12),
        itemCount: 6,
      ),
    );
  }
}
