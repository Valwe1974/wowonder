import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

int cont = 0;

class ApiPosts {
  static Future<List<PostModel>> Getposts(
      String after_post_id, post_type) async {
    int vont = cont++;

    bool netWorkChek = await OfffLineNet();
    if (netWorkChek) {
      print('ajklsdsajaskld ${netWorkChek}');
    } else {}
    String fileName = "$vont+PostsCash.json";

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<PostModel> posts = <PostModel>[];
    File file = new File(dir.path + "/$vont" + fileName);
    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['ty']: 'get_news_feed',
        accounts[0]['aft']: after_post_id,
        'limit': Home_Post_Limit,

        if (post_type == 1) accounts[0]['pt']: 'text',
        if (post_type == 2) accounts[0]['pt']: 'photos',
        if (post_type == 3) accounts[0]['pt']: 'video',
        if (post_type == 4) accounts[0]['pt']: 'music',

        //  'post_type': 'video'
      });

      print('aksljdlasjdklasjdkl ${vont}');
      var resp = response.body;

      var datajson = jsonDecode(resp);
      if (datajson['errors'] != null) {
        if (datajson['errors']['error_text'] ==
            'Invalid or expired access_token') {
          Get.offAll(LoginScreen());
        }
      }

      var wwwdata = datajson['data'];

      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      for (var item in wwwdata) {
        posts.add(PostModel.fromJson(item));
      }
      return posts;
    } catch (eror) {
      print('No NetWork');
    }

    vont;
    var jsonData = file.readAsStringSync();
    var dataReed = jsonDecode(jsonData);
    var datadecde = dataReed['data'];
    for (var item in datadecde) {
      posts.add(PostModel.fromJson(item));
    }

    return posts;
  }
}
