import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class UpditeNotificationsApi {
  static Future updite(String e_not, String numpnot) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['usUp'] + await SharedP.Get('tok')));
    request.fields
        .addAll({accounts[0]['sm1']: accounts[0]['sm2'], e_not: numpnot});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }
}
