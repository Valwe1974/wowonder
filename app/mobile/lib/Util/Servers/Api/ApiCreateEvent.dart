// ApiCreateEvent

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiCreateEvent {
  static Future send(
    String eveN,
    String eveL,
    String eveD,
    String event_start_date,
    String event_end_date,
    String event_start_time,
    String event_end_time,
    path,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['ceEve'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['eveN']: eveN,
      accounts[0]['eveL']: eveL,
      accounts[0]['eveD']: eveD,
      'event_start_date': event_start_date,
      'event_end_date': event_end_date,
      'event_start_time': event_start_time,
      'event_end_time': event_end_time,
    });
    if (path.toString().isNotEmpty)
      request.files.add(await http.MultipartFile.fromPath(
        accounts[0]['eveC'],
        path,
        contentType: new MediaType(accounts[0]['ims'], accounts[0]['pn']),
      ));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = await response.stream.bytesToString();
      var jsonData = jsonDecode(json);

      print(jsonData);
      return jsonData;
    } else {
      print(response.reasonPhrase);
    }
  }
}
