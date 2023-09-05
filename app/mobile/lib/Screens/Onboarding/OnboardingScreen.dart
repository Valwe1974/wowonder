import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/HomeLogin.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

import '../AuthScreen/RegisterScreen.dart';
import 'content_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currenIndex = 0;
  bool onLastPage = false;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                  currenIndex = index;
                });
              },
              children: [
                onPord1(
                  title1: 'onBoridngTitle1'.tr,
                  title2: 'onBoridngTitle2'.tr,
                  imagess: images.onBording1,
                ),
                onPord1(
                  title1: 'onBoridngTitle3'.tr,
                  title2: 'onBoridngTitle4'.tr,
                  imagess: images.omBording2,
                ),
                onPord1(
                  title1: 'onBoridngTitle5'.tr,
                  title2: 'onBoridngTitle6'.tr,
                  imagess: images.onbBording3,
                ),
              ]),
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.05,
                        vertical: Get.height * 0.02),
                    child: InkWell(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ColorTheme,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Get Started'.tr,
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  child: Padding(
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _nextPage() async {
    onLastPage
        ? Get.offAll(Social_Login_Page ? HomeLoginScreen() : RegisteScreen())
        : _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeInCirc);
  }

  Container buleddot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currenIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: currenIndex == index ? ColorTheme : Colors.grey),
    );
  }
}

class onPord1 extends StatelessWidget {
  onPord1({
    required this.title1,
    required this.title2,
    required this.imagess,
    super.key,
  });

  String title1;
  String title2;
  String imagess;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: Get.height * 0.45,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                color: Get.isDarkMode ? ColorsOnPordingDark : Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/ImageNew/pattern.png'))),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                      height: Get.height * 0.38,
                      width: Get.width,
                      child: Image.asset(
                        imagess,
                        fit: BoxFit.fitHeight,
                      )),
                ),
              ],
            )),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Text(
              title1,
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ColorTheme,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
          child: Text(
            title2,
            style: SafeGoogleFont('Fonts.font3',
                fontWeight: FontWeight.w700, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
