import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Unified image widget that renders both raster and SVG assets.
///
/// Wraps the image in [Semantics] for accessibility and optionally applies
/// rounded corners via [borderRadius]. Supports tap handling through
/// [onPressed].
///
/// ```dart
/// MaxiPocketImage(
///   image: 'assets/images/logo.png',
///   height: 48,
///   width: 48,
/// );
///
/// MaxiPocketImage(
///   image: 'assets/images/icon.svg',
///   isSvg: true,
///   adaLabel: 'Settings icon',
///   onPressed: () => openSettings(),
/// );
/// ```
@immutable
class MaxiPocketImage extends StatelessWidget {
  const MaxiPocketImage({
    required this.image,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onPressed,
    this.borderRadius,
    this.adaLabel,
    this.adaHint,
    this.quality,
    this.isSvg = false,
  });

  final String image;

  final double? width;
  final double? height;

  /// Tap callback. When non-null, the semantics node is marked as a button.
  final VoidCallback? onPressed;

  /// How the image should be inscribed into the layout bounds.
  final BoxFit fit;

  /// When non-null, clips the image with the given corner radius.
  final double? borderRadius;

  /// Accessibility label read by screen readers.
  final String? adaLabel;

  /// Accessibility hint providing additional context for the action.
  final String? adaHint;

  /// Raster filter quality. Defaults to [FilterQuality.medium] for raster
  /// images. Ignored for SVG assets.
  final FilterQuality? quality;

  /// Set to `true` to render [image] as an SVG via [SvgPicture.asset].
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget = isSvg
        ? SvgPicture.asset(image, height: height, width: width, fit: fit)
        : Image.asset(image, height: height, width: width, fit: fit, filterQuality: quality ?? FilterQuality.medium);
    return Semantics(
      container: true,
      image: true,
      button: onPressed != null,
      label: adaLabel,
      hint: adaHint,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onPressed,
        child: borderRadius != null
            ? ClipRRect(borderRadius: BorderRadius.circular(borderRadius!), child: imageWidget)
            : imageWidget,
      ),
    );
  }
}
