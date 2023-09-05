import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiPagePosts {
  static Future<List<PostModel>> Getposts(
      String after_post_id, post_type, iss) async {
    String fileName = "PostsCash.json";

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<PostModel> posts = <PostModel>[];
    File file = new File(dir.path + "/" + fileName);
    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['ty']: 'get_page_posts',
        accounts[0]['aft']: after_post_id,
        accounts[0]['is']: iss,
        'limit': Home_Post_Limit,

        if (post_type == 1) accounts[0]['pt']: 'text',
        if (post_type == 2) accounts[0]['pt']: 'photos',
        if (post_type == 3) accounts[0]['pt']: 'video',
        if (post_type == 4) accounts[0]['pt']: 'music',

        //  'post_type': 'video'
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data'];

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
