import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class CreatePostImageApi {
  static Future cratepost(
    pathimage,
    pathvideo,
    String text,
    filename,
    String postPrivacy,
    String poll1,
    String poll2,
    String poll3,
    String poll4,
    String poll5,
    String poll6,
    String poll7,
    String poll8,
    String feeling_type,
    pathpostPhotos,
    String group_id,
    String page_id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    Map<String, String> hide = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['newposts'] + token));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'postText': text,
      'postPrivacy': postPrivacy,
      if (poll1.isNotEmpty) 'answer[0]': poll1,
      if (poll2.isNotEmpty) 'answer[1]': poll2,
      if (poll3.isNotEmpty) 'answer[2]': poll3,
      if (poll4.isNotEmpty) 'answer[3]': poll4,
      if (poll5.isNotEmpty) 'answer[4]': poll5,
      if (poll6.isNotEmpty) 'answer[5]': poll6,
      if (poll7.isNotEmpty) 'answer[6]': poll7,
      if (poll8.isNotEmpty) 'answer[7]': poll8,
      if (feeling_type.isNotEmpty) 'feeling_type': 'feelings',
      if (feeling_type.isNotEmpty) 'feeling': feeling_type,
      if (group_id.isNotEmpty) 'group_id': group_id,
      if (page_id.isNotEmpty) 'page_id': page_id,
    });
    request.headers.addAll(hide);
    if (await pathimage == null) {
      print('pathimage');
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'postFile',
        pathimage,
      ));
    }
    if (await pathvideo == null) {
      null;
    } else {
      FFmpeg
          ? request.files.add(await http.MultipartFile.fromPath(
              'postVideo',
              pathvideo,
              filename: filename,
              contentType: new MediaType('video', 'mp4'),
            ))
          : request.files.add(await http.MultipartFile.fromPath(
              'postFile',
              pathvideo,
              filename: filename,
              contentType: new MediaType('video', 'mp4'),
            ));
    }

    if (pathpostPhotos.isNotEmpty)
      List.generate(pathpostPhotos.length, (index) async {
        request.files.add(await http.MultipartFile.fromPath(
            'postPhotos[]', pathpostPhotos[index].path));
      });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      Get.snackbar('title', response.reasonPhrase.toString());
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }
}
