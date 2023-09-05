import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:wowondertimelineflutterapp/main.dart';
import 'package:path_provider/path_provider.dart';

class ApiSetGen {
  static Future color() async {
    String fileName = "SettingSite.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    var url = Uri.parse(accounts[0]['set']);

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
      });
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['config'];
      GetSetList.add(wwwdata);
      // print(wwwdata);
      return wwwdata;
    } catch (erorr) {
      var jsonData = file.readAsStringSync();
      var dataReed = jsonDecode(jsonData);
      var datadecde = dataReed['config'];
      GetSetList.add(datadecde);
      print(erorr);
    }
  }
}
