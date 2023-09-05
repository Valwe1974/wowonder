import 'dart:io';

class AdsManget {
  static bool _testMode = true;

  static String get AppIdEx {
    if (Platform.isAndroid) {
      return '';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw new UnsupportedError('Unsupportd platform');
    }
  }

  ///baner
  ///
}
