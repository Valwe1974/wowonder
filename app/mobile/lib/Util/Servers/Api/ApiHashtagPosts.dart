import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiHashtagPosts {
  static Future<List<PostModel>> Getposts(
      // String after_post_id,
      String hasht) async {
    String fileName = "PostsCash.json";

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<PostModel> posts = <PostModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': 'hashtag',
      'hash': hasht,
      // 'after_post_id': after_post_id,
      // 'limit': numberofposts,

      //  'post_type': 'video'
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    print(datajson);

    for (var item in wwwdata) {
      posts.add(PostModel.fromJson(item));
    }

    return posts;
  }
}
