import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wowondertimelineflutterapp/Screens/Language/LanguageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Language/SettingsLang.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/Util/logic/bindings/ObBoos.dart';
import 'package:wowondertimelineflutterapp/Util/logic/bindings/main_bindings.dart';
import 'package:wowondertimelineflutterapp/Widget/Unfous.dart';
import 'package:wowondertimelineflutterapp/controllers/thems_controllers.dart';

class AppRoutes {
  //initalRoute

  static const langScreen = Routes.languageScreen;

  static const hoMeNavBar = Routes.homenavebar;
  static const ObsObs = Routes.obsobs;

  //GetPage
  static final routes = [
    GetPage(
        name: Routes.languageScreen,
        page: (() => LanguageScreen(lang: true)),
        bindings: [
          MainBininding(),
        ]),

    GetPage(name: Routes.obsobs, page: (() => ObBoos()), bindings: [
      MainBininding(),
    ]),
    //navbar
    GetPage(name: Routes.homenavebar, page: (() => HomeNavBar()), bindings: [
      MainBininding(),
    ]),
  ];
}

// CreatePostScreen OnBoardingScreen
class Routes {
  static const languageScreen = '/LanguageScreen';
  static const homenavebar = '/HomeNavBar';
  static const obsobs = '/ObBoos';
}

Widget GetMetre({required onsIn, required tok}) {
  return GetMaterialApp(
    locale: Locale(GetStorage().read<String>('lang').toString()),
    translations: LocaliztionApp(),
    fallbackLocale: Locale(languagedefault),
    themeMode: ThemeController().themeDataGet,
    theme: ThemesApp.light,
    darkTheme: ThemesApp.dark,
    debugShowCheckedModeBanner: false,
    builder: (_, child) => Unfous(child: child!),
    title: nameApp,
    // home: SignInDemo(),
    initialRoute: onsIn
        ? tok == null
            ? AppRoutes.langScreen
            : AppRoutes.hoMeNavBar
        : AppRoutes.ObsObs,

    getPages: AppRoutes.routes,
  );
}
