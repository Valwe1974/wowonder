import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMessageGroupsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetChatGroups {
  static Future<List<GetAllMessageGroupsModel>> chat(String userid) async {
    var url = Uri.parse(accounts[0]['GroCh'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetAllMessageGroupsModel> posts = <GetAllMessageGroupsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': 'fetch_messages',
      'id': userid
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data']['messages'];
    print(wwwdata);
    for (var item in wwwdata) {
      posts.add(GetAllMessageGroupsModel.fromJson(item));
    }
    // print(wwwdata);
    return posts;
  }
}
