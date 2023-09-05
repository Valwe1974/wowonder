import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiPostReactionComments {
  static Future postReaction(
    String type,
    String comment_id,
    reaction,
  ) async {
    print(comment_id);
    final prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    final String? token = prefs.getString('token');
    var url = Uri.parse(accounts[0]['comm'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'type': type,
      'comment_id': comment_id,
      'reaction': reaction,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    // print(json);
    print(json);

    if (json['api_status'] == 200) {
      if (type == 'delete') Get.snackbar('Alatr', 'Post has been deleted');
      if (type == 'report') Get.snackbar('Alatr', json['action'].toString());
      if (type == 'save') Get.snackbar('Alatr', json['action'].toString());
      return resp;
    } else {
      return json;
    }
  }
}
