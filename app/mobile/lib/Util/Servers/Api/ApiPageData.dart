import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiPageData {
  static Future<List<GetPagesDataModel>> postsData(String pgid) async {
    var url = Uri.parse(accounts[0]['pgu'] + await SharedP.Get('tok'));

    List<GetPagesDataModel> posts = <GetPagesDataModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['pgid']: pgid
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson[accounts[0]['pgda']];

    posts.add(GetPagesDataModel.fromJson(wwwdata));

    return posts;
  }
}
