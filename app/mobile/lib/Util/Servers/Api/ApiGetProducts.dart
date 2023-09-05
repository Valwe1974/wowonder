import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetProductsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetProudcts {
  static Future<List<GetProudctsModel>> getprodict(offset, category_id) async {
    var url = Uri.parse(accounts[0]['getPro'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetProudctsModel> stor = <GetProudctsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['li']: '20',
      'offset': offset,
      accounts[0]['cat']: category_id,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['products'];
    for (var item in wwwdata) {
      stor.add(GetProudctsModel.fromJson(item));
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

