// ApiBlockUnBlockUser

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiSocialLogin {
  static Future lgin(String social, String tok) async {
    final status = await OneSignal.shared.getDeviceState();
    var url = Uri.parse(accounts[0]['facebook']);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['prov']: social,
      accounts[0]['access']: tok,
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
