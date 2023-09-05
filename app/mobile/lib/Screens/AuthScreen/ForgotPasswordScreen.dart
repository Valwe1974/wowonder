import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiRestPass.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _email = TextEditingController();

  bool lod = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      elevation: 0,
      centerTitle: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    child: SvgPicture.asset(
                  SvgImages.forgot,
                  height: Get.height * 0.25,
                  width: Get.width * 0.25,
                )),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text('Forgot Password.'.tr,
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: Get.width * 0.60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                    'Enter your email account to reset your password.'.tr,
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.urbanist(fontSize: 20, color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
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
                              hintText: 'Enter your Email'.tr,
                              border: InputBorder.none,
                              icon: Icon(Icons.mail)),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  lod = true;
                });
                var ameen = await RestPassowrdApi.rest(_email.text);

                if (ameen['api_status'] == 200) {
                  Get.bottomSheet(
                    // Positioned(child: child),
                      Container(
                      height: Get.height * 0.4,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(images.restPasswordIm),
                          Text(
                            'Recovery password Successfully'.tr,
                            style: SafeGoogleFont(Fonts.font3,
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Please login again to get started.'.tr,
                            style: SafeGoogleFont(Fonts.font3,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05),
                            child: InkWell(
                              onTap: () {
                                Get.to(ForgotPasswordScreen());
                              },
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorTheme,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.04,
                                        vertical: 20),
                                    child: Text('Forgot Password'.tr,
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
                        ],
                      )));
                  setState(() {
                    lod = false;
                  });
                } else {
                  setState(() {
                    lod = false;
                  });

                  Get.snackbar('error', ameen['errors']['error_text']);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
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

              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              //   child: Container(
              //     height: Get.height * 0.07,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: ColorThme),
              //     child: Center(
              //       child: Text(
              //         'Continue'.tr,
              //         style: GoogleFonts.cairo(
              //             fontWeight: FontWeight.bold, color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: lod,
      title: '',
    );
  }
}
