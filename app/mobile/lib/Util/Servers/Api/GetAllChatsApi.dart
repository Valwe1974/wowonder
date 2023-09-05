import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllChatsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class GetAllChatsApi {
  static Future<List<GetAllChatsModel>> allChat(String post_id) async {
    var url = Uri.parse(accounts[0]['getc'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetAllChatsModel> posts = <GetAllChatsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'data_type': 'users',
      'user_limit': '50',
      'user_offset': 'user_offset'
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];

    for (var item in wwwdata) {
      posts.add(GetAllChatsModel.fromJson(item));
    }

    return posts;
  }
}
