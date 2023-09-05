import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllReactionModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class GetAllReactionApi {
  static Future<List<GetAllReactionModel>> fetchReaction(
      String id, String reaction, String numpReaction, type) async {
    var url = Uri.parse(accounts[0]['getre'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetAllReactionModel> posts = <GetAllReactionModel>[];
    print(type);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      if (type == 'fetch_comments') 'type': 'post',
      if (type == 'fetch_comments_reply') 'type': 'comment',
      'id': id,
      'reaction': reaction,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'][numpReaction];

    for (var item in wwwdata) {
      posts.add(GetAllReactionModel.fromJson(item));
    }

    return posts;
  }
}
