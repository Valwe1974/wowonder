import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class HidePostApi {
  static Future hidepost(
    String pos,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['hid'] + token);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['pos']: pos,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    print(json['api_status']);

    if (json['api_status'] == 200) {
      Get.snackbar('Alatr', 'Post has been hidden',
          icon: Icon(Icons.hide_image));

      return resp;
    } else {
      return json;
    }
  }
}
