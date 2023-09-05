// /api/get_group_members?access_token=

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetMembersGroupModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetGroupMemburs {
  static Future<List<GetMembersGroupModel>> getdata(
      String gor, String member_id) async {
    var url = Uri.parse(accounts[0]['getGoM'] + await SharedP.Get('tok'));

    List<GetMembersGroupModel> groupData = <GetMembersGroupModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['gor']: gor,
      accounts[0]['li']: '10',
      accounts[0]['off']: member_id,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['users'];

    for (var item in wwwdata) {
      groupData.add(GetMembersGroupModel.fromJson(item));
    }
    return groupData;
  }
}
