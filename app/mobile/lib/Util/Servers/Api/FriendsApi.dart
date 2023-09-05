import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class FriendsApi {
  static Future<List<GetAllFrindsModel>> allFrinds(
      String litem, String user_id, String following_offset) async {
    final prefs = await SharedPreferences.getInstance();

    final String? myuserid = prefs.getString('user_id');
    var url = Uri.parse(accounts[0]['getf'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetAllFrindsModel> posts = <GetAllFrindsModel>[];

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['ty']: 'followers,following',
        if (user_id.isEmpty) 'user_id': myuserid,
        if (user_id.isNotEmpty) 'user_id': user_id,
        if (litem.isNotEmpty) 'limit': litem,
        if (following_offset.isNotEmpty) 'following_offset': following_offset,
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data']['following'];

      for (var item in wwwdata) {
        posts.add(GetAllFrindsModel.fromJson(item));
      }

      return posts;
    } catch (e) {
      print('لا يوجد انترنت');
    }

    return posts;
  }
}
