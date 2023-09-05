import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Language/SettingsLang.dart';
import 'package:wowondertimelineflutterapp/Screens/Onboarding/OnboardingScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key, required this.lang});
  final bool lang;

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final controller = Get.find<SettingController>();
    return GetBuilder<SettingController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          actions: [
            if (widget.lang)
              InkWell(
                onTap: () {
                  Get.offAll(OnboardingScreen());
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 5),
                      width: Get.width * 0.20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          'Next'.tr,
                          style: SafeGoogleFont(Fonts.font2,
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ],
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          title: Row(children: [
            SvgPicture.asset(SvgImages.Language,color:Get.isDarkMode ? Colors.white : Colors.black,),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text('Languages'.tr,
                style: SafeGoogleFont(Fonts.font3,
                    fontWeight: FontWeight.bold,color:Get.isDarkMode ? Colors.white : Colors.black, ))
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _Lang(
                langname: arabic,
                controller: controller,
                langkey: ara,
              ),
              _Lang(
                langname: bengali,
                controller: controller,
                langkey: ben,
              ),
              _Lang(
                langname: chinese,
                controller: controller,
                langkey: zho,
              ),
              _Lang(
                langname: croatian,
                controller: controller,
                langkey: hrv,
              ),
              _Lang(
                langname: danish,
                controller: controller,
                langkey: dan,
              ),
              _Lang(
                langname: dutch,
                langkey: nld,
                controller: controller,
              ),
              _Lang(
                langname: english,
                langkey: eng,
                controller: controller,
              ),
              _Lang(
                langname: filipino,
                langkey: fil,
                controller: controller,
              ),
              _Lang(
                langname: french,
                langkey: fra,
                controller: controller,
              ),
              _Lang(
                langname: german,
                langkey: deu,
                controller: controller,
              ),
              _Lang(
                langname: hindi,
                langkey: hin,
                controller: controller,
              ),
              _Lang(
                langname: indonesian,
                langkey: ind,
                controller: controller,
              ),
              _Lang(
                langname: italian,
                langkey: ita,
                controller: controller,
              ),
              _Lang(
                langname: korean,
                langkey: kor,
                controller: controller,
              ),
              _Lang(
                langname: persian,
                langkey: per,
                controller: controller,
              ),
              _Lang(
                langname: portuguese,
                langkey: por,
                controller: controller,
              ),
              _Lang(
                langname: russian,
                langkey: rus,
                controller: controller,
              ),
              _Lang(
                langname: spanish,
                langkey: spa,
                controller: controller,
              ),
              _Lang(
                langname: turkish,
                langkey: tur,
                controller: controller,
              ),
              _Lang(
                langname: urdu,
                langkey: urd,
                controller: controller,
              ),
              _Lang(
                langname: vietnamese,
                langkey: vie,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Lang extends StatelessWidget {
  const _Lang({
    super.key,
    required this.controller,
    required this.langkey,
    required this.langname,
  });
  final String langkey;
  final String langname;

  final SettingController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.changeLanguage(langkey);
        Get.updateLocale(Locale(langkey));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20,
              ),
            color: Get.isDarkMode ? ColorDarkComponents : ColorTheme,),
          height: Get.height * 0.20,
          width: Get.width * 0.40,
          child: Center(
            child: langWidget(
              langname: langname,
              controller: controller,
              langkey: langkey,
            ),
          ),
        ),
      ),
    );
  }
}

class langWidget extends StatelessWidget {
  const langWidget({
    super.key,
    required this.controller,
    required this.langkey,
    required this.langname,
  });

  final SettingController controller;
  final langkey;
  final String langname;

  @override
  Widget build(BuildContext context) {
    return Text(
      langname,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 13,
      ),
    );
  }
}
