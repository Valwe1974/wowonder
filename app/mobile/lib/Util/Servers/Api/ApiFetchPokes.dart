// ApiFetcPokes
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PokesModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiFetcPokes {
  static Future<List<PokesModel>> GetBlock() async {
    var url = Uri.parse(accounts[0]['pok'] + await SharedP.Get('tok'));

    List<PokesModel> posts = <PokesModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['ft'],

      // 'limit':'100'
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson['data'];
    if (datajson['api_status'] == 200) {
      for (var item in data) {
        posts.add(PokesModel.fromJson(item));
      }

      return posts;
    }

    return posts;
  }
}

class ApiRemovePoke {
  static Future GetBlock(String ipok) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['pok'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'remove',
      'poke_id': ipok
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

class ApiSendPoke {
  static Future Send(String use) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['pok'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['cr'],
      accounts[0]['use']: use,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var ameen = await response.stream.bytesToString();
      var json = jsonDecode(ameen);
      print(json);
      return json;
    } else {
      // print(response.reasonPhrase);
    }
  }
}
