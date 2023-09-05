import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiPostReaction {
  static Future postReaction(String post_id, String action, reactions) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['action'] + token);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'post_id': post_id,
      'action': action,
      'reaction': reactions,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    print(json);

    if (json['api_status'] == 200) {
      if (action == 'delete') Get.snackbar('Alatr', 'Post has been deleted');
      if (action == 'report') Get.snackbar('Alatr', json['action'].toString());
      if (action == 'save') Get.snackbar('Alatr', json['action'].toString());
      return resp;
    } else {
      return json;
    }
  }
}
