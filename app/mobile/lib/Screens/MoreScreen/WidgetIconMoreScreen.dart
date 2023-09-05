
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class WidgetIconMoreScreen extends StatelessWidget {
  WidgetIconMoreScreen({
    required this.text,
    required this.svg,
    required this.backRound,
    required this.colorSvg,
    super.key,
  });
  String text;
  String svg;
  Color backRound;
  Color colorSvg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: Get.width * 0.14,
            height: Get.height * 0.08,
            decoration: BoxDecoration(
                color: backRound, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(svg, color: colorSvg),
            ),
          ),
          Text(
            text,
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
