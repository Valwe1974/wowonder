import 'package:flutter/material.dart';

const Color backRoundColorSearch = Color(0xffF8F9FD);
const Color backRoundColorSearchDark = Color.fromARGB(255, 0, 0, 0);
const Color TrueFalseOrangeColor = Color(0xffFF4D2D);
const Color ColorTheme = Color(0xff3BBAA6);
const Color ColorThemeDark = Color(0xff036451);
const Color ColorThemeOpacity = Color(0x5267ead4);
const Color ColorBackIcons = Color(0xfff6f6f6);
const Color ColorsContainer = Colors.white;
const Color scaffoldBackgroundColorLight = Color.fromARGB(255, 242, 239, 239);


/// Dark Theme
const Color ColorDarkBackground = Color(0xff1E252B);
const Color ColorDarkComponents = Color(0xff38404b);
const Color ColorDarkTextBox = Color(0xff2b3843);


LinearGradient linearGradientBoxMore = LinearGradient(
    colors: [
      Color.fromARGB(255, 161, 246, 233),
      Color.fromARGB(255, 70, 215, 193),
    ],
    begin: Alignment.topLeft, //begin of the gradient color
    end: Alignment.bottomRight, //end of the gradient color
    stops: [0, 0.8] //stops for individual color
    //set the stops number equal to numbers of color
    );

Color scaffoldBackgroundColorChatGpt = const Color(0xFF343541);
Color cardColorGpt = const Color(0xFF444654);

///////
class Fonts {
  //Urbanist //Fonts.font3//SF Pro Display
  static String font1 = 'cairo';
  static String font2 = 'Manrope';
  static String font3 = 'Urbanist';
  // static String font4 = Fonts.font1;
}
