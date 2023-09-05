import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiAddImagesAlbum {
  static Future add(
    String t,
    String albo,
    String pos,
    String iss,
    pathpostPhotos,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['alb'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: t,
      if (albo.isNotEmpty) accounts[0]['albo']: albo,
      if (pos.isNotEmpty) accounts[0]['pos']: pos,
      if (iss.isNotEmpty) accounts[0]['is']: iss
    });
    if (pathpostPhotos!.isNotEmpty)
      List.generate(pathpostPhotos.length, (index) async {
        request.files.add(await http.MultipartFile.fromPath(
            accounts[0]['jsjs'], pathpostPhotos[index].path));
      });
    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var ameen = await response.stream.bytesToString();
      var jsonD = jsonDecode(ameen);
      print(jsonD);
      return jsonD;
    } else {
      print(response.reasonPhrase);
    }
  }
}
