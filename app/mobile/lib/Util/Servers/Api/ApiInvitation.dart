//
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/InvitationModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiInvitation {
  static Future<List<InvitationModel>> invite() async {
    var url = Uri.parse(accounts[0]['inv'] + await SharedP.Get('tok'));

    List<InvitationModel> stor = <InvitationModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['gg'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);

    stor.add(InvitationModel.fromJson(datajson));

    return stor;
  }
}

class ApiInvitationCreate {
  static Future<List<dynamic>> invite() async {
    var url = Uri.parse(accounts[0]['inv'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['cr'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);

    return datajson;
  }
}
