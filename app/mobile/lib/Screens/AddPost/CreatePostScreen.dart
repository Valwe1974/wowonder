import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostCont.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Widget/VideoList.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key, this.open}) : super(key: key);
  String? open;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  String postPrivacu = '0';
  bool newPool = false;
  openWidget(controller) async {
    if (widget.open != null) {
      if (widget.open == 'gallery')
        Get.bottomSheet(WidgetPhotoAnvideo(controller));
    }
  }

  void getPublicSgerd() async {
    Get.put(CreatePostCont());
    var getpublic = await SharedP.Get('PostPublic');
    setState(() {
      postPrivacu = getpublic == null ? '0' : getpublic;
    });
  }

  @override
  void initState() {
    getPublicSgerd();

    super.initState();
  }

  savePublicSherd() async {
    await SharedP.Save('PostPublic', postPrivacu);
  }

  int addNewPoll = 2;
  int plusNewpoll = 2;
  String smaileText = '';
  String smaileIcon = '';

  Widget build(BuildContext context) {
    return GetBuilder<CreatePostCont>(
        init: CreatePostCont(),
        builder: ((controller) {
          openWidget(controller);

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottomNavigationBar: Container(
                height: Get.height * 0.12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Get.isDarkMode
                        ? backRoundContDark
                        : backRoundContLight),
                child: Container(
                  decoration: BoxDecoration(
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            color: Get.isDarkMode ? Colors.white : Colors.black)
                      ]),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    child: Column(
                      children: [
                        ExpandableMenu(
                            width: 40.0,
                            height: 40.0,
                            backgroundColor: Colors.black,
                            iconColor: ColorTheme,
                            itemContainerColor: Colors.amber,
                            items: [
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.bottomSheet(
                                      WidgetPhotoAnvideo(controller));
                                },
                                child: WidgetPostImagesNav(
                                  images: 'SDF.png',
                                ),
                              ),
                              if (true)
                                WidgetPostImagesNav(
                                  images: 'friend.png',
                                ),
                              InkWell(
                                onTap: () {
                                  Get.bottomSheet(felling(controller));
                                },
                                child: WidgetPostImagesNav(
                                  images: 'hg.png',
                                ),
                              ),
                              if (true)
                                WidgetPostImagesNav(
                                  images: 'Iconly-Bold-Location.png',
                                ),
                              InkWellMreNave(
                                controller: controller,
                                onTapVideoImage: () {
                                  Get.back();
                                  Get.bottomSheet(
                                      WidgetPhotoAnvideo(controller));
                                },
                                ontapPoll: () {
                                  setState(() {
                                    newPool = true;
                                    Get.back();
                                  });
                                },
                                onTapFeling: () {
                                  Get.back();
                                  Get.bottomSheet(felling(controller));
                                },
                              ),
                            ]),
                      ],
                    ),
                  ),
                )),
            appBar: AppBar(
              centerTitle: false,
              foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
              backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
              title: Text('Create Post'.tr,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 18)),
              actions: [
                InkWell(
                  onTap: () {
                    // if (newPool) {
                    //   if (controller.poll1.text.isNotEmpty) {
                    //     if (controller.poll2.text.isNotEmpty) {
                    //       controller.CreatPost(postPrivacu);
                    //       Get.offAll(HomeNavBar());
                    //     } else {
                    //       Get.snackbar(
                    //           'Error', 'Make sure to mention the questions');
                    //     }
                    //   } else {
                    //     Get.snackbar(
                    //         'Error', 'Make sure to mention the questions');
                    //   }
                    // } else {
                    controller.CreatPost(postPrivacu);
                    Get.offAll(HomeNavBar());
                    controller.cleare();

                    // }
                    // controller.CreatPost(postPrivacu);

                    // if (Get.arguments == null) Get.offAllNamed(Routes.navbar);
                    // if (Get.arguments['group_id'].toString().isNotEmpty)
                    //   Get.to(
                    //       GroupsScreen(group_id: Get.arguments['group_id']));
                    // if (Get.arguments['user_id'].toString().isNotEmpty)
                    //   Get.to(
                    //       GroupsScreen(group_id: Get.arguments['group_id']));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Get.isDarkMode
                            ? colorTextBoardingDark1
                            : colorTextBoardingLight1,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          child: Text("Post".tr,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<GetMyUserDataCont>(
                        init: GetMyUserDataCont(),
                        builder: ((controller) => Row(
                              children: [
                                for (var i = 0; i < controller.data.length; i++)
                                  CircleAvatar(
                                    maxRadius: 25,
                                    backgroundImage: CachedNetworkImageProvider(
                                        controller.data[i].avatar),
                                  ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var i = 0;
                                        i < controller.data.length;
                                        i++)
                                      Text(
                                        controller.data[i].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                                  'assets/svg/photos-selection-svgrepo-com.svg',
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : null,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text(
                                                  'People I Follow'.tr,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          if (postPrivacu == '0')
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/svg/global-search-svgrepo-com.svg',
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : null,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Everyone'.tr,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          if (postPrivacu == '2')
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/svg/colorfilter-svgrepo-com.svg',
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : null,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text(
                                                  'People Follow Me'.tr,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          if (postPrivacu == '3')
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/svg/profile-tick-svgrepo-com.svg',
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : null,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Only me'.tr,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                            )),
                      )),

                  if (smaileIcon.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                controller.smailetext.clear();
                                smaileIcon = '';
                              });
                            },
                            child: CircleAvatar(
                              maxRadius: 12,
                              backgroundColor: colorTextBoardingDark1,
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text('Feel:'.tr),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Text(
                            controller.smailetext.text.tr,
                            style: TextStyle(),
                          ),
                          Text(
                            smaileIcon,
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.textEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: newPool
                                ? 'Create a poll'.tr
                                : 'what are you thinking?'.tr,
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                  if (controller.imageFileList.isNotEmpty)
                    Container(
                      height: Get.height * 0.60,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GridView.builder(
                            itemCount: controller.imageFileList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        controller.imageFileList.length > 4
                                            ? 3
                                            : 2),
                            itemBuilder: ((context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9),
                                    child: InkWell(
                                      onTap: () {
                                        controller.reomveSelected(index);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: Get.width * 0.60,
                                            height: Get.height * 0.09,
                                            decoration: BoxDecoration(
                                                color: colorTextBoardingDark1,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Container(
                                              width: Get.width * 0.60,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 21,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.05,
                                  ),
                                  Container(
                                    width: Get.width * 0.70,
                                    height: Get.height * 0.70,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 20),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.file(
                                            File(controller
                                                .imageFileList[index].path),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            })),
                      ),
                    ),
                  if (newPool)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(56, 158, 158, 158),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    newPool = false;
                                    controller.poll1.clear();
                                    controller.poll2.clear();
                                    controller.poll3.clear();
                                    controller.poll4.clear();
                                    controller.poll5.clear();
                                    controller.poll6.clear();
                                    controller.poll7.clear();
                                    controller.poll8.clear();
                                  });
                                },
                                child: CircleAvatar(
                                  maxRadius: 12,
                                  backgroundColor: colorTextBoardingDark1,
                                  child: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(118, 158, 158, 158),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: TextField(
                                    controller: controller.poll1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Question 1'.tr,
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(118, 158, 158, 158),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: TextField(
                                    controller: controller.poll2,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Question 2'.tr,
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              if (2 < addNewPoll)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll3,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 3'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (3 < addNewPoll)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll4,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 4'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (4 < addNewPoll)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll5,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 5'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (5 < addNewPoll)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll6,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 6'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (6 < addNewPoll)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll7,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 7'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (7 < addNewPoll)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              118, 158, 158, 158),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextField(
                                          controller: controller.poll8,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Question 8'.tr,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              if (2 < addNewPoll)
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        addNewPoll--;
                                      });
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: colorTextBoardingDark1,
                                        child: Icon(Icons.delete,
                                            color: Colors.white))),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              if (addNewPoll != 8)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      addNewPoll++;
                                      print(addNewPoll);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: colorTextBoardingDark1,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text('Add'.tr,
                                              style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 16))),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),

                  controller.ImagePost != null
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  controller.ImagePost = null;
                                });
                              },
                              child: Container(
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                    color: colorTextBoardingDark1,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    )),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Image.file(
                              File(controller.ImagePost!.path),
                              width: Get.width * 0.5,
                            ),
                          ],
                        )
                      : SizedBox(),
                  //  Image.file(File(controller.ameenhamed!.path)),

                  controller.videoUp != null
                      ? VideosList(
                          videoPlayerController: VideoPlayerController.file(
                              File(controller.videoUp!.path)),
                          looping: true)
                      : SizedBox()
                ],
              ),
            ),
          );
        }));
  }

  Widget felling(controller) {
    return Container(
      //height: Get.height * 0.40,
      height: Get.height * 0.40,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.back();
                Get.dialog(Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    height: Get.height * 0.50,
                    width: Get.width * 0.80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScaffoldWidget(
                        title: 'Feeling'.tr,
                        centerTitle: true,
                        elevation: 0,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'happy';

                                    setState(() {
                                      smaileIcon = '😃';
                                      smaileText = controller.smailetext.text;
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😃',
                                    text: 'Happy'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'loved';

                                    setState(() {
                                      smaileIcon = '🥰';
                                      smaileText = controller.smailetext.text;
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🥰',
                                    text: 'Loved'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'sad';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileIcon = '😞';
                                      smaileText = controller.smailetext.text;
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😞',
                                    text: 'Sad'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'so_sad';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😭';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😭',
                                    text: 'Very Sad'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'angry';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😡';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😡',
                                    text: 'Angry'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'angry';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;

                                      smaileIcon = '😕';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😕',
                                    text: 'Confused'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'smirk';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '🥵';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🥵',
                                    text: 'Hot'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'broke';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '💔';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '💔',
                                    text: 'Broken'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text =
                                        'expressionless';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😑';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😑',
                                    text: 'expressionless'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'cool';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😎';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😎',
                                    text: 'Cool'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'funny';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😂';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😂',
                                    text: 'Funny'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'tired';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😫';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😫',
                                    text: 'Tired'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'lovely';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '❤️';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '❤️',
                                    text: 'Lovely'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'blessed';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😇';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😇',
                                    text: 'Blessed'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'shocked';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😵';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😵',
                                    text: 'Shocked',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'sleepy';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '😴';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '😴',
                                    text: 'Sleepy'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'pretty';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '🌺';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🌺',
                                    text: 'Pretty'.tr,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.smailetext.text = 'bored';
                                    print(
                                        controller.smailetext.text.toString());
                                    setState(() {
                                      smaileText = controller.smailetext.text;
                                      smaileIcon = '🥱';
                                    });
                                    Get.back();
                                  },
                                  child: FeelinngSmileWidget(
                                    smailetext: '🥱',
                                    text: 'Bored'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        loding: false,
                        AppBarTrueOrFalse: true,
                      ),
                    ),
                  ),
                ));
              },
              child: Row(
                children: [
                  WidgetPostImagesNav(
                    images: 'hg.png',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Felling'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (true)
              SizedBox(
                height: Get.height * 0.01,
              ),
            if (true)
              Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: true,
                    colorr: Colors.blue,
                    images: 'travel-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Traveling to'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                ],
              ),
            if (true)
              SizedBox(
                height: Get.height * 0.01,
              ),
            if (true)
              Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: true,
                    colorr: colorTextBoardingDark1,
                    images: 'watching-a-video-on-a-tablet-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Watching'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorTextBoardingDark1),
                  ),
                ],
              ),
            if (true)
              SizedBox(
                height: Get.height * 0.01,
              ),
            if (true)
              Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: false,
                    colorr: Colors.blue,
                    images: 'man-playing-handball-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Playing'.tr,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ],
              ),
            if (true)
              SizedBox(
                height: Get.height * 0.01,
              ),
            if (true)
              Row(
                children: [
                  WidgetPostImagesNavSvg(
                    colorbool: true,
                    colorr: Colors.deepPurpleAccent,
                    images: 'listening-svgrepo-com.svg',
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Listening to'.tr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
          ],
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
                  savePublicSherd();

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
                  savePublicSherd();
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
                  savePublicSherd();
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
                  savePublicSherd();
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

  Widget WidgetPhotoAnvideo(camera) {
    return Container(
      width: Get.width,
      height: Get.height * 0.40,
      decoration: BoxDecoration(
          color:
              Get.isDarkMode ? Color.fromARGB(255, 31, 30, 30) : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 15,
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.04),
            InkWell(
              onTap: () => camera.selectimges(),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                          child: SvgPicture.asset(
                              'assets/svg/photos-selection-svgrepo-com.svg',
                              color: Colors.green)),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Images / Gallery'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () => camera.vedioupolde(ImageSource.gallery),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/youtube.png',
                          color: colorTextBoardingDark1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Video / Gallery'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () => camera.UplodeImage(ImageSource.camera),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/images/svg/camera-svgrepo-com.svg',
                        color: Colors.green,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Images / Camera'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: () => camera.vedioupolde(ImageSource.camera),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/images/svg/camera-svgrepo-com.svg',
                        color: Colors.red,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Video / Camera'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class InkWellMreNave extends StatelessWidget {
  InkWellMreNave({
    required this.ontapPoll,
    required this.onTapVideoImage,
    required this.controller,
    required this.onTapFeling,
    Key? key,
  }) : super(key: key);
  final ontapPoll;
  final onTapVideoImage;
  final controller;
  final onTapFeling;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(Stack(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.04),
                    InkWell(
                      onTap: onTapVideoImage,
                      child: Row(
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFEEEF0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/SDF.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            'Images / Video'.tr,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (false) SizedBox(height: Get.height * 0.02),
                    if (false)
                      Row(
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFEEEF0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/friend.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            'Mention to friends'.tr,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    SizedBox(height: Get.height * 0.02),
                    InkWell(
                      onTap: onTapFeling,
                      child: Row(
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFEEEF0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/hg.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            'feeling / activity'.tr,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    if (true) SizedBox(height: Get.height * 0.02),
                    if (true)
                      Row(
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFEEEF0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/Iconly-Bold-Location.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            'place'.tr,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    if (true) SizedBox(height: Get.height * 0.02),
                    if (true)
                      Row(
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFEEEF0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/GIF.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            'GIF',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    SizedBox(height: Get.height * 0.02),
                    InkWell(
                      onTap: ontapPoll,
                      child: Row(
                        children: [
                          Container(
                            height: Get.height * 0.06,
                            width: Get.width * 0.14,
                            decoration: BoxDecoration(
                                color: Color(0xffFEEEF0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/Polls.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            'Polls'.tr,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(),
            Positioned(
              left: Get.width * 0.30,
              right: Get.width * 0.30,
              top: Get.height * 0.01,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 1, spreadRadius: 1)
                  ],
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                width: Get.width * 0.40,
                height: 3,
              ),
            )
          ],
        ));
      },
      child: WidgetPostImagesNav(
        images: 'more_horiz_black_24dp (4).png',
      ),
    );
  }
}

// class FellimgWidget extends StatelessWidget {
//   const FellimgWidget({
//     required this.finggg,
//     required this.controller,
//     super.key,
//   });
//   final controller;
//   final finggg;
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class FeelinngSmileWidget extends StatelessWidget {
  FeelinngSmileWidget({
    required this.smailetext,
    required this.text,
    super.key,
  });
  String smailetext;
  String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              smailetext,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
// class FellimgWidget extends StatelessWidget {
//   const FellimgWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(13.0),
//               child: Row(
//                 children: [
//                   WidgetPostImagesNav(
//                     images: 'hg.png',
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class WidgetPostImagesNav extends StatelessWidget {
  WidgetPostImagesNav({
    required this.images,
    Key? key,
  }) : super(key: key);
  String images;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      width: Get.width * 0.13,
      decoration: BoxDecoration(
          color: Color(0xffFEEEF0), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/$images',
          height: Get.height * 0.08,
          width: Get.width * 0.08,
        ),
      ),
    );
  }
}

class WidgetPostImagesNavSvg extends StatelessWidget {
  WidgetPostImagesNavSvg({
    required this.colorr,
    required this.images,
    required this.colorbool,
    Key? key,
  }) : super(key: key);
  bool colorbool;
  String images;
  Color colorr;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      width: Get.width * 0.13,
      decoration: BoxDecoration(
          color: Color(0xffFEEEF0), borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: SvgPicture.asset(
            'assets/images/svg/$images',
            color: colorbool ? colorr : null,
          ),
        ),
      ),
    );
  }
}

// Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // controller.UplodeImage(ImageSource.gallery);
//                           Get.bottomSheet(Container(
//                             height: Get.height * 0.2,
//                             width: Get.width * 0.2,
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     controller.UplodeImage(ImageSource.camera);
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(Icons.camera,
//                                               color: Colors.red[900]),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Camera',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     controller.UplodeImage(ImageSource.gallery);
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(
//                                             Icons.photo,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Gallery',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ));
//                         },
//                         child: CircleAvatar(
//                             child: Icon(Icons.photo, color: Colors.green)),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // controller.vedioupolde(ImageSource.gallery);
//                           Get.bottomSheet(Container(
//                             height: Get.height * 0.2,
//                             width: Get.width * 0.2,
//                             child: Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     controller.vedioupolde(ImageSource.camera);
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(Icons.camera,
//                                               color: Colors.red[900]),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Camera',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     controller.vedioupolde(ImageSource.gallery);
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Center(
//                                         child: CircleAvatar(
//                                           child: Icon(
//                                             Icons.photo,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         'Gallery',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ));
//                         },
//                         child: CircleAvatar(
//                           child: Icon(
//                             Icons.video_call,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       controller.records
//                           ? InkWell(
//                               onTap: () {
//                                 // controller.stoprecord();
//                               },
//                               child: CircleAvatar(
//                                 child: Icon(
//                                   Icons.stop,
//                                   color: Colors.redAccent,
//                                 ),
//                               ),
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 // controller.recored();
//                               },
//                               child: CircleAvatar(
//                                 child: Icon(
//                                   Icons.mic,
//                                   color: Colors.redAccent,
//                                 ),
//                               ),
//                             )
//                     ],
//                   )
