import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetNameGroupsChatModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGroupsChatList {
  static Future<List<GetNameGroupsChatModel>> fetch() async {
    var url = Uri.parse(accounts[0]['GroCh'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetNameGroupsChatModel> stor = <GetNameGroupsChatModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: accounts[0]['lis'],
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson[accounts[0]['da']];
    for (var item in wwwdata) {
      stor.add(GetNameGroupsChatModel.fromJson(item));
    }

    return stor;
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

