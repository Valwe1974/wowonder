import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetColorPostModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetColorPost {
  static Future<List<GetColorPostModel>> color(String colorId) async {
    var url = Uri.parse(accounts[0]['set']);
    var dir = await getTemporaryDirectory();

    List<GetColorPostModel> posts = <GetColorPostModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['config']['post_colors'][colorId];
    print('aksjdklsajdklsajdklasjld  $wwwdata');

    posts.add(GetColorPostModel.fromJson(wwwdata));

    // print(wwwdata);
    return posts;
  }
}
