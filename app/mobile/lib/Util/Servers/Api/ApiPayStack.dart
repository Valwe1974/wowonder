// ApiPayStack

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

import 'package:wowondertimelineflutterapp/main.dart';

class ApiPayStack {
  static Future pay({
    required String e,
    required int am,
  }) async {
    int amam = am * 769;
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['paystack'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['wall1'],
      'request': 'initialize',
      accounts[0]['e']: e,
      accounts[0]['am']: amam.toString() + '00',
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

class ApiPayStackAdd {
  static Future pay({
    required String am,
    required String reference,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['paystack'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'request': accounts[0]['wall1'],
      accounts[0]['am']: am,
      'reference': reference,
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
