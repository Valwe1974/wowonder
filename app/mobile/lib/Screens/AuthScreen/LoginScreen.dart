import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/ForgotPasswordScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/OtpScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/RegisterScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/DarkMode/DarkModeWidget.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiLogin.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLogin/AppleLogin.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

import '../../Util/CustomSnackbar.dart';
import '../../Util/SocialLoading/AppleLogin.dart';
import '../../Util/SocialLoading/FaceBookLogin.dart';
import '../../Util/SocialLoading/GoogleLogin.dart';
import '../../Util/SocialLogin/FaceBookLogin.dart';
import '../../Util/SocialLogin/GoogleLogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool lod = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    OneSignalNotf();
    super.initState();
  }

  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      loding: lod,
      centerTitle: true,
      title: '',
      elevation: 0,
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          Center(
            child: Container(
                child: SvgPicture.asset(
              SvgImages.login,
              height: Get.height * 0.20,
              width: Get.width * 0.30,
            )),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
            child: Text(
              'WELCOME BACK'.tr,
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color.fromARGB(116, 15, 45, 82)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
            child: Text(
              'Account Log in'.tr,
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 15, 45, 82)),
            ),
          ),

          if (Social_Login_Page)
            Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (Login_With_Facebook) FaceBookLoginAuth2(),
                      if (Login_With_Google) SignInDemo2(),
                      if (Login_With_Apple) AppleLogin2(),
                      // if (Login_With_Facebook)
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          if (Social_Login_Page)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                  child: Text(
                    'Or Log In Using Email'.tr,
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Get.isDarkMode ? Colors.white : Color.fromARGB(116, 15, 45, 82)),
                  ),
                ),
              ],
            ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? ColorDarkTextBox :const Color.fromARGB(
                        255,
                        255,
                        255,
                        255,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: Get.width * 0.90,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: TextField(
                        controller: _email,
                        // autofocus: true,
                        decoration: InputDecoration(
                            hintText: 'Email ID / Mobile number'.tr,
                            border: InputBorder.none,
                            icon: Icon(Icons.mail)),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? ColorDarkTextBox :const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    width: Get.width * 0.90,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password'.tr,
                            border: InputBorder.none,
                            icon: Icon(Icons.password)),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              children: [
                InkWell(
                  onTap: _login,
                  child: Center(
                    child: Container(
                      width: Get.width * 0.65,
                      decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04, vertical: 20),
                        child: Text('Login'.tr,
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: Get.width * 0.02), // Add a gap between the children
                InkWell(
                  onTap: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: Center(
                    child: Container(
                      width: Get.width * 0.2,
                      decoration: BoxDecoration(
                        color: ColorThemeOpacity,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04, vertical: 22),
                        child: SvgPicture.asset(
                          SvgImages.forgotpass,
                          width: 26,
                          height: 26,
                          color: ColorTheme,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Center(
            child: Container(
              width: Get.width * 0.90,
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.40,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Center(child: Text('Or'.tr)),
                  Container(
                    width: Get.width * 0.40,
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: Get.height * 0.01,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     if (Login_With_Apple) AppleLogin2(),
          //     // if (Login_With_Facebook)
          //   ],
          // ),

          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: InkWell(
                onTap: () {
                  Get.offAll(RegisteScreen());
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?'.tr,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Text(
                        'Register'.tr,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.bold,
                            color: ColorTheme,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // InkWell(
          //   onTap: () {
          //      Get.offAll(RegisteScreen());
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('Don\'t have an account?'.tr),
          //       Text(
          //         'Register'.tr,
          //         style: GoogleFonts.cairo(
          //             fontWeight: FontWeight.bold, color: ColorThme),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }

  Future<void> _login() async {
    loding(true);

    var LoginVar = await LoginApi.fetLogin(_email.text, _password.text);

    if (LoginVar['api_status'] == 200) {
      if (LoginVar['membership']) {
        loding(false);
      } else {
        loding(false);
        if (LoginVar['message'] == 'Please enter your confirmation code') {
          Get.to(OptScreen(
            use: LoginVar['user_id'].toString(),
          ));
        } else {
          SharedP.Save('tok', LoginVar['access_token'].toString());
          SharedP.Save('user_id', LoginVar['user_id'].toString());

          Get.offAll(HomeNavBar());
        }
        // Get.offAll(HomeNavBar());
      }
    } else {
      Get.snackbar(
        'errors',
        LoginVar['errors']['error_text'],
      );
      loding(false);
    }
  }

  loding(lods) {
    setState(() {
      lod = lods;
    });
  }
}
