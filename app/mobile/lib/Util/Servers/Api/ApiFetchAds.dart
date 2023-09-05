// ApiFetchAds
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/AdsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiFetchAds {
  static Future<List<AdsModel>> Fetch() async {
    var url = Uri.parse(accounts[0]['ads'] + await SharedP.Get('tok'));

    List<AdsModel> posts = <AdsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['fitad'],

      // 'limit':'100'
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson['data'];
    if (datajson['api_status'] == 200) {
      for (var item in data) {
        posts.add(AdsModel.fromJson(item));
      }

      return posts;
    }

    return posts;
  }
}
