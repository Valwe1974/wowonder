import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMessageGroupsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGroupChatCreate {
  static Future chat(
      {required userid, required path, required String group_name}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['GroCh'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['cr'],
      'group_name': group_name,
      'parts': '1',
    });
    if (path.toString().isNotEmpty)
      request.files.add(await http.MultipartFile.fromPath('avatar', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var news = await response.stream.bytesToString();
      var jsonC = jsonDecode(news);
      return jsonC;
    } else {
      print(response.reasonPhrase);
    }
  }
}
