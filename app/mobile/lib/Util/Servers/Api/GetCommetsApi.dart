import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CommentsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class GetCommentsApi {
  static Future<List<GetCommentsModel>> FetchComments(
    String post_id,
    String fetch_comments,
    String offset,
  ) async {
    var url = Uri.parse(accounts[0]['comm'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetCommentsModel> posts = <GetCommentsModel>[];

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        'type': fetch_comments,
        'limit': '5',
        if (fetch_comments == 'fetch_comments') 'post_id': post_id,
        if (fetch_comments == 'fetch_comments_reply') 'comment_id': post_id,
        'offset': offset,
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data'];

      for (var item in wwwdata) {
        posts.add(GetCommentsModel.fromJson(item));
      }

      return posts;
    } catch (e) {
      print('لا يوجد انترنت');
    }

    return posts;
  }
}

class GetReplayommentsApi {
  static Future<List<GetCommentsModel>> FetchComments(String comment_id) async {
    var url = Uri.parse(accounts[0]['comm'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetCommentsModel> posts = <GetCommentsModel>[];

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        'type': 'fetch_comments_reply',
        'comment_id': comment_id,
        'limit': '3',
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data'];

      for (var item in wwwdata) {
        posts.add(GetCommentsModel.fromJson(item));
      }

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

