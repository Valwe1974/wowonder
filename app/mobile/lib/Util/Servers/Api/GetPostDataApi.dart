import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPostDataModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class GetPostDataApi {
  static Future<List<GetPostDataModel>> GetPostsData(String post_id) async {
    var url = Uri.parse(accounts[0]['onep'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetPostDataModel> posts = <GetPostDataModel>[];

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        'fetch': 'post_data',
        'post_id': post_id,
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['post_data'];
      print(wwwdata);

      posts.add(GetPostDataModel.fromJson(wwwdata));

      return posts;
    } catch (e) {
      print('لا يوجد انترنت');
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

