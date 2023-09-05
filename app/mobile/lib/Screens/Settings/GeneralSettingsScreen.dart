import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/AboutScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/BlockedUserScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/DeleteAccontScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/EditeProfileScreen2.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/EditeSocialProfile.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/ManageSessionsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/MyAccountSetScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/PasswordScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/VerificationScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

// ignore: must_be_immutable
class GeneralSettingsScreen extends StatelessWidget {
  GeneralSettingsScreen({required this.firstname, super.key});

  final firstname;
  final getimydata = Get.find<GetMyUserDataCont>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        centerTitle: true,
        title: Text('General Settings'.tr),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'General'.tr,
                  style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorTheme),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(EditeProfileScreen2(firstname: firstname));
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.person,
                          name: 'Edit Profile'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: (() {
                          Get.to(EditeSocialProfile());
                        }),
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'Social Link'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: (() {
                          Get.to(AboutScreen());
                        }),
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'About'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(MyAccountSetScreen());
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'My account'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(BlockedUserScreen());
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'Blocked Users'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(VerificationScreen());
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'Verification'.tr,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Securty'.tr,
                  style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorTheme),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(PasswordScreen());
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'Password'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      WidgetGenralSerringsAll(
                        icon: Icons.wallet,
                        name: 'Tow-facto authentication'.tr,
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(ManageSessionsScreen());
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'Manage Sessions'.tr,
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: Get.width * 0.11, top: 5,bottom: 5),
                        color: Colors.grey.withOpacity(0.3),
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(DeleteAccontScreen());
                        },
                        child: WidgetGenralSerringsAll(
                          icon: Icons.wallet,
                          name: 'Delete Account'.tr,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class WidgetGenralSerringsAll extends StatelessWidget {
  WidgetGenralSerringsAll({
    required this.name,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final icon;
  String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Color(0xffD6DAE5),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(3.0),
                  //     child: Icon(
                  //       icon,
                  //       size: 17,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios_outlined,size: 15,)
            ],
          ),
        ],
      ),
    );
  }
}
