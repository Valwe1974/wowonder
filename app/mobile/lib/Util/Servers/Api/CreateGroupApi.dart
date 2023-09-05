import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class CreateGroupApi {
  static Future create(
    String group_name,
    String group_title,
    String category,
    String about,
    String privacy,
  ) async {
    var url = Uri.parse(accounts[0]['creGo'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'group_name': group_name,
      'group_title': group_title,
      'category': category,
      'about': about,
      'privacy': privacy,
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
