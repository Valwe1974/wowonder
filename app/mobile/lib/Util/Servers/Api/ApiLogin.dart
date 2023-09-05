import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class LoginApi {
  static Future fetLogin(String u, String w) async {
    var headers = {"Content-Type": "application/x-www-form-urlencoded"};
    var url = Uri.parse(accounts[0]['sq']);
    final status = await OneSignal.shared.getDeviceState();
    var response = await http.post(url, headers: headers, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      if (GetPlatform.isAndroid) accounts[0]['u']: u,
      if (GetPlatform.isAndroid) accounts[0]['p']: w,
      if (GetPlatform.isIOS) accounts[0]['u']: u,
      if (GetPlatform.isIOS) accounts[0]['p']: w,
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
    response.headers.addAll(headers);
    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}
