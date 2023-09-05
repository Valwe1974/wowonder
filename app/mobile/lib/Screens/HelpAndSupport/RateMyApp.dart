import 'package:flutter/services.dart';

class StroeReditect {
  static const MethodChannel _channel = const MethodChannel('store_redirct');

  static Future<void> redirct(
      {String? androidAppId, String, String? IOSAppId}) async {
    await _channel.invokeMethod(
        'redirct', {'adnroid_id': androidAppId, 'ios_id': IOSAppId});
    return null;
  }
}
