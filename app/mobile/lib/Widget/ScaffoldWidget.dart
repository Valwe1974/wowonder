import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget(
      {super.key,
      required this.AppBarTrueOrFalse,
      required this.title,
      required this.body,
      required this.centerTitle,
      required this.elevation,
      required this.loding});
  Widget body;
  bool centerTitle;
  double elevation;
  String title;
  bool loding;
  bool AppBarTrueOrFalse;
  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

AnimationBehavior animationBehavior = AnimationBehavior.preserve;

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: widget.loding,
      blurEffectIntensity: 4,
      progressIndicator: SpinKitFadingCircle(
        color: ColorTheme,
        size: 90.0,
      ),
      dismissible: false,
      opacity: 0.4,

      child: Scaffold(
        backgroundColor: Get.isDarkMode ? ColorDarkBackground :  Theme.of(context).scaffoldBackgroundColor,
          appBar: widget.AppBarTrueOrFalse
              ? AppBar(
                  centerTitle: widget.centerTitle,
                  elevation: widget.elevation,
                  foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
                  backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
                  title: Text(widget.title),
                )
              : null,
          body: widget.body),
    );
  }
}
