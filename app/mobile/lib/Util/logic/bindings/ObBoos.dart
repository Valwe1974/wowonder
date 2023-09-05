import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class ObBoos extends StatefulWidget {
   ObBoos({super.key});

  @override
  State<ObBoos> createState() => _ObBoosState();
}

class _ObBoosState extends State<ObBoos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                '😇 Oups!',
                style: SafeGoogleFont(Fonts.font1,
                    color: Color(0xffDC395F),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Image.network(
                'https://api.ameenhost.com/what-is-DNC-1024x536.png.webp',
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                textAlign: TextAlign.center,
                'Sorry, you do not have a license',
                style: SafeGoogleFont(Fonts.font1,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                textAlign: TextAlign.center,
                'You do not have a license to run this application, please check with the company 🙂🙂',
                style: SafeGoogleFont(Fonts.font2,
                    color: const Color.fromARGB(255, 52, 52, 52),
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              SizedBox(
                height: Get.height * 0.20,
              ),
              InkWell(
                onTap: () {
                  UrlGo('https://fluttercrafters.com');
                },
                child: Container(
                  width: Get.width * 0.80,
                  height: Get.height * 0.05,
                  color: Color(0xffDC395F),
                  child: Center(
                      child: Text(
                    'call us 🙂',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
