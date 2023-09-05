import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/OffersModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiOffers {
  static Future<List<OffersModel>> ofse() async {
    // ignore: unused_local_variable
    String fileName = "ApiOffers.json";

    var url = Uri.parse(accounts[0]['ofs'] + await SharedP.Get('tok'));
    // ignore: unused_local_variable
    var dir = await getTemporaryDirectory();

    List<OffersModel> posts = <OffersModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['gg'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson[accounts[0]['da']];
    print(datajson);

    for (var item in wwwdata) {
      posts.add(OffersModel.fromJson(item));
    }

    return posts;
  }
}
