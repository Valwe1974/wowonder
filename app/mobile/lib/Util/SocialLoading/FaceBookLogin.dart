import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/NameScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSocialLogin.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class FaceBookLoginAuth extends StatefulWidget {
  const FaceBookLoginAuth({super.key});

  @override
  State<FaceBookLoginAuth> createState() => _FaceBookLoginAuthState();
}

class _FaceBookLoginAuthState extends State<FaceBookLoginAuth> {
  @override
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
      print(_accessToken);
    }
    setState(() {
      _accessToken = result.accessToken;
    });
    print(_accessToken != null);
    if (_accessToken!.token.isNotEmpty) {
      var tok =
          await ApiSocialLogin.lgin('facebook', _accessToken!.token.toString());
      print(tok.toString());
      if (tok['is_new']) {
        SharedP.Save('tok', tok['access_token'].toString());
        SharedP.Save('user_id', tok['user_id'].toString());
        Get.offAll(NameScreen());
        print('new');
      } else {
        SharedP.Save('tok', tok['access_token'].toString());
        SharedP.Save('user_id', tok['user_id'].toString());
        Get.offAll(HomeNavBar());
      }
    }
  }

  Future<void> ameenjawadhamed() async {
    final status = await OneSignal.shared.getDeviceState();
  }

  Widget build(BuildContext context) {
    ameenjawadhamed();
    print(_userData);
    return InkWell(
      onTap: _login,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(53, 0, 0, 0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.7),
          child: Container(
            height: Get.height * 0.07,
            width: Get.width * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.black : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/facebook.png',
                  height: 30,
                  width: 50,
                ),
                Text(
                  'Register Using Facebook'.tr,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
