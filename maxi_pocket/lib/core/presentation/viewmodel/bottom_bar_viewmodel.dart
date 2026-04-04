import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the currently selected bottom-navigation index.
final bottomBarProvider = NotifierProvider<BottomBarViewModel, int>(BottomBarViewModel.new);

/// Holds and updates the bottom-navigation selected index.
///
/// Index 0 → Home, 1 → Expenses, 2 → Settings — matching the destination
/// order defined in [MaxiPocketBottomBarWidget].
class BottomBarViewModel extends Notifier<int> {
  @override
  int build() => 0;

  /// Updates the selected tab to [index].
  void setCurrentIndex(int index) {
    state = index;
  }
}
