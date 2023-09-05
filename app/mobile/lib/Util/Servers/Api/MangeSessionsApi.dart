// /api/sessions?access_token=
// MangeSessionsApi

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/MangeSessionsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class MangeSessionsApi {
  static Future<List<MangeSessionsModel>> getsessio() async {
    var url = Uri.parse(accounts[0]['sess'] + await SharedP.Get('tok'));

    List<MangeSessionsModel> session = <MangeSessionsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': 'get',
      'limit': '50'
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    for (var item in wwwdata) {
      session.add(MangeSessionsModel.fromJson(item));
    }

    return session;
  }
}

class DeleteSessionsApi {
  static Future delete(String id) async {
    var url = Uri.parse(accounts[0]['sess'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': 'delete',
      'id': id
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];

    return datajson;
  }
}
