import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMesageModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class GetUserMessgesApi {
  static Future<List<GetAllMesageModel>> chat(String userid) async {
    var url = Uri.parse(accounts[0]['getallc'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetAllMesageModel> posts = <GetAllMesageModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'recipient_id': userid,
      'limit': '50'
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['messages'];

    for (var item in wwwdata) {
      posts.add(GetAllMesageModel.fromJson(item));
    }
    // print(wwwdata);
    return posts;
  }
}
