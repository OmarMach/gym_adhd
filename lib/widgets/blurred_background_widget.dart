import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBackgroundWidget extends StatelessWidget {
  const BlurredBackgroundWidget({super.key, required this.child, this.sigmaX = 1, this.sigmaY = 1});
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: child,
    );
  }
}
