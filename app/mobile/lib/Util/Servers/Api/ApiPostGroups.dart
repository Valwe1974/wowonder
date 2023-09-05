import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await geApiPostGruopsApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class ApiPostGruops {
  static Future<List<PostModel>> Getposts(
    // String after_post_id, post_type
    String iss,
    String after_post_id,
  ) async {
    // ignore: unused_local_variable
    String fileName = "PostsCash.json";

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    // ignore: unused_local_variable
    var dir = await getTemporaryDirectory();

    List<PostModel> posts = <PostModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'get_group_posts',
      'limit': '20',
      accounts[0]['is']: iss,
      'after_post_id': after_post_id,

      // 'after_post_id': after_post_id,
      // 'limit': numberofposts,
      // if (post_type == 1) 'post_type': 'text',
      // if (post_type == 2) 'post_type': 'photos',
      // if (post_type == 3) 'post_type': 'video',
      // if (post_type == 4) 'post_type': 'music',

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

class ApiUplodeImageAvatirGroups {
  static Future Getposts(
    // String after_post_id, post_type

    String gro,
    final avatier,
    final cover,
  ) async {
    var headers = {'Cookie': ''};
    var url = Uri.parse(accounts[0]['upG'] + await SharedP.Get('tok'));
    var request = http.MultipartRequest(
      'POST',
      url,
    );

    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['gor']: gro,
    });
    if (avatier != null)
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        avatier,
        contentType: new MediaType('image', 'png'),
      ));
    if (cover != null)
      request.files.add(await http.MultipartFile.fromPath(
        'cover',
        cover,
        contentType: new MediaType('image', 'png'),
      ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var news = await response.stream.bytesToString();
      var json = jsonDecode(news);

      print(json);
      return json;
    } else {
      print(response.reasonPhrase);
    }
    return json;
  }
}
