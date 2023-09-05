import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiSendMessageGroups {
  static Future send({
    required mediaId,
    required String group_id,
    required String gif,
    required String text,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['GroCh'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': 'send',
      'id': group_id,
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

