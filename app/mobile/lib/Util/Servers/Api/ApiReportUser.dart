// ApiGetBlocked
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiReportUser {
  static Future reportUser(String use, String text) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse(accounts[0]['repo'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'user': use,
      'text': text,
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);

    return datajson;
  }
}
