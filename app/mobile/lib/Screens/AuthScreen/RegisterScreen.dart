import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/NameScreen.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiRegister.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

import '../../Images.dart';
import '../../Util/SocialLogin/AppleLogin.dart';
import '../../Util/SocialLogin/FaceBookLogin.dart';
import '../../Util/SocialLogin/GoogleLogin.dart';

class RegisteScreen extends StatefulWidget {
  const RegisteScreen({super.key});

  @override
  State<RegisteScreen> createState() => _RegisteScreenState();
}

final Uri _url = Uri.parse(accounts[0]['termsOfUse']);

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

final Uri _url2 = Uri.parse(accounts[0]['privacyPolicy']);

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw 'Could not launch $_url2';
  }
}

bool lod = false;
bool chekbox = false;

class _RegisteScreenState extends State<RegisteScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScaffoldWidget(
          AppBarTrueOrFalse: true,
          loding: lod,
          centerTitle: false,
          title: '',
          elevation: 0,
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: SvgPicture.asset(
                    SvgImages.register,
                    height: Get.height * 0.20,
                    width: Get.width * 0.30,
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                child: Text(
                  'JOIN THE TEAM'.tr,
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromARGB(116, 15, 45, 82)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                child: Text(
                  'Create Account'.tr,
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 15, 45, 82)),
                ),
              ),
              if (Social_Login_Page)
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
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
              if (Social_Login_Page)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                      child: Text(
                        'Or Create Using Email'.tr,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Color.fromARGB(116, 15, 45, 82)),
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
                            color: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        width: Get.width * 0.90,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextField(
                            controller: _username,
                            // autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'username'.tr,
                              border: InputBorder.none,
                              icon: Icon(Icons.account_circle),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        width: Get.width * 0.90,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextField(
                            controller: _email,
                            decoration: InputDecoration(
                                hintText: 'Email'.tr,
                                border: InputBorder.none,
                                icon: Icon(Icons.mail)),
                          ),
                        )),
                  ],
                ),
              ),
              // SizedBox(
              //   height: Get.height * 0.01,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        width: Get.width * 0.90,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    chekbox = !chekbox;
                  });
                },
                child: Container(
                  height: Get.height * 0.05,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: chekbox,
                        onChanged: (val) {
                          setState(() {
                            chekbox = val!;
                          });
                        },
                      ),
                      SizedBox(width: Get.width * 0.01),
                      Text(
                        'I agree to the'.tr,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      InkWell(
                        onTap: () {
                          _launchUrl();
                        },
                        child: Text(
                          'Terms of Service'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Get.isDarkMode
                                ? colorTextBoardingDark1
                                : colorTextBoardingLight1,
                          ),
                        ),
                      ),
                      Text(
                        ' and '.tr,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _launchUrl2();
                        },
                        child: Text(
                          'Privacy Policy'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Get.isDarkMode
                                ? colorTextBoardingDark1
                                : colorTextBoardingLight1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: InkWell(
                  onTap: _login,
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04, vertical: 20),
                        child: Text('Register'.tr,
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
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: Container(
                  width: Get.width * 0.90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                height: Get.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: InkWell(
                  onTap: () {
                    Get.offAll(LoginScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I have a account !'.tr,
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: Get.width * 0.01,
                        ),
                        Text(
                          'Login'.tr,
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
            ],
          )),
        ),
        // if (lod)
        //   Container(
        //       height: Get.height,
        //       width: Get.width,
        //       color: Color.fromARGB(42, 76, 76, 76),
        //       child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Future<void> _login() async {
    loding(true);

    var LoginVar = chekbox
        ? await ApiRegister.fetReg(
            _username.text, _email.text, _password.text, '', '')
        : '';

    if (chekbox) {
      if (LoginVar['api_status'] == 200) {
        if (LoginVar['membership']) {
          loding(false);
        } else {
          SharedP.Save('tok', LoginVar['access_token'].toString());
          SharedP.Save('user_id', LoginVar['user_id'].toString());
          loding(false);
          Get.offAll(NameScreen());
        }
        loding(false);
        Get.offAll(NameScreen());
      } else {
        Get.snackbar(
          'errors',
          LoginVar['errors']['error_text'],
        );
        loding(false);
      }
    } else {
      Get.snackbar('', 'You must first agree to the Terms of Use');

      loding(false);
    }
  }

  loding(lods) {
    setState(() {
      lod = lods;
    });
  }
}
