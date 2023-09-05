import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class GetUserDataApi {
  static Future<List<GetUserDataModel>> getUserData(String user_id) async {
    String fileName = "myPostsCash2.json";

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    final String? myuserid = prefs.getString('user_id');

    var url = Uri.parse(accounts[0]['usd'] + token);
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    List<GetUserDataModel> posts = <GetUserDataModel>[];
    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['use']: user_id,
        accounts[0]['ft']: 'user_data,followers,following',
      });
      var resp = response.body;

      var datajson = jsonDecode(resp);
      var data = datajson['user_data'];
      if (datajson['api_status'] == 200) {
        posts.add(GetUserDataModel.fromJson(data));
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);

        return posts;
      } else {
        //print('لا يوجد بيانات ');
      }
    } catch (e) {}

    var jsonData = file.readAsStringSync();
    var dataReed = jsonDecode(jsonData);
    var datadecde = dataReed['user_data'];
    posts.add(GetUserDataModel.fromJson(datadecde));

    return posts;
  }
}

class GetUserDataUserName {
  static Future getUserData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');

    var url = Uri.parse(accounts[0]['geda'] + token);

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'username': username,
      accounts[0]['ft']: 'user_data'
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson['user_data'];
    return data;
  }
}

class GetUserData {
  static Future getUserData(String user_id) async {
    String fileName = "myPostsCash2.json";

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');

    var url = Uri.parse(accounts[0]['usd'] + token);

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['use']: user_id,
      accounts[0]['ft']: 'user_data',
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var data = datajson['user_data'];
    if (datajson['api_status'] == 200) {
      return data;
    }
  }
}
