import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class ApiGetMyVideo {
  static Future<List<PostModel>> Getposts(
      String after_post_id, post_type) async {
    String fileName = "GetMyVideoPosts.json";

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();
    final String? myuserid = await SharedP.Get('user_id');

    List<PostModel> posts = <PostModel>[];
    File file = new File(dir.path + "/" + fileName);
    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['ty']: 'get_news_feed',
        accounts[0]['aft']: after_post_id,

        'id': myuserid.toString(),
        'post_type': post_type,

        'limit': '50',

        //  'post_type': 'video'
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data'];
      print(datajson);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      for (var item in wwwdata) {
        posts.add(PostModel.fromJson(item));
      }
      return posts;
    } catch (eror) {
      print('No NetWork');
    }
    var jsonData = file.readAsStringSync();
    var dataReed = jsonDecode(jsonData);
    var datadecde = dataReed['data'];
    for (var item in datadecde) {
      posts.add(PostModel.fromJson(item));
    }

    return posts;
  }
}
