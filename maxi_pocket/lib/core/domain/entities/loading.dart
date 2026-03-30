import 'package:flutter/material.dart';

@immutable
class Loading {
  final VoidCallback onClose;

  const Loading({required this.onClose});
}
