import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetMyPage {
  static Future<List<GetPagesDataModel>> mypage() async {
    var url = Uri.parse(accounts[0]['pagm'] + await SharedP.Get('tok'));

    List<GetPagesDataModel> posts = <GetPagesDataModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'my_pages',
      'offset': '',
      'limit': '20'
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    for (var item in wwwdata) {
      posts.add(GetPagesDataModel.fromJson(item));
    }
    // posts.add();

    return posts;
  }
}

class ApiGetAllMyPage {
  static Future<List<GetPagesDataModel>> mypage(String offset) async {
    var url = Uri.parse(accounts[0]['pagm'] + await SharedP.Get('tok'));

    List<GetPagesDataModel> posts = <GetPagesDataModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: 'liked_pages',
      'offset': offset,
      'limit': '20',
      'user_id': await SharedP.Get('user_id'),
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    print(datajson);
    for (var item in wwwdata) {
      posts.add(GetPagesDataModel.fromJson(item));
    }

    // posts.add();

    return posts;
  }
}
