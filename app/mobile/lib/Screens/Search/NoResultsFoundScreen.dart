import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class NoResultsFoundScreen extends StatelessWidget {
  const NoResultsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          images.NoReults,
          height: Get.height * 0.30,
        ),
        Text(
          'No Results Found'.tr,
          style: SafeGoogleFont(Fonts.font1,
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Please make sure it is written correctly.'.tr),
        ),
      ],
    );
  }
}
