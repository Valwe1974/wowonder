import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/MoviesModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiMovies {
  static Future<List<MoviesModel>> get() async {
    var url = Uri.parse(accounts[0]['getMov'] + await SharedP.Get('tok'));

    List<MoviesModel> groupData = <MoviesModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson[accounts[0]['getM']];

    for (var item in wwwdata) {
      groupData.add(MoviesModel.fromJson(item));
    }
    return groupData;
  }
}
