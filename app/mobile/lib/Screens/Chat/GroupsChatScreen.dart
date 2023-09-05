import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GetUserMessageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/Groups/ChatGroupsScreenAll.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGroupChatCreate.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGroupsChatList.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/FriendsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetAllChatsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllChatsModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetNameGroupsChatModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';

class GroupsChatScreen extends StatefulWidget {
  const GroupsChatScreen({super.key});

  @override
  State<GroupsChatScreen> createState() => _GroupsChatScreenState();
}

class _GroupsChatScreenState extends State<GroupsChatScreen> {
  bool loding = true;
  bool nodata = false;
  List<GetNameGroupsChatModel> data = [];
  void getalhat() async {
    await ApiGroupsChatList.fetch().then((value) {
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
            });
  }

  Future<void> soketGetdattt() async {
    //جلب الماحدثه الجديده
    SocketNew.socket.on('group_message', (datasss) {
      getalhat();
      print('ameenjawadhamedde');
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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Get.isDarkMode ? NavBarColorDark : ColorTheme,
          onPressed: () {
            Get.dialog(
              Center(
                child: _AddGropus(
                  getData: getalhat,
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
          title: Text(
            'Groups',
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
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(300))),
              ),
            ),
            Positioned(
              top: 1,
              child: Container(
                width: Get.width,
                height: Get.height * 0.17,
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? NavBarColorDark : ColorTheme,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 17, 16, 16)
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.1,
                                  ),
                                  NoChatScreen(
                                    startChat: false,
                                    textData: 'There are no groups ',
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  for (var i = 0; i < data.length; i++)
                                    InkWell(
                                      onTap: () {
                                        // Get.to(GetUserMessageScreen(
                                        //   avat: data[i].avatar,
                                        //   userid: data[i].user_id,
                                        //   username: data[i].username,
                                        //   name: data[i].name,
                                        // ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    GetUserMessageGroupsScreen(
                                                  avat: data[i].avatar,
                                                  name: data[i].group_name,
                                                  group_id: data[i].group_id,
                                                  group_name:
                                                      data[i].group_name,
                                                ));
                                              },
                                              child: Row(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      CircleAvatar(
                                                        maxRadius: 30,
                                                        backgroundImage:
                                                            CachedNetworkImageProvider(
                                                                data[i]
                                                                    .avatar
                                                                    .toString()),
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        bottom: 0,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: Container(
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
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: Get.width * 0.55,
                                                        child: Text(
                                                          data[i]
                                                              .group_name
                                                              .toString(),
                                                          style: SafeGoogleFont(
                                                              Fonts.font3,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.005,
                                                      ),
                                                      // if (data[i].last_message !=
                                                      //     null)
                                                      //   Container(
                                                      //     child: Text(
                                                      //       Stringlength(
                                                      //         text: data[i]
                                                      //             .last_message[
                                                      //                 'text']
                                                      //             .toString(),
                                                      //         length: 30,
                                                      //       ),
                                                      //       style: SafeGoogleFont(
                                                      //           Fonts.font3,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w500,
                                                      //           fontSize: 14,
                                                      //           color:
                                                      //               Colors.grey),
                                                      //       maxLines: 1,
                                                      //     ),
                                                      //   ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Text(data[i].time_text)
                                          ],
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
        ));
  }
}

class _AddGropus extends StatefulWidget {
  _AddGropus({
    super.key,
    required this.getData,
  });
  final getData;
  @override
  State<_AddGropus> createState() => _AddGropusState();
}

class _AddGropusState extends State<_AddGropus> {
  List<GetAllFrindsModel> data = [];
  String userid = '0';
  GetAllFrind() async {
    FriendsApi.allFrinds('', '', userid).then((ameen) {
      setState(() {
        data = ameen.toList();
        led = false;
        userid = data[data.length - 1].user_id;
      });
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void refesh() async {
    setState(() {
      data.clear();
    });

    FriendsApi.allFrinds('', '', userid).then((value) {
      setState(() {
        data = value.toList();
        value.length - 1 == -1 ? '' : userid = value[value.length - 1].user_id;

        _refreshController.refreshCompleted();
      });
    });
  }

  void onLoding() async {
    var list = await FriendsApi.allFrinds('', '', userid);
    if (list.length - 1 == -1 ? false : userid.isNotEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 1].user_id;
    if (userid.isEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 2].user_id;
    print(userid);
    // ignore: unnecessary_null_comparison
    userid == null ? dispose() : data.addAll(list);

    _refreshController.loadComplete();

    setState(() {});
  }

  @override
  void initState() {
    GetAllFrind();
    super.initState();
  }

  XFile? ImagePost;
  String? filename;

  final ImagePicker _picker = ImagePicker();
  void ImageUplode() async {
    await Permission.camera;
    await Permission.photos;
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    image = await _cropImage(image!);
    image;

    setState(() {
      filename = image!.path.split('/').last;
      ImagePost = image;
      print(image.path);

      ;
    });
  }

  Future<XFile?> _cropImage(XFile filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath.path,
      cropStyle: CropStyle.circle,
      maxHeight: 1080,
      maxWidth: 1080,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return XFile(croppedFile!.path);
  }

  bool add = false;
  bool led = false;
  TextEditingController grou_name = TextEditingController();
  List<String> mempers = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Create a Group'),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3)),
                          width: Get.width * 0.65,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: TextField(
                              controller: grou_name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name your group',
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: Get.width * 0.65,
                            height: 5,
                            child: const MySeparator(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        ImageUplode();
                      },
                      child: CircleAvatar(
                          backgroundColor: ColorTheme,
                          maxRadius: 40,
                          child: ImagePost == null
                              ? Icon(
                                  Icons.image,
                                  color: Colors.white,
                                )
                              : CircleAvatar(
                                  maxRadius: 39,
                                  backgroundImage:
                                      FileImage(File(ImagePost!.path)),
                                )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.50,
                child: SmartRefresher(
                  onRefresh: refesh,
                  onLoading: onLoding,
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      for (var i = 0; i < data.length; i++)
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: (Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 25,
                                    backgroundImage: CachedNetworkImageProvider(
                                        data[i].avatar),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Text(Stringlength(
                                      text: data[i].name, length: 25)),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    add = false;
                                  });
                                },
                                child: Container(
                                  color: Get.isDarkMode
                                      ? NavBarColorDark
                                      : ColorTheme,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          add ? 'Adead' : 'Add',
                                          style: SafeGoogleFont(Fonts.font2,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        )
                    ],
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        led = true;
                      });
                      var ameen = await ApiGroupChatCreate.chat(
                          userid: mempers,
                          path: ImagePost == null ? '' : ImagePost!.path,
                          group_name: grou_name.text);

                      widget.getData();
                      setState(() {
                        led = false;
                      });
                      Get.back();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 68, 75, 73),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.20, vertical: 5),
                          child: led
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : Text(
                                  'Create'.tr,
                                  style: SafeGoogleFont(Fonts.font1,
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
