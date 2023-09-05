import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_emoji_gif_picker/flutter_emoji_gif_picker.dart';

import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGpt.dart/providers/chats_provider.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGpt.dart/providers/models_provider.dart';

import 'package:wowondertimelineflutterapp/String.dart';

import 'package:wowondertimelineflutterapp/Util/Cont/Cont.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSetGen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/notifi_service.dart';
import 'package:wowondertimelineflutterapp/Util/routes/routes.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/Widget/Unfous.dart';
enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }



void main() async {
  
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await dotenv.load(fileName: ".env");
  if (Active_Admob_Ads) MobileAds.instance.initialize();
  await GetStorage.init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? tok = prefs.getString('tok');
  EmojiGifPickerPanel.setup(
      giphyApiKey: 'ZuPQ8uVYjs2cRUVJKZn9ZRMCF2gdDFGY', mode: Mode.light);
  open();
  performEncryption();
  await ApiSetGen.color();
  await SocketNew.socket;
  await newnewSok.socketss;
  await newnewSok.onncteSokets();
  final onsIn = await OnsingalNotfi.code();

  print(tok);
  runApp(MyApp(
    onsIn: onsIn,
    tok: tok,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.tok, required this.onsIn});
  final tok;
  final onsIn;

  @override
  Widget build(BuildContext context) {
    print(tok);

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<UsuariosProvider>(
        //   create: (_) => UsuariosProvider(),
        // ),
        // ChangeNotifierProvider<LiveProvider>(
        //   create: (_) => LiveProvider(),
        // ),
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: GetMetre(tok: tok, onsIn: onsIn),
    );
  }
}

List accounts = [];

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

WidgetsBinding ensureInitialized() {
  if (WidgetsBinding.instance == null) {
    WidgetsFlutterBinding();
  }
  return WidgetsBinding.instance;
}

void Hindall(child) {
  Unfous(child: child);
}

List GetSetList = [];

OfffLineNet() async {
  return await InternetConnectionChecker().hasConnection;
}
