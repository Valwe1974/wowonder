// ApiAddWallet

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiAddWallet {
  static Future add({
    required String u,
    required String p,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['wall'] + token);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['to'],
      accounts[0]['use']: u,
      accounts[0]['am']: p
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
