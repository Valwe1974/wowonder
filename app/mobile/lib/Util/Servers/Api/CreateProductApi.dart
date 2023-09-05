import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class CreateProductApi {
  static Future create(
    String product_title,
    String product_category,
    String product_description,
    String product_price,
    String product_location,
    String product_sub_category,
    String fid_3,
    String product_type,
    pathpostPhotos,
    String product_utl,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['crPro'] + await SharedP.Get('tok')));

    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'product_title': product_title,
      'product_category': product_category,
      'product_description': product_description,
      'product_price': product_price,
      'product_location': product_location,
      'product_sub_category': product_sub_category,
      'fid_3': 'hello',
      if (product_utl.isEmpty) 'product_utl': '1',
      if (product_utl.isNotEmpty) 'product_utl': product_utl,
      if (product_type == 'New') 'product_type': '0',
      if (product_type == 'Used') 'product_type': '1',
    });

    if (pathpostPhotos.isNotEmpty)
      List.generate(pathpostPhotos.length, (index) async {
        request.files.add(await http.MultipartFile.fromPath(
            'images[]', pathpostPhotos[index].path));
      });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();

      var json = jsonDecode(resp);
      return json;
    } else {
      print(response.reasonPhrase);
      return json;
    }
  }
}
