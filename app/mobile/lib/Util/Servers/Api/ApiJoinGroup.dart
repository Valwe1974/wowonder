import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiJoinGroup {
  static Future joinG(String gor) async {
    var url = Uri.parse(accounts[0]['goiG'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['gor']: gor,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);

    return datajson;
  }
}
