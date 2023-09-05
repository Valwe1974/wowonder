import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiFrindRequestAccpt {
  static Future cratepost(String reqq, String use) async {
    // ignore: unused_local_variable
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(accounts[0]['accsF'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['reqq']: reqq,
      accounts[0]['use']: use,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    print(json);

    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}
