import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/RegisterScreen.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLoading/AppleLogin.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLoading/FaceBookLogin.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLoading/GoogleLogin.dart';

import '../../Widget/ScaffoldWidget.dart';

class HomeLoginScreen extends StatefulWidget {
  const HomeLoginScreen({super.key});

  @override
  State<HomeLoginScreen> createState() => _HomeLoginScreenState();
}

bool lod = false;

class _HomeLoginScreenState extends State<HomeLoginScreen> {
  @override
  void initState() {
    OneSignalNotf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      loding: lod,
      centerTitle: true,
      title: '',
      elevation: 0,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Image.asset('assets/ImageNew/Onboarding 5 Light.png'),
              Text(
                'Register'.tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Center(
                child: Container(
                  width: Get.width * 0.70,
                  child: Text(
                    'Register to using your email or social accounts'.tr,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (Login_With_Google) SignInDemo(),
              if (Login_With_Google)
                SizedBox(
                  height: Get.height * 0.01,
                ),
              if (Login_With_Facebook) FaceBookLoginAuth(),
              SizedBox(
                height: Get.height * 0.01,
              ),
              if (Login_With_Apple) AppleLogin(),
              if (Login_With_Google)
                SizedBox(
                  height: Get.height * 0.01,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.black,
                    width: Get.width * 0.40,
                    height: 0.2,
                  ),
                  Text('Or'.tr),
                  Container(
                    color: Colors.black,
                    width: Get.width * 0.40,
                    height: 0.2,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Get.to(RegisteScreen());
                },
                child: Container(
                  width: Get.width * 0.90,
                  decoration: BoxDecoration(
                    color: ColorTheme,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Register Using Email'.tr,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Get.to(LoginScreen());
                },
                child: Container(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have Account?'.tr),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      Container(
                        child: Text(
                          'Login'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, color: ColorTheme),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
