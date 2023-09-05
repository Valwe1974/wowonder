import 'package:flutter/material.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class LodingWidgetStorye extends StatelessWidget {
  const LodingWidgetStorye({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerPro.sized(
      light: ShimmerProLight.darker,
      scaffoldBackgroundColor: Colors.black,
      height: 100,
      width: 100,
      borderRadius: 20,
    );
  }
}
