import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpers/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GetUserMessageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetAllChatsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllChatsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/Widget/Unfous.dart';

class ChatsHomeScreen extends StatefulWidget {
  const ChatsHomeScreen({super.key});

  @override
  State<ChatsHomeScreen> createState() => _ChatsHomeScreenState();
}

class _ChatsHomeScreenState extends State<ChatsHomeScreen> {
  bool loding = true;
  bool nodata = false;
  List<GetAllChatsModel> data = [];
  void getalhat() async {
    await GetAllChatsApi.allChat('0').then((value) {
      setState(() {
        data = value.toList();
        loding = false;
        value.length > 0 ? '' : nodata = true;
      });
    });
  }

  void onLineUser() {
    ///online
    SocketNew.socket.on(
        'on_user_loggedin',
        (dataonLine) async => {
              getalhat(),
              print(dataonLine),
            });
  }

  Future<void> soketGetdattt() async {
    //جلب الماحدثه الجديده
    SocketNew.socket.on('private_message', (datasss) {
      getalhat();
      print('ameen');
    });
  }

  @override
  void initState() {
    getalhat();
    onLineUser();
    soketGetdattt();
    SocketNew.onncteSoket();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Unfous(
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
              title: Text(
                'Chats',
                style: SafeGoogleFont(
                  Fonts.font2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Get.isDarkMode ? NavBarColorDark : ColorTheme,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Positioned(
                  bottom: 1,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? centarColorDark : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.30,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? NavBarColorDark : ColorTheme,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(300))),
                  ),
                ),
                Positioned(
                  top: 1,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.17,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? NavBarColorDark : ColorTheme,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                // color: ColorThemeOpacity,
                                color: Get.isDarkMode
                                    ? Color.fromARGB(44, 210, 202, 202)
                                    : ColorThemeOpacity,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Container(
                                child: Row(children: [
                                  Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      width: Get.width * 0.77,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      )),
                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.016,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var i = 0; i < 0; i++)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 5),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80'),
                                      maxRadius: 27,
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.17,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.75,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? centarColorDark : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        )),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loding
                            ? LodingPostsWidget(
                                len: 5,
                              )
                            : nodata
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.1,
                                      ),
                                      NoChatScreen(
                                        startChat: true,
                                        textData: '',
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      for (var i = 0; i < data.length; i++)
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              data.replaceAt(
                                                  i,
                                                  GetAllChatsModel(
                                                      reaction:
                                                          data[i].reaction,
                                                      lastseen_status: data[i]
                                                          .lastseen_status,
                                                      count: data[i].count,
                                                      message_count: '0',
                                                      time_text:
                                                          data[i].time_text,
                                                      time: data[i].time,
                                                      text: data[i].text,
                                                      user_id: data[i].user_id,
                                                      username:
                                                          data[i].username,
                                                      name: data[i].name,
                                                      avatar: data[i].avatar));
                                            });
                                            Get.to(GetUserMessageScreen(
                                              avat: data[i].avatar,
                                              userid: data[i].user_id,
                                              username: data[i].username,
                                              name: data[i].name,
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color:
                                                  data[i].message_count != '0'
                                                      ? Color.fromARGB(
                                                          255, 205, 233, 206)
                                                      : null,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          CircleAvatar(
                                                            maxRadius: 30,
                                                            backgroundImage:
                                                                CachedNetworkImageProvider(
                                                                    data[i]
                                                                        .avatar),
                                                          ),
                                                          Positioned(
                                                            right: 0,
                                                            bottom: 0,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        1.0),
                                                                child:
                                                                    Container(
                                                                  height: 15,
                                                                  width: 15,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color:
                                                                          ColorTheme),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            Stringlength(
                                                                text: data[i]
                                                                    .name,
                                                                length: 20),
                                                            style: SafeGoogleFont(
                                                                Fonts.font3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.005,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              Stringlength(
                                                                text: data[i]
                                                                    .text,
                                                                length: 30,
                                                              ),
                                                              style: SafeGoogleFont(
                                                                  Fonts.font3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Text(data[i].time_text)
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                      ),
                    ),
                  ),
                ),

                //appar Search

                // Positioned(
                //   top: 1,
                //   child: Container(
                //     width: Get.width,
                //     height: Get.height * 0.30,
                //     decoration: BoxDecoration(color: Color(0xff1E3932)),
                //   ),
                // ),
              ],
            )));
  }
}
