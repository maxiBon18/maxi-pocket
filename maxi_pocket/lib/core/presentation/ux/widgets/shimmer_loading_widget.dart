import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:maxi_pocket/core/shared/controllers/di.dart';

/// Applies a shimmer gradient mask to [child] while [isLoading] is `true`.
///
/// Must be placed inside a [Shimmer] ancestor that drives the animation.
/// When no ancestor is found, a warning is logged and an empty box is returned.
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    required this.isLoading,
    required this.child,
    super.key,
  });

  /// When `true`, the shimmer gradient mask is applied; when `false`, [child] is rendered normally.
  final bool isLoading;

  /// Widget rendered directly when not loading, or masked by the shimmer gradient when loading.
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;
  final Logger _logger = getDI<Logger>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    final ShimmerState? shimmer = Shimmer.of(context);
    if (shimmer != null) {
      if (!shimmer.isSized) {
        return const SizedBox();
      }
      final Size shimmerSize = shimmer.size;
      final Gradient gradient = shimmer.gradient;
      final Offset offsetWithinShimmer = shimmer.getDescendantOffset(
        descendant: context.findRenderObject() as RenderBox,
      );

      return ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) {
          return gradient.createShader(
            Rect.fromLTWH(
              -offsetWithinShimmer.dx,
              -offsetWithinShimmer.dy,
              shimmerSize.width,
              shimmerSize.height,
            ),
          );
        },
        child: widget.child,
      );
    } else {
      _logger.w(
        'Shimmer loading used without Shimmer parent! You should wrap ancestors with the Shimmer() widget',
      );
      return const SizedBox();
    }
  }
}

/// Root widget that drives the shimmer animation for all [ShimmerLoading] descendants.
///
/// Provide a [linearGradient] that defines the shimmer sweep colours; the gradient
/// is animated across the widget's bounding box via [_SlidingGradientTransform].
class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({required this.linearGradient, super.key, this.child});

  /// Gradient that defines the shimmer highlight sweep colours and direction.
  final LinearGradient linearGradient;

  /// Subtree containing one or more [ShimmerLoading] widgets.
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  /// Animation listenable that [ShimmerLoading] subscribes to for triggering repaints.
  Listenable get shimmerChanges => _shimmerController;

  /// Current animated gradient derived from [widget.linearGradient] with the sliding transform applied.
  Gradient get gradient => LinearGradient(
    colors: widget.linearGradient.colors,
    stops: widget.linearGradient.stops,
    begin: widget.linearGradient.begin,
    end: widget.linearGradient.end,
    transform: _SlidingGradientTransform(
      slidePercent: _shimmerController.value,
    ),
  );

  /// Whether this widget's [RenderBox] has been laid out and has a valid size.
  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  /// The current render size of this shimmer container, used to position descendant masks.
  Size get size => (context.findRenderObject() as RenderBox).size;

  /// Returns the [descendant]'s position in this widget's local coordinate space.
  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final RenderBox shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
