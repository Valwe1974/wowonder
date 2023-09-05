// ApiGetAlbums
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAlbumsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetAlbums {
  static Future<List<GetAlbumsModel>> GetBlock() async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(accounts[0]['alb'] + await SharedP.Get('tok'));

    List<GetAlbumsModel> posts = <GetAlbumsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['ft'],
      accounts[0]['use']: await SharedP.Get(accounts[0]['use']),
      // 'limit':'100'
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson['data'];
    if (datajson['api_status'] == 200) {
      for (var item in data) {
        posts.add(GetAlbumsModel.fromJson(item));
      }

      return posts;
    }

    return posts;
  }
}
