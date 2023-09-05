import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/TowFactorApi.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class OptScreen extends StatefulWidget {
  OptScreen({super.key, required this.use});
  final use;
  @override
  State<OptScreen> createState() => _OptScreenState();
}

class _OptScreenState extends State<OptScreen> {
  String? codeOtp;

  Timer? _timer;
  int _start = OTP_Resend_Timer;
  bool resendCode = false;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            resendCode = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      centerTitle: false,
      loding: false,
      elevation: 0,
      title: '',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            Image.asset(
              images.OTPVerfication,
            ),
            Text(
              'OTP Verification'.tr,
              style: SafeGoogleFont(Fonts.font3,
                  fontWeight: FontWeight.bold, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              width: Get.width * 0.60,
              child: Text(
                'Enter the verification code we just sent on your email address.'
                    .tr,
                style: SafeGoogleFont(Fonts.font3,
                    fontWeight: FontWeight.w600, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            Container(
              height: Get.height * 0.1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: OtpTextField(
                    fieldWidth: Get.width * 0.13,
                    borderWidth: 2,
                    borderRadius: BorderRadius.circular(20),
                    fillColor: ColorTheme,
                    numberOfFields: 6,
                    borderColor: ColorTheme,
                    cursorColor: ColorTheme,
                    focusedBorderColor: ColorTheme,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,

                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },

                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) async {
                      var ameen = await TwoFactorApi.foct(
                        verificationCode.toString(),
                        widget.use,
                      );

                      if (ameen['api_status'] == '400') {
                        Get.snackbar('errorr', ameen['errors']['error_text']);
                      }
                      if (ameen['api_status'] == 200) {
                        SharedP.Save('tok', ameen['access_token'].toString());
                        SharedP.Save('user_id', ameen['user_id'].toString());

                        Get.offAll(HomeNavBar());
                      }
                    }, // end onSubmit
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Resend code in'.tr), Text(_start.toString())],
              ),
            ),
            if (resendCode)
              InkWell(
                onTap: () {
                  setState(() {
                    _start = OTP_Resend_Timer;

                    resendCode = false;
                  });
                  startTimer();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text('Resend Code'.tr,
                          style: SafeGoogleFont(Fonts.font1,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )),
                  ),
                ),
              ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: ColorTheme,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text('Verify'.tr,
                        style: SafeGoogleFont(Fonts.font1,
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Didn\'t receive the code? Check your email spam.'.tr),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'Use another email address?'.tr,
                style: SafeGoogleFont(Fonts.font3, color: ColorTheme),
              ),
            )
          ],
        ),
      ),
    );
  }
}
