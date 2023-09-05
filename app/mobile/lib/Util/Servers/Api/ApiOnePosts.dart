import 'dart:convert';

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

class ApiPostData {
  static Future<List<PostModel>> postsData(String pos) async {
    // ignore: unused_local_variable
    String fileName = "PostsCash.json";

    var url = Uri.parse(accounts[0]['onep'] + await SharedP.Get('tok'));
    // ignore: unused_local_variable
    var dir = await getTemporaryDirectory();

    List<PostModel> posts = <PostModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: accounts[0]['dapo'],
      accounts[0]['pos']: pos,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['post_data'];
    print(datajson);

    posts.add(PostModel.fromJson(wwwdata));

    return posts;
  }
}
