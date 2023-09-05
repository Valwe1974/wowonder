import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiUpdateUserData {
  static Future UpdateUserData(
    String phone_number,
    String last_name,
    String first_name,
    String website,
    String working,
    String school,
    String about,
    String username,
    String email,
    String Gender,
    String birthday,
    String current_password,
    String new_password,
    String countryNup,
    String working_link,
    String address,
  ) async {
    var url = Uri.parse(accounts[0]['usUp'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      if (phone_number.isNotEmpty) 'phone_number': phone_number,
      if (last_name.isNotEmpty) 'last_name': last_name,
      if (first_name.isNotEmpty) 'first_name': first_name,
      if (website.isNotEmpty) 'website': website,
      if (working.isNotEmpty) 'working': working,
      if (school.isNotEmpty) 'school': school,
      if (about.isNotEmpty) 'about': about,
      if (username.isNotEmpty) 'username': username,
      if (email.isNotEmpty) 'email': email,
      if (Gender == 'Female') 'gender': 'female',
      if (Gender == 'Male') 'gender': 'male',
      if (birthday.isNotEmpty) 'birthday': birthday,
      if (current_password.isNotEmpty) 'current_password': current_password,
      if (new_password.isNotEmpty) 'new_password': new_password,
      if (countryNup.isNotEmpty) 'country_id': countryNup,
      if (working_link.isNotEmpty) 'working_link': working_link,
      if (address.isNotEmpty) 'address': address,
    });

    var resp = response.body;

    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      print(json);
      return json;
    } else {
      return json;
    }
  }
}
