import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CearchModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiSearch {
  static Future<List<CearchModel>> Getposts(String after_post_id) async {
    var url = Uri.parse(accounts[0]['se'] + await SharedP.Get('tok'));

    List<CearchModel> posts = <CearchModel>[];

    var response =
        await http.post(url, body: {accounts[0]['sm1']: accounts[0]['sm2']});

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['users'];
    var groups = datajson['groups'];

    for (var item in wwwdata) {
      posts.add(CearchModel.fromJson(item));
    }
    for (var item in groups) {
      posts.add(CearchModel.fromJson(item));
    }

    return posts;
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

