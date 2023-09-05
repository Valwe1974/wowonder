import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class MyAffiliatesScreen extends StatefulWidget {
  const MyAffiliatesScreen({super.key});

  @override
  State<MyAffiliatesScreen> createState() => _MyAffiliatesScreenState();
}

class _MyAffiliatesScreenState extends State<MyAffiliatesScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(GetMyUserDataCont());
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? ColorDarkBackground
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('My Affiliates'),
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        body: GetBuilder<GetMyUserDataCont>(
          init: GetMyUserDataCont(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 31,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                  controller
                                      .data[controller.data.length - 1].avatar),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .data[controller.data.length - 1].name,
                                style: SafeGoogleFont(Fonts.font1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Text(
                                '@${controller.data[controller.data.length - 1].username}',
                                style: SafeGoogleFont(Fonts.font1,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Earn up to \$${GetSetList[0]['amount_ref']} for each user your refer to us !',
                      style: SafeGoogleFont(Fonts.font1,
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
                    ),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your affiliate link is',
                            style: SafeGoogleFont(Fonts.font1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? ColorDarkTextBox
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '${controller.web}/register?ref=${controller.data[controller.data.length - 1].username}'),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/ImageNew/Banner-visual-digital-selling-program-2-e1639728297181.png',
                                width: Get.width * 0.30,
                                height: Get.height * 0.20,
                              ),
                              InkWell(
                                onTap: () async {
                                  final result = await Share.shareWithResult(
                                      'Let\'s meet on $nameApp ${controller.web}/register?ref=${controller.data[controller.data.length - 1].username}');

                                  if (result.status ==
                                      ShareResultStatus.success) {
                                    print('Thank you for sharing my website!');
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? ColorDarkBackground
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 15),
                                    child: Text(
                                      'Share Link',
                                      style: SafeGoogleFont(Fonts.font1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
          },
        ));
  }
}
