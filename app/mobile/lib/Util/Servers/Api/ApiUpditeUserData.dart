import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class UpditeUserData {
  static bool ameen = false;
  static Future updite(
    String first_name,
    String last_name,
    String birthday,
    final avatar,
    filename,
    phone_number,
    gender,
    String country,
    final cover,
    filename2,
  ) async {
    ameen = true;
    Map<String, String> hide = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final status = await OneSignal.shared.getDeviceState();
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['usUp'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      if (first_name.isNotEmpty) 'first_name': first_name,
      if (last_name.isNotEmpty) 'last_name': last_name,
      if (birthday.isNotEmpty) 'birthday': birthday,
      if (phone_number.toString().isNotEmpty) 'phone_number': phone_number,
      if (gender == 'Female') 'gender': 'female',
      if (gender == 'Male') 'gender': 'male',
      if (country.isNotEmpty) 'country_id': country,
      if (GetPlatform.isAndroid)
        accounts[0]['andm']: status == null ? '' : status.userId.toString(),
      if (GetPlatform.isIOS)
        accounts[0]['iosm']: status == null ? '' : status.userId.toString(),
      if (GetPlatform.isAndroid)
        accounts[0]['adnn']: status == null ? '' : status.userId.toString(),
      if (GetPlatform.isIOS)
        accounts[0]['iosn']: status == null ? '' : status.userId.toString(),
    });
    if (avatar != null)
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        avatar,
        filename: filename,
        contentType: new MediaType('image', 'png'),
      ));
    if (cover != null)
      request.files.add(await http.MultipartFile.fromPath(
        'cover',
        cover,
        contentType: new MediaType('image', 'png'),
      ));
    // request.files.add(await http.MultipartFile.fromPath(
    //   'cover',
    //   cover,
    //   filename: filename2,
    //   contentType: new MediaType('image', 'png'),
    // ));
    print(country);
    request.headers.addAll(hide);

    print(filename);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }
}
