import 'dart:convert';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiRegister {
  static Future fetReg(String username, String email, String password,
      phone_num, String gender) async {
    final status = await OneSignal.shared.getDeviceState();
    final acc = accounts[0];
    var url = Uri.parse(acc['register']);

    var response = await http.post(url, body: {
      acc['sm1']: acc['sm2'],
      acc['u']: username,
      acc['e']: email,
      acc['p']: password.toString(),
      acc['ec']: password.toString(),
      'g': gender,
      'ph': phone_num,
      if (GetPlatform.isAndroid)
        accounts[0]['andm']: status == null ? '' : status.userId.toString(),
      if (GetPlatform.isIOS)
        accounts[0]['iosm']: status == null ? '' : status.userId.toString(),
      if (GetPlatform.isAndroid)
        accounts[0]['adnn']: status == null ? '' : status.userId.toString(),
      if (GetPlatform.isIOS)
        accounts[0]['iosn']: status == null ? '' : status.userId.toString(),
    });

    var resp = response.body;

    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}
