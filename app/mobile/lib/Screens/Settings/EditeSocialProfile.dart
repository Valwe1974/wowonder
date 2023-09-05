import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/EditeProfileScreen2.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class EditeSocialProfile extends StatefulWidget {
  const EditeSocialProfile({super.key});

  @override
  State<EditeSocialProfile> createState() => _EditeSocialProfileState();
}

class _EditeSocialProfileState extends State<EditeSocialProfile> {
  final getimydata = Get.find<GetMyUserDataCont>();
  TextEditingController facebook = TextEditingController();
  TextEditingController Twitter = TextEditingController();
  TextEditingController Vkontakte = TextEditingController();
  TextEditingController Linkedin = TextEditingController();
  TextEditingController Instagram = TextEditingController();
  TextEditingController YouTube = TextEditingController();

  ameen() {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        facebook.text = getimydata.data[i].facebook;
        Twitter.text = getimydata.data[i].twitter;
        Vkontakte.text = getimydata.data[i].vk;
        Linkedin.text = getimydata.data[i].linkedin;
        Instagram.text = getimydata.data[i].instgram;
        facebook.text = getimydata.data[i].facebook;
        YouTube.text = getimydata.data[i].youtube;
      });
  }

  @override
  void initState() {
    ameen();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        title: Text('Social Link'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (var i = 0; i < getimydata.data.length; i++)
                WidgetUpdateEditeProfile(
                  controller: facebook,
                  icon: Ionicons.logo_facebook,
                  name: 'Facebbok'.tr,
                ),
              for (var i = 0; i < getimydata.data.length; i++)
                WidgetUpdateEditeProfile(
                  controller: Twitter,
                  icon: Ionicons.logo_twitter,
                  name: 'Twitter'.tr,
                ),
              WidgetUpdateEditeProfile(
                controller: Vkontakte,
                icon: Ionicons.logo_vk,
                name: 'Vkontakte'.tr,
              ),
              WidgetUpdateEditeProfile(
                controller: Linkedin,
                icon: Ionicons.logo_linkedin,
                name: 'Linkedin'.tr,
              ),
              WidgetUpdateEditeProfile(
                controller: Instagram,
                icon: Ionicons.logo_instagram,
                name: 'Instagram'.tr,
              ),
              WidgetUpdateEditeProfile(
                controller: YouTube,
                icon: Ionicons.logo_youtube,
                name: 'YouTube'.tr,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorTheme,
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                      child: Text(
                        'Save'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TexteditingController {
  static textEditingController(s1s1s1) {
    s1s1s1 = TextEditingController();

    return s1s1s1;
  }
}
