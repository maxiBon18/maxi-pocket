import 'package:flutter/material.dart';
import 'package:maxi_pocket/core/shared/constants/assets_constants.dart' show AssetsConstants;
import 'package:maxi_pocket/core/shared/constants/design_constants.dart' show DesignConstants;

/// Displays the empty-data GIF with soft faded edges via a radial gradient mask.
class MaxiPocketEmptyDataImageWidget extends StatelessWidget {
  const MaxiPocketEmptyDataImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => const RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.black, Colors.transparent],
        stops: [0.9, 1.0],
      ).createShader(rect),
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        AssetsConstants.emptyDataImage,
        width: DesignConstants.emptyDataImageSize,
        height: DesignConstants.emptyDataImageSize,
        fit: BoxFit.cover,
      ),
    );
  }
}
