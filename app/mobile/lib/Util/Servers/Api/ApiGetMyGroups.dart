import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetGroupDataModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetMyGroups {
  static Future<List<GetGroupDataModel>> getgroups(
    String type,
  ) async {
    var url = Uri.parse(accounts[0]['getG'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetGroupDataModel> groupData = <GetGroupDataModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      if (type == 'my_groups') accounts[0]['ty']: 'my_groups',
      if (type == 'joined_groups') accounts[0]['ty']: 'joined_groups',
      if (type == 'joined_groups')
        accounts[0]['use']: await SharedP.Get(accounts[0]['use']),
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    for (var item in wwwdata) {
      groupData.add(GetGroupDataModel.fromJson(item));
    }
    return groupData;
  }
}

class Joined {
  static Future<List<GetGroupDataModel>> getgroups(String type, offset) async {
    var url = Uri.parse(accounts[0]['getG'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();
    var prefs = await SharedPreferences.getInstance();
    final String? myuserid = prefs.getString('user_id');
    List<GetGroupDataModel> groupData = <GetGroupDataModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'joined_groups',
      'user_id': myuserid.toString(),
      'limit': '10',
      'offset': offset,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    for (var item in wwwdata) {
      groupData.add(GetGroupDataModel.fromJson(item));
    }
    return groupData;
  }
}
