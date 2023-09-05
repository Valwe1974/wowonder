import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetEventsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetEvents {
  static Future<List<GetEventsModel>> fetch() async {
    print('ameen');
    String fileName = "ApiGetEvents.json";

    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse(accounts[0]['getEve'] + await SharedP.Get('tok'));

    List<GetEventsModel> posts = <GetEventsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: accounts[0]['ev'],
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson[accounts[0]['ev']];
    if (datajson['api_status'] == 200) {
      for (var item in data) {
        posts.add(GetEventsModel.fromJson(item));
      }
      // print(datajson);

      return posts;
    } else {}

    return posts;
  }
}
