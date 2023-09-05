import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiCommentLive {
  static Future CreateComments(
      String post_id, text, imageasset, String type) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['comm'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': type,
      if (type == 'create') accounts[0]['pos']: post_id,
      if (type == 'create_reply') 'comment_id': post_id,
      if (text != null) 'text': text,
    });

    imageasset != null
        ? request.files.add(
            await http.MultipartFile.fromPath('image', imageasset.toString()))
        : null;

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
