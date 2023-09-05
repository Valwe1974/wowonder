import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wowondertimelineflutterapp/String.dart';

class SignInDemo extends StatefulWidget {
  const SignInDemo({super.key});

  @override
  State<SignInDemo> createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  _signinWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn(
      clientId:
          '954615029850-9r90773end5gfv80pucdpt73a12a745a.apps.googleusercontent.com',
      serverClientId: 'AIzaSyBM_zANE0cqBcOynb2GPdQsWbU86N9YpXE',
      forceCodeForRefreshToken: true,
    ).signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    print('ameenjawadhamed1 ${gAuth.idToken}');
    Login_With_Google;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _signinWithGoogle,
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
                  'assets/images/google.png',
                  height: 30,
                  width: 50,
                ),
                SizedBox(
                  width: Get.width * 0.018,
                ),
                Text(
                  'Register Using Google'.tr,
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
