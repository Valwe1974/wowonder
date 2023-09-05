import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart';
import 'package:weather/weather.dart';

import 'package:wowondertimelineflutterapp/Screens/Language/SettingsLang.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiLang.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class SettingController extends GetxController {
  var swithchValue = Get.isDarkMode.obs;
  var SchekBox = false.obs;

  var storage = GetStorage();
  var langLocal = eng;

  String capitalize(String profileName) {
    return profileName.split(" ").map((name) => name.capitalize).join(" ");
  }

  //Language
  String key = '6c75de8e46c3935ade2f4f43e38dd6f1';
  late WeatherFactory ws;
  List<Weather> dataWhait = [];
  AppState _state = AppState.NOT_DOWNLOADED;
  String? _currentAddress;
  Position? _currentPosition;

  @override
  void onInit() async {
    super.onInit();
    ws = new WeatherFactory(key);
    queryWeather();
    langLocal = await getLanguage;
  }

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      _currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      update();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  double? lat, lon;
  void queryWeather() async {
    /// Removes keyboard
    ///  List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);

    _state = AppState.FINISHED_DOWNLOADING;

    _state = AppState.DOWNLOADING;
    update();
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      update();
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });

    Weather weather = await ws.currentWeatherByLocation(
        _currentPosition!.latitude, _currentPosition!.longitude);

    dataWhait = [weather];
    _state = AppState.FINISHED_DOWNLOADING;
    update();
  }

  void saveLanguage(String lang) async {
    // ignore: unnecessary_null_comparison
    if (lang == null) {
      await storage.write('lang', languagedefault);
    } else {
      await storage.write('lang', lang);
    }
  }

  Future<String> get getLanguage async {
    if (storage.read("lang") == null)
      await storage.write('lang', languagedefault);
    print(storage.read("lang"));
    return await storage.read("lang");
  }

  void changeLanguage(String typeLang) {
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    }

    if (typeLang == fra) {
      langLocal = fra;
      saveLanguage(fra);
      lang('french');
    } else if (typeLang == ara) {
      langLocal = ara;
      saveLanguage(ara);
      lang('arabic');
    } else if (typeLang == rus) {
      langLocal = rus;
      lang(russian);
      saveLanguage(rus);
      lang('russian');
    } else if (typeLang == eng) {
      langLocal = eng;
      saveLanguage(eng);
      lang('english');
    } else if (typeLang == ben) {
      langLocal = ben;
      saveLanguage(ben);
      lang('bengali');
    } else if (typeLang == zho) {
      langLocal = zho;
      saveLanguage(zho);
      lang('chinese');
    } else if (typeLang == hrv) {
      langLocal = hrv;
      saveLanguage(hrv);
      lang('croatian');
    } else if (typeLang == eng) {
      langLocal = dan;
      saveLanguage(dan);
      lang('danish');
    } else if (typeLang == nld) {
      langLocal = nld;
      saveLanguage(nld);
      lang('dutch');
    } else if (typeLang == fil) {
      langLocal = fil;
      saveLanguage(fil);
      lang('filipino');
    } else if (typeLang == deu) {
      langLocal = deu;
      saveLanguage(deu);
      lang('german');
    } else if (typeLang == hin) {
      langLocal = hin;
      saveLanguage(hin);
      lang('hindi');
    } else if (typeLang == ind) {
      langLocal = ind;
      saveLanguage(ind);
      lang('indonesian');
    } else if (typeLang == ita) {
      langLocal = ita;
      saveLanguage(ita);
      lang('italian');
    } else if (typeLang == kor) {
      langLocal = kor;
      saveLanguage(kor);
      lang('korean');
    } else if (typeLang == per) {
      langLocal = per;
      saveLanguage(per);
      lang('persian');
    } else if (typeLang == por) {
      langLocal = por;
      saveLanguage(por);
      lang('portuguese');
    } else if (typeLang == spa) {
      langLocal = spa;
      saveLanguage(spa);
      lang('spanish');
    } else if (typeLang == tur) {
      langLocal = tur;
      saveLanguage(tur);
      lang('turkish');
    } else if (typeLang == urd) {
      langLocal = urd;
      saveLanguage(urd);
      lang('urdu');
    } else if (typeLang == vie) {
      langLocal = vie;
      saveLanguage(urd);
      lang('vietnamese');
    } else {
      langLocal = eng;

      saveLanguage(eng);
    }
    update();
  }
}

void lang(String langs) async {
  final tok = await SharedP.Get('tok');
  if (tok != null) {
    await ApiLang.edite(langs);
  } else {
    print('no token');
  }
}
