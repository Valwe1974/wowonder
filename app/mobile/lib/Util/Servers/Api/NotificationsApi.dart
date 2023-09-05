import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FriendRequstsModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/NotificationsModels.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class NotificationsApi {
  static Future<List<NotificationsModels>> Notifications() async {
    String fileName = "notificationsUrl.json";

    var url = Uri.parse(accounts[0]['notfi'] + await SharedP.Get('tok'));
    // var dir = await getTemporaryDirectory();

    // File file = new File(dir.path + "/" + fileName);
    List<NotificationsModels> posts = <NotificationsModels>[];
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: 'notifications'
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['notifications'];

    for (var item in wwwdata) {
      posts.add(NotificationsModels.fromJson(item));
    }
    // print(wwwdata);

    // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return posts;
    // try {} catch (e) {
    //   print('لا يوجد انترنت');
    // }
    // var jsonData = file.readAsStringSync();
    // var dataReed = jsonDecode(jsonData);
    // var datadecde = dataReed['data'];
    // for (var item in datadecde) {
    //   posts.add(PostModel.fromJson(item));
    // }

    // return posts;
  }
}

class Newnotifications_count {
  static Future Notifications() async {
    String fileName = "notificationsUrl.json";

    var url = Uri.parse(accounts[0]['notfi'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'fetch': 'notifications'
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['new_notifications_count'];

    // print(wwwdata);

    // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return wwwdata;
    // try {} catch (e) {
    //   print('لا يوجد انترنت');
    // }
    // var jsonData = file.readAsStringSync();
    // var dataReed = jsonDecode(jsonData);
    // var datadecde = dataReed['data'];
    // for (var item in datadecde) {
    //   posts.add(PostModel.fromJson(item));
    // }

    // return posts;
  }
}

class Count_new_messagesApi {
  static Future Notifications() async {
    String fileName = "notificationsUrl.json";

    var url = Uri.parse(accounts[0]['notfi'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: accounts[0]['conms'],
    });
    var resp = response.body;
    print(resp);
    var datajson = jsonDecode(resp);
    var wwwdata = datajson['count_new_messages'];

    // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return wwwdata;
    // try {} catch (e) {
    //   print('لا يوجد انترنت');
    // }
    // var jsonData = file.readAsStringSync();
    // var dataReed = jsonDecode(jsonData);
    // var datadecde = dataReed['data'];
    // for (var item in datadecde) {
    //   posts.add(PostModel.fromJson(item));
    // }

    // return posts;
  }
}

class FriendrequestsCount {
  static Future Notifications() async {
    var url = Uri.parse(accounts[0]['notfi'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: accounts[0]['frreq'],
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['new_friend_requests_count'];

    // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return wwwdata;
    // try {} catch (e) {
    //   print('لا يوجد انترنت');
    // }
    // var jsonData = file.readAsStringSync();
    // var dataReed = jsonDecode(jsonData);
    // var datadecde = dataReed['data'];
    // for (var item in datadecde) {
    //   posts.add(PostModel.fromJson(item));
    // }

    // return posts;
  }
}

class GetRequstFrind {
  static Future<List<FriendRequstsModel>> Notifications() async {
    String fileName = "notificationsUrl.json";

    var url = Uri.parse(accounts[0]['notfi'] + await SharedP.Get('tok'));
    // var dir = await getTemporaryDirectory();

    // File file = new File(dir.path + "/" + fileName);
    List<FriendRequstsModel> posts = <FriendRequstsModel>[];
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: accounts[0]['getfri'],
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['friend_requests'];

    for (var item in wwwdata) {
      posts.add(FriendRequstsModel.fromJson(item));
    }
    // print(wwwdata);

    // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    return posts;
    // try {} catch (e) {
    //   print('لا يوجد انترنت');
    // }
    // var jsonData = file.readAsStringSync();
    // var dataReed = jsonDecode(jsonData);
    // var datadecde = dataReed['data'];
    // for (var item in datadecde) {
    //   posts.add(PostModel.fromJson(item));
    // }

    // return posts;
  }
}
