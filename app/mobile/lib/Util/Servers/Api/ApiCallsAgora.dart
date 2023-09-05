import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiCallsAgora {
  static Future calls(
    String user_id,
    String call_type,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['ago'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['cr'],
      "recipient_id": user_id,
      "call_type": call_type,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var news = await response.stream.bytesToString();
      var json = jsonDecode(news);
      // print(json['data']);
      return json;
    } else {
      // print(json);
      return json;
    }
  }
}
