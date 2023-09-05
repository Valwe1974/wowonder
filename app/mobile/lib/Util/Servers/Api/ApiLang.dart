import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiLang {
  static Future edite(String lang) async {
    var url = Uri.parse(accounts[0]['usUp'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'language': lang,
    });
    var resp = response.body;

    print(resp);

    try {
      return resp;
    } catch (erorr) {
      print(erorr);
    }

    return;
  }
}
