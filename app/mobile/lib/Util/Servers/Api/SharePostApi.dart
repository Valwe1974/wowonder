import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class SharePostApi {
  static Future Shere(String ty, String iss, String text) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: ty,
      accounts[0]['use']: await SharedP.Get(accounts[0]['use']),
      if (text.isEmpty) 'text': text,
      accounts[0]['is']: iss,
    });

    var resp = response.body;

    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      if (json['data'][accounts[0]['is']] == iss) Get.back();

      return json;
    } else {
      return json;
    }
  }
}
