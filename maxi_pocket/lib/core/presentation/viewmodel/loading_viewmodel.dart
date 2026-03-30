import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/domain/entities/loading.dart';
import 'package:maxi_pocket/core/presentation/ux/widgets/overlay_loading_widget.dart';

class LoadingViewmodel {
  Loading? loading;

  void showLoading({required BuildContext context}) {
    EasyThrottle.throttle('show-loading-throttler', const Duration(milliseconds: 500), () {
      loading = _setOverlayLoading(context: context);
    });
  }

  void hideLoading() {
    if (loading == null) return;
    loading?.onClose.call();
    loading = null;
  }

  Loading? _setOverlayLoading({required BuildContext context}) {
    final OverlayState? state = context.findAncestorStateOfType<OverlayState>();
    if (state == null) return null;

    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) => const MaxiPocketOverlayLoadingWidget(),
    );

    state.insert(overlayEntry);

    return Loading(
      onClose: () {
        overlayEntry.remove();
        overlayEntry.dispose();
      },
    );
  }
}
