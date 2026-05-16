import 'package:flutter/material.dart';

/// Carries the callback needed to dismiss the global loading overlay.
@immutable
class Loading {
  /// Callback invoked to close the loading overlay when the operation finishes.
  final VoidCallback onClose;

  const Loading({required this.onClose});
}
