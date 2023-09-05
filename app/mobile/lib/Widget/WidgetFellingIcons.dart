import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetFellingIcons extends StatelessWidget {
  WidgetFellingIcons({
    required this.text,
    super.key,
  });

  String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (text == 'happy') _icons(text: 'Happy'.tr, icons: '😃'),
        if (text == 'loved') _icons(text: 'Loved'.tr, icons: '🥰'),
        if (text == 'sad') _icons(text: 'Sad'.tr, icons: '😞'),
        if (text == 'so_sad') _icons(text: 'Very Sad'.tr, icons: '😭'),
        if (text == 'angry') _icons(text: 'Angry'.tr, icons: '😡'),
        if (text == 'confused') _icons(text: 'Confused'.tr, icons: '😕'),
        if (text == 'smirk') _icons(text: 'Hot'.tr, icons: '🥵'),
        if (text == 'broke') _icons(text: 'Broken'.tr, icons: '💔'),
        if (text == 'expressionless')
          _icons(text: 'Expressionless'.tr, icons: '😑'),
        if (text == 'cool') _icons(text: 'Cool'.tr, icons: '😎'),
        if (text == 'funny') _icons(text: 'Funny'.tr, icons: '😂'),
        if (text == 'tired') _icons(text: 'Tired'.tr, icons: '😫'),
        if (text == 'lovely') _icons(text: 'Lovely'.tr, icons: '😇'),
        if (text == 'shocked') _icons(text: 'Shocked'.tr, icons: '😵'),
        if (text == 'sleepy') _icons(text: 'Sleepy'.tr, icons: '😴'),
        if (text == 'pretty') _icons(text: 'Pretty'.tr, icons: '🌺'),
        if (text == 'bored') _icons(text: 'Bored'.tr, icons: '🥱'),
      ],
    );
  }
}

class _icons extends StatelessWidget {
  _icons({
    required this.icons,
    super.key,
    required this.text,
  });

  String text;
  String icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.01,
        ),
        Text(
          'Feeling',
          style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: Get.width * 0.01,
        ),
        Text(
          icons,
          style: TextStyle(fontSize: 13),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
