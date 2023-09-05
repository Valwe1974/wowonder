import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class VerificationApi {
  static Future verificatio(
    pathImgPassport,
    pathMyImage,
    String name,
    filename,
    String comments,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['vri'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      if (name.isNotEmpty) 'name': name,
      if (comments.isNotEmpty) 'text': comments
    });
    request.files
        .add(await http.MultipartFile.fromPath('passport', pathImgPassport));
    request.files.add(await http.MultipartFile.fromPath('photo', pathMyImage));

    http.StreamedResponse response = await request.send();
    var news = await response.stream.bytesToString();
    var json = jsonDecode(news);
    if (response.statusCode == 200) {
    } else {}
    return json;
  }
}
