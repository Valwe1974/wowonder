import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';
// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class ApiSavedItems {
  static Future<List<PostModel>> Getposts(
      String after_post_id, String user_id) async {
    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    // var dir = await getTemporaryDirectory();

    // File file = new File(dir.path + "/" + fileName);
    List<PostModel> posts = <PostModel>[];
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'saved',
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];

    for (var item in wwwdata) {
      posts.add(PostModel.fromJson(item));
    }

    // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return posts;
    // try {} catch (e) {
    //   print('لا يوجد انترنت');
    // }
    // var jsonData = file.readAsStringSync();
    // var dataReed = jsonDecode(jsonData);
    // var datadecde = dataReed['data'];
    // for (var item in datadecde) {
    //   posts.add(PostModel.fromJson(item));
    // }

    // return posts;
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

