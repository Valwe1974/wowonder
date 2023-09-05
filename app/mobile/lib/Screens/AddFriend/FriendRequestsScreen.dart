import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFrindRequestAccpt.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/NotificationsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FriendRequstsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

import '../../Images.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({super.key});

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  bool nodata = false;
  bool lod = false;
  List<FriendRequstsModel> data = [];
  GetlFrind() {
    setState(() {
      lod = true;
    });
    GetRequstFrind.Notifications().then((value) {
      setState(() {
        data = value.toList();
        lod = false;
        value.length > 0 ? '' : nodata = true;
      });
    });
  }

  @override
  void initState() {
    GetlFrind();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,

        title: Row(children: [
          SvgPicture.asset(
            SvgImages.users,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            // color: Color.fromARGB(255, 255, 255, 255),
            width: 20,
            height: 20,
          ),
          SizedBox(width: Get.width * 0.02,),
          Text('Friend Requests'.tr,
              style: SafeGoogleFont(Fonts.font3,
                  fontWeight: FontWeight.bold,

                  color: Get.isDarkMode ? Colors.white : Colors.black))
        ]),
      ),
      body: lod
          ? Center(
              child: CircularProgressIndicator(),
            )
          : nodata
              ? Center(
                  child: NoChatScreen(
                    startChat: false,
                    textData: 'There are no friend requests yet '.tr,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < data.length; i++)
                              Card(
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                maxRadius: 30,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        data[i].avatar),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Text(
                                                data[i].name,
                                                style: SafeGoogleFont(
                                                    Fonts.font2,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await ApiFrindRequestAccpt
                                                      .cratepost('decline',
                                                          data[i].user_id);
                                                  setState(() {
                                                    data.removeAt(i);
                                                    data.length > 0
                                                        ? ''
                                                        : nodata = true;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 69, 10, 6)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Reject'.tr,
                                                      style: SafeGoogleFont(
                                                          Fonts.font3,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  var decline =
                                                      await ApiFrindRequestAccpt
                                                          .cratepost('accept',
                                                              data[i].user_id);
                                                  setState(() {
                                                    data.removeAt(i);
                                                    data.length > 0
                                                        ? ''
                                                        : nodata = true;
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: ColorTheme),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Accept'.tr,
                                                      style: SafeGoogleFont(
                                                          Fonts.font3,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
