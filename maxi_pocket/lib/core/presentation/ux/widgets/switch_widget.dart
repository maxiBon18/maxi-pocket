import 'package:flutter/material.dart';

/// Themed toggle switch used for binary preference settings (e.g. dark mode, notifications).
class MaxiPocketSwitchWidget extends StatelessWidget {
  const MaxiPocketSwitchWidget({
    required this.value,
    super.key,
    this.onChanged,
  });

  /// Callback invoked when the user toggles the switch; pass `null` to disable interaction.
  final ValueChanged<bool>? onChanged;

  /// Current on/off state of the switch.
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged == null
          ? null
          : (bool value) {
              onChanged?.call(value);
            },
    );
  }
}
