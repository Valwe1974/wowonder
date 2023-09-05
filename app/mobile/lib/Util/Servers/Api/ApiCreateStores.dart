import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiCreateStores {
  static Future send(
    String path,
    String fit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var request = http.MultipartRequest(
        'POST', Uri.parse('${accounts[0]['CreateStor']}$token'));
    request.fields.addAll(
        {accounts[0]['sm1']: accounts[0]['sm2'], accounts[0]['fit']: fit});
    request.files
        .add(await http.MultipartFile.fromPath(accounts[0]['fe'], path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
