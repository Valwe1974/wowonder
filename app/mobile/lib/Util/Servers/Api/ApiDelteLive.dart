import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiDelteLive {
  static Future dele({
    required String pos,
  }) async {
    var url = Uri.parse(accounts[0]['lll'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'delete',
      accounts[0]['pos']: pos,
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
