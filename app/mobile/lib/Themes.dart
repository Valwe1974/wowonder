import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

const Color colorTextBoardingLight1 = Color(0xffFE4E66);

const Color ColorsTextCommentsLight = Colors.grey;

const Color colorBackLight = Color.fromARGB(255, 235, 235, 235);
const Color colorBlackDark = Color.fromARGB(255, 0, 0, 0);

///

const Color WelcomeHeaderCol = Color(0xffFE4E66);

const Color WelcomeHeader2 = Color.fromARGB(255, 149, 31, 47);

const Color NavBarColorDark = Color(0xff080E1D);
const Color centarColorDark = Color.fromARGB(255, 23, 26, 35);

///
///Colors Apps Dark
///FE4E66
///
const Color ColorsTextCommentsDark = Colors.white;
const Color colorBackRoundCommentsDark = Color.fromARGB(255, 0, 0, 0);
const Color colorTextBoardingDark1 = Color(0xffFE4E66);
const Color colorTextBoardingDark2 = Color.fromARGB(255, 197, 197, 197);

const Color backRoundContLight = Colors.white;
const Color backRoundContDark = Color.fromARGB(255, 18, 23, 32);

const Color WhiteBack = Color(0xffEDF0F5);

////new Thems
const Color ColorsOnPordingDark = Color(0xff22495A);
const Color ColorNameApp = Color.fromARGB(255, 1, 48, 78);

const Color languageSettings = Color(0xff080E1D);
const Color darkGreyClr = Color(0xFF080E1D);
const Color mainColor = Color(0xff00BE84);

class ThemesApp {
  static final light = ThemeData(
    primaryColor: mainColor,
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    backgroundColor: Color(0xffFFFFFF),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    scaffoldBackgroundColor: languageSettings,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
