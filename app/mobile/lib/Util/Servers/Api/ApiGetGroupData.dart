import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetGroupDataModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetGroupData {
  static Future<List<GetGroupDataModel>> getdata(String group_id) async {
    var url = Uri.parse(accounts[0]['getGo'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetGroupDataModel> groupData = <GetGroupDataModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'group_id': group_id,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['group_data'];

    groupData.add(GetGroupDataModel.fromJson(wwwdata));

    return groupData;
  }
}
