import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class MyPointsScreen extends StatefulWidget {
  const MyPointsScreen({super.key});

  @override
  State<MyPointsScreen> createState() => _MyPointsScreenState();
}

class _MyPointsScreenState extends State<MyPointsScreen> {
  @override
  void initState() {
    Get.put(GetMyUserDataCont());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? ColorDarkBackground
            : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('My Points'),
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        ),
        body: GetBuilder<GetMyUserDataCont>(
          init: GetMyUserDataCont(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 31,
                                backgroundColor: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                child: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundImage: CachedNetworkImageProvider(
                                      controller
                                          .data[controller.data.length - 1]
                                          .avatar),
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
                                    style: SafeGoogleFont(
                                      Fonts.font1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '@${controller.data[controller.data.length - 1].username}',
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    controller.data[controller.data.length - 1]
                                        .points,
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'My Points',
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    ),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MYPOINT(
                            title:
                                'Earn ${GetSetList[0]['comments_point']} points by commenting any post',
                          ),
                          _MYPOINT(
                            title:
                                'Earn ${GetSetList[0]['createpost_point']} points by commenting any post',
                          ),
                          _MYPOINT(
                            title:
                                'Earn ${GetSetList[0]['reaction_point']} points by commenting any post',
                          ),
                          _MYPOINT(
                            title:
                                'Earn ${GetSetList[0]['createblog_point']} points by commenting any post',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Center(
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400.withOpacity(0.5),
                              blurRadius: 1)
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Your earned points will automaticaly go to #Wallet',
                              style: SafeGoogleFont(Fonts.font1,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ));
          },
        ));
  }
}

class _MYPOINT extends StatelessWidget {
  const _MYPOINT({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(),
          SizedBox(
            width: Get.width * 0.01,
          ),
          Text(
            title,
            style: SafeGoogleFont(
              Fonts.font1,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
