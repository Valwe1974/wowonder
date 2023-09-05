import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiPromoted {
  static Future<List<PostModel>> Getposts() async {
    var url = Uri.parse(accounts[0]['boost'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<PostModel> posts = <PostModel>[];
    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      if (datajson['errors'] != null) {
        if (datajson['errors']['error_text'] ==
            'Invalid or expired access_token') {
          Get.offAll(LoginScreen());
        }
      }

      var wwwdata = datajson['data'];

      posts.add(PostModel.fromJson(wwwdata));

      return posts;
    } catch (eror) {}

    return posts;
  }
}
