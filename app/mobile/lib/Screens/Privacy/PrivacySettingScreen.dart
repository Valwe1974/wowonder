import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

final getimydata = Get.put(GetMyUserDataCont());

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: '',
      centerTitle: false,
      elevation: 0,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var i = 0; i < getimydata.data.length; i++)
              Container(
                decoration: BoxDecoration(
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(getimydata.data[i].avatar),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: ColorTheme,
                              child: Icon(
                                Icons.privacy_tip,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width * 0.60,
                            child: Text(
                              getimydata.data[i].name,
                              maxLines: 1,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            'Privacy Setting'.tr,
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            Container(
              height: Get.height * 0.70,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    for (var i = 0; i < getimydata.data.length; i++)
                      PrivasySetting(
                        text: 'Who can follow me ?'.tr,
                        postPrivacu: getimydata.data[i].follow_privacy,
                      ),
                    Divider(),
                    for (var i = 0; i < getimydata.data.length; i++)
                      PrivasySetting(
                        text: 'Who can message me ?'.tr,
                        postPrivacu: getimydata.data[i].message_privacy,
                      ),
                    Divider(),
                    PrivasySetting(
                      text: 'Who can see my friends?'.tr,
                      postPrivacu: '0',
                    ),
                    Divider(),
                    PrivasySetting(
                      text: 'Who can post on my timeline ?',
                      postPrivacu: '0',
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      title: '',
                      text: 'Confirm request when someone follows you ?'.tr,
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      text:
                          'Send users a notification when i visit their profile?'
                              .tr
                              .tr,
                      title:
                          'if you don\'t share your visit event , you won\'t be able to see other people visiting your profile.'
                              .tr
                              .tr,
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      text: 'Show my last seen ?'.tr,
                      title:
                          'if you don\'t share your last seen , you won\'t be able to see other people last seen.'
                              .tr,
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      text: 'Show my activities ?'.tr,
                      title: '',
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      text: 'Status'.tr,
                      title: '',
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      text: 'Share my location with public?'.tr,
                      title: '',
                    ),
                    Divider(),
                    YesOrNoWidget(
                      yesOrNo: 'Yes',
                      text:
                          'Allow search engines to index my profile and posts?'
                              .tr,
                      title: '',
                    ),
                    Divider(),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: Get.width,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Save'.tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}

class YesOrNoWidget extends StatefulWidget {
  YesOrNoWidget({
    required this.yesOrNo,
    required this.title,
    required this.text,
    super.key,
  });

  String text;
  String title;
  String yesOrNo;

  @override
  State<YesOrNoWidget> createState() => _YesOrNoWidgetState();
}

class _YesOrNoWidgetState extends State<YesOrNoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.70,
              child: Text(
                widget.text,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
            if (widget.title.isNotEmpty)
              Container(
                width: Get.width * 0.70,
                child: Text(
                  widget.title,
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 13),
                ),
              ),
          ],
        ),
        InkWell(
          onTap: () {
            QuickAlert.show(
              onConfirmBtnTap: () async {
                setState(() {
                  widget.yesOrNo = 'Yes';
                });
                Get.back();
              },
              onCancelBtnTap: () async {
                setState(() {
                  widget.yesOrNo = 'No';
                });
                Get.back();
              },
              context: context,
              type: QuickAlertType.confirm,
              animType: QuickAlertAnimType.slideInRight,
              confirmBtnText: 'Yes'.tr,
              cancelBtnText: 'No'.tr,
              title: '',
              confirmBtnColor: Colors.red,
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: [
                  Text(
                    widget.yesOrNo,
                    style: GoogleFonts.cairo(fontWeight: FontWeight.w700),
                  ),
                  Icon(Icons.expand_more_outlined)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class PrivasySetting extends StatefulWidget {
  PrivasySetting({required this.postPrivacu, required this.text, super.key});

  String text;
  String postPrivacu;

  @override
  State<PrivasySetting> createState() => _PrivasySettingState();
}

class _PrivasySettingState extends State<PrivasySetting> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            Get.bottomSheet(Pivacy());
          },
          child: Row(
            children: [
              if (widget.postPrivacu == '1')
                Container(
                  width: Get.width * 0.25,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Color.fromARGB(44, 210, 202, 202)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgImages.PeopleIFollow,
                        color: Get.isDarkMode
                            ? Color.fromARGB(44, 210, 202, 202)
                            : Colors.white,
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'People I Follow'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Icon(Icons.expand_more_outlined)
                    ],
                  ),
                ),
              if (widget.postPrivacu == '0')
                Container(
                  width: Get.width * 0.28,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/global-search-svgrepo-com.svg',
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Everyone'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.expand_more_outlined),
                    ],
                  ),
                ),
              if (widget.postPrivacu == '2')
                Card(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/colorfilter-svgrepo-com.svg',
                        color: Get.isDarkMode ? Colors.white : null,
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'People Follow Me'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Icon(Icons.expand_more_outlined)
                    ],
                  ),
                ),
              if (widget.postPrivacu == '3')
                Card(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/profile-tick-svgrepo-com.svg',
                        color: Get.isDarkMode ? Colors.white : null,
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        'Only me'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Icon(Icons.expand_more_outlined)
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Pivacy() {
    return Container(
      width: Get.width,
      height: Get.height * 0.45,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.04),
            InkWell(
              onTap: () {
                setState(() {
                  widget.postPrivacu = '3';

                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/profile-tick-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Only me'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Only show this post to me.'.tr,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  widget.postPrivacu = '0';

                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/global-search-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Everyone'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Show this post to everyone.'.tr,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  widget.postPrivacu = '1';

                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/coin-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'People I Follow'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: Get.width * 0.70,
                        child: Text(
                          'Only show this post to people I follow.'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  widget.postPrivacu = '2';

                  Get.back();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/colorfilter-svgrepo-com.svg',
                    color: Get.isDarkMode ? Colors.white : null,
                    height: 35,
                    width: 35,
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'People Follow Me'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: Get.width * 0.70,
                        child: Text(
                          'Only show this post to people who follow me.'.tr,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
      ),
    );
  }
}
