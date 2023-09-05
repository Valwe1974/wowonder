import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class PostActionsApi {
  static Future reaction(String pos, String act) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['action'] + token);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['pos']: pos,
      accounts[0]['act']: act,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    print(json);

    if (json['api_status'] == 200) {
      if (act == 'delete') Get.snackbar('Alert', 'Post has been deleted');
      if (act == 'report') Get.snackbar('Alert', json['action'].toString());
      if (act == 'save') Get.snackbar('Alert', json['action'].toString());
      if (act == 'disable_comments')
        Get.snackbar('Post', json['action'].toString());
      return resp;
    } else {
      return json;
    }
  }
}
