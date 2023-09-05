import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/SharePostApi.dart';

class SharePostMyTimelineScreen extends StatefulWidget {
  const SharePostMyTimelineScreen({
    super.key,
    required this.postid,
  });
  final String postid;
  @override
  State<SharePostMyTimelineScreen> createState() =>
      _SharePostMyTimelineScreenState();
}

class _SharePostMyTimelineScreenState extends State<SharePostMyTimelineScreen> {
  @override
  TextEditingController postsText = TextEditingController();
  String postPrivacu = '1';
  final getimydata = Get.put(GetMyUserDataCont());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
      ),
      body: Container(
        height: Get.height * 0.50,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < getimydata.data.length; i++)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(getimydata.data[i].avatar),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getimydata.data[i].name,
                          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(Pivacy());
                          },
                          child: Row(
                            children: [
                              if (postPrivacu == '1')
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/coin-svgrepo-com.svg',
                                      color:
                                          Get.isDarkMode ? Colors.white : null,
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                      'People I Follow'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              if (postPrivacu == '0')
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/global-search-svgrepo-com.svg',
                                      color:
                                          Get.isDarkMode ? Colors.white : null,
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                      'Everyone'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              if (postPrivacu == '2')
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/colorfilter-svgrepo-com.svg',
                                      color:
                                          Get.isDarkMode ? Colors.white : null,
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                      'People Follow Me'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              if (postPrivacu == '3')
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/profile-tick-svgrepo-com.svg',
                                      color:
                                          Get.isDarkMode ? Colors.white : null,
                                      height: 20,
                                      width: 20,
                                    ),
                                    Text(
                                      'Only me'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                height: Get.height * 0.20,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                      59,
                      158,
                      158,
                      158,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: postsText,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Write here...'),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      await SharePostApi.Shere('share_post_on_timeline',
                          widget.postid, postsText.text);
                      setState(() {
                        postsText.clear();
                      });
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorTheme,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Share on my profile'.tr,
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
                  postPrivacu = '3';

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
                  postPrivacu = '0';

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
                  postPrivacu = '1';

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
                  postPrivacu = '2';

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
