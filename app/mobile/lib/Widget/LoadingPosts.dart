import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

// ignore: must_be_immutable
class LodingPostsWidget extends StatelessWidget {
  LodingPostsWidget({super.key, this.len});

  @override
  int? len = 5;
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < len!; i++)
          Container(
            child: ShimmerPro.generated(
                light: Get.isDarkMode
                    ? ShimmerProLight.lighter
                    : ShimmerProLight.darker,
                scaffoldBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        ShimmerPro.sized(
                          borderRadius: 20,
                          light: Get.isDarkMode
                              ? ShimmerProLight.lighter
                              : ShimmerProLight.darker,
                          scaffoldBackgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          height: 30,
                          width: 30,
                        ),
                        ShimmerPro.text(
                          maxLine: 1,
                          width: 50,
                          light: Get.isDarkMode
                              ? ShimmerProLight.lighter
                              : ShimmerProLight.darker,
                          scaffoldBackgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        )
                      ],
                    ),
                    ShimmerPro.text(
                      light: Get.isDarkMode
                          ? ShimmerProLight.lighter
                          : ShimmerProLight.darker,
                      scaffoldBackgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      width: Get.width,
                    )
                  ],
                )),
          ),
      ],
    );
  }
}
