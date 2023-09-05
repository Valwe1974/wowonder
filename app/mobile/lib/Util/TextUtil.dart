import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:url_launcher/url_launcher.dart';

//Urbanist //Fonts.font3//SF Pro Display
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle SafeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}

String validationEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String imageasst = 'assets/images/';
String validationName = r'^[a-z A-Z]+$';

double sizeH(context, w) {
  var size = MediaQuery.of(context).size.height * w;
  return size;
}

double sizeW(context, h) {
  var size = MediaQuery.of(context).size.width * h;
  return size;
}

/// Creates the [KeyboardActionsConfig] to hook up the fields
/// and their focus nodes to our [FormKeyboardActions].
KeyboardActionsConfig buildConfigDone(BuildContext context, nodetext) {
  return KeyboardActionsConfig(
    nextFocus: true,
    actions: [
      KeyboardActionsItem(
        focusNode: nodetext,
      ),
    ],
  );
}

UrlGo(url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalNonBrowserApplication,
    webViewConfiguration: const WebViewConfiguration(
        enableDomStorage: true, enableJavaScript: true),
  )) {
    throw Exception('Could not launch $url');
  }
}

Stringlength({required String text, required int length}) {
  return text.length > length
      ? text.substring(0, length) + '...'
      : text.toString();
}
