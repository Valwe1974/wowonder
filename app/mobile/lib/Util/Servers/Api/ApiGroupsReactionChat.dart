import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMessageGroupsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGroupsReactionChat {
  static Future chat(
      {required String id, required String userid, required type}) async {
    var url = Uri.parse(accounts[0]['GroCh'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': type,
      'id': id,
      'user_id': userid
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);

    // print(wwwdata);
    return datajson;
  }
}
