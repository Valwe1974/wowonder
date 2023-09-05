import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserStoriesModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetUserStories {
  static Future<List<GetUserStoriesModel>> getstor() async {
    var url =
        Uri.parse(accounts[0]['stories'].toString() + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetUserStoriesModel> stor = <GetUserStoriesModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['stories'];
    for (var item in wwwdata) {
      stor.add(GetUserStoriesModel.fromJson(item));
    }

    return stor;
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

