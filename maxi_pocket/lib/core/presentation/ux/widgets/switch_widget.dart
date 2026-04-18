import 'package:flutter/material.dart';

class MaxiPocketSwitchWidget extends StatelessWidget {
  const MaxiPocketSwitchWidget({required this.value, super.key, this.onChanged});

  final ValueChanged<bool>? onChanged;
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
