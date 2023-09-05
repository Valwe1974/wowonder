import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/SearchModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class SearchApi {
  static Future<List<SearchModel>> serch(
      String search_key, String limit, user) async {
    var url = Uri.parse(accounts[0]['se'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<SearchModel> posts = <SearchModel>[];

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['ses']: search_key,
        'limit': '20',
        accounts[0]['useof']: user,
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['users'];

      for (var item in wwwdata) {
        posts.add(SearchModel.fromJson(item));
      }
      // print(posts);
      return posts;
    } catch (e) {
      print('لا يوجد انترنت');
    }

    return posts;
  }
}

class SearchApiPage {
  static Future<List<SearchModel>> serch(
      String search_key, String limit, user) async {
    var url = Uri.parse(accounts[0]['se'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<SearchModel> posts = <SearchModel>[];

    try {
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        accounts[0]['ses']: search_key,
        'limit': '20',
        accounts[0]['useof']: user,
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['page'];

      for (var item in wwwdata) {
        posts.add(SearchModel.fromJson(item));
      }
      // print(posts);
      return posts;
    } catch (e) {
      print('لا يوجد انترنت');
    }

    return posts;
  }
}
