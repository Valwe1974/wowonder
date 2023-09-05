// ApiGetBlocked
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FollowingModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetBlocked {
  static Future<List<FollowingModel>> GetBlock() async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(accounts[0]['getBlo'] + await SharedP.Get('tok'));

    List<FollowingModel> posts = <FollowingModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson['blocked_users'];
    if (datajson['api_status'] == 200) {
      for (var item in data) {
        posts.add(FollowingModel.fromJson(item));
      }

      return posts;
    }

    return posts;
  }
}
