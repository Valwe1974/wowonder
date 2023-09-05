import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiSendMessages {
  static Future send(
    String user_id,
    String gif,
    String text,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['senms'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'user_id': user_id,
      'gif': gif,
      'text': text,
      'message_hash_id': 'ajslkdjksaljdklasjkdlj'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var news = await response.stream.bytesToString();
      var json = jsonDecode(news);
      print(json);
      return json;
    } else {
      print(response.reasonPhrase);
      return json;
    }
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

