import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/MyProfile/EditProfileScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPostsProfile.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';

import '../../String.dart';

class MyProfileHomeScreen extends StatefulWidget {
  MyProfileHomeScreen({
    super.key,
    required this.avat,
    required this.user_id,
    required this.cover,
    required this.name,
    required this.contFollooing,
    required this.contFollowers,
    required this.contPosts,
  });

  String user_id;
  String avat;
  String cover;
  String name;
  final contPosts;
  final contFollowers;
  final contFollooing;

  @override
  State<MyProfileHomeScreen> createState() => _MyProfileHomeScreenState();
}

class _MyProfileHomeScreenState extends State<MyProfileHomeScreen> {
  bool lodingPostsMore = false;
  var lastId = '0';
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var controller = Get.find<GetMyUserDataCont>();
  int postViews = 0;
  bool lodingPosts = false;
  @override
  List<PostModel> data = [];

  void GetPosts() async {
    lodingPosts = true;
    ApiPostsProfile.Getposts('', widget.user_id).then((value) {
      if (mounted) {
        setState(() {
          data = value.toList();
          value.length - 1 == -1
              ? ''
              : lastId = value[value.length - 1].post_id;

          lodingPostsSet();
          // make your changes here
        });
      }
      lodingPosts = false;
      setState(() {});
    });
  }

  void refesh() async {
    setState(() {
      data.clear();
    });

    lodingPostsSet();
    getimydata.getUserdata();
    ApiPostsProfile.Getposts('get_news_feed', widget.user_id).then((value) {
      setState(() {
        data = value.toList();
        value.length - 1 == -1 ? '' : lastId = value[value.length - 1].post_id;

        lodingPostsSet();
        _refreshController.refreshCompleted();
      });
    });
  }

  void lodingPostsMoreSet() {
    setState(() {
      lodingPostsMore = !lodingPostsMore;
    });
  }

  bool post = false;

  void onLoding() async {
    lodingPostsMoreSet();
    var list = await ApiPostsProfile.Getposts(lastId, widget.user_id);

    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].post_id;
    // ignore: unnecessary_null_comparison
    lastId == null ? dispose() : data.addAll(list);
    if (list.length - 1 == -1) {
      post = true;
    } else {
      post = false;
    }
    _refreshController.loadComplete();
    lodingPostsMoreSet();
    setState(() {});
  }

  void lodingPostsSet() {
    setState(() {
      lodingPosts = !lodingPosts;
    });
  }

  final getimydata = Get.find<GetMyUserDataCont>();

  @override
  void initState() {
    GetPosts();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Get.isDarkMode
                  ? Color.fromARGB(255, 40, 40, 40)
                  : Colors.white,
              elevation: 0,
              centerTitle: true,
              pinned: true,
              title: Text('Profile'.tr),
              actions: [
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile Link')),
                    );
                  },
                  child: Image.asset(
                    images.ShareImage,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
              foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ];
        },
        body: SmartRefresher(
          onRefresh: refesh,
          onLoading: onLoding,
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          child: SingleChildScrollView(
            child: lodingPosts
                ? LodingPostsWidget(
                    len: 5,
                  )
                : Column(
                    children: [
                      Container(
                        color:
                            Get.isDarkMode ? ColorDarkComponents : Colors.white,
                        child: Column(
                          children: [
                            Container(
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : Colors.white,
                              height: Get.height * 0.38,
                              width: Get.width,
                              child: Obx(
                                () => Stack(
                                  children: [
                                    for (var i = 0;
                                        i < controller.data.length;
                                        i++)
                                      Container(
                                        width: Get.width,
                                        height: Get.height * 0.20,
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? ColorDarkComponents
                                                : Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  color: Colors.black)
                                            ]),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          child: CachedNetworkImage(
                                              width: Get.width,
                                              height: Get.height,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  getimydata.data[i].cover),
                                        ),
                                      ),
                                    Positioned(
                                      top: 100,
                                      child: Container(
                                        // color: Get.isDarkMode ? ColorDarkBackground : Colors.white,
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            for (var i = 0;
                                                i < controller.data.length;
                                                i++)
                                              Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    ColorTheme,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Container(
                                                            height: Get.height *
                                                                0.15,
                                                            width:
                                                                Get.width * 0.3,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: CachedNetworkImageProvider(controller
                                                                        .data[i]
                                                                        .avatar))),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: Get.height * 0.02,
                                                      right: 0,
                                                      child: InkWell(
                                                          onTap: () {
                                                            Get.to(
                                                                EditProfileSreen(
                                                              bio: controller
                                                                  .data[i]
                                                                  .about,
                                                              avat: controller
                                                                  .data[i]
                                                                  .avatar,
                                                              cover: controller
                                                                  .data[i]
                                                                  .cover,
                                                            ));
                                                          },
                                                          child: Image.asset(images
                                                              .CameraProfile))),
                                                ],
                                              ),
                                            Text(
                                              Stringlength(
                                                  text: widget.name,
                                                  length: 25),
                                              style: SafeGoogleFont(Fonts.font3,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                            for (var i = 0;
                                                i < getimydata.data.length;
                                                i++)
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          Stringlength(
                                                              text: getimydata
                                                                  .data[i]
                                                                  .about,
                                                              length: 150),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          softWrap: true,
                                                          style: SafeGoogleFont(
                                                            Fonts.font3,
                                                            fontSize: 14,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      if (Enable_Profile_Share)
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              child: InkWell(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              radius: 26,
                                              backgroundColor:
                                                  Change_Color_Icons
                                                      ? null
                                                      : Get.isDarkMode
                                                          ? ColorDarkBackground
                                                          : ColorBackIcons,
                                              child: Center(
                                                // child: SvgPicture.asset(
                                                //   Change_Color_Icons
                                                //       ? ColorSvg.Messenger
                                                //       : SvgImages.Message,
                                                //   height: Get.height * 0.02,
                                                //   width: Get.width * 0.02,
                                                //   color: Colors.black,
                                                // ),
                                                child: Image.asset(
                                                  images.ShareImage,
                                                  height: Get.height * 0.03,
                                                  width: Get.width * 0.03,
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ),
                                          )),
                                        ),
                                      Expanded(
                                        flex: 8,
                                        child: InkWell(
                                          onTap: () {
                                            for (var i = 0;
                                                i < controller.data.length;
                                                i++)
                                              Get.to(EditProfileSreen(
                                                bio: controller.data[i].about,
                                                avat: controller.data[i].avatar,
                                                cover: controller.data[i].cover,
                                              ));
                                          },
                                          child: Container(
                                            width: Get.width * 0.75,
                                            height: Get.height * 0.06,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(55),
                                                color: ColorTheme),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'Edit Profile'.tr,
                                                  style: SafeGoogleFont('',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                            child: InkWell(
                                          onTap: () {
                                            Get.to(CreatePostScreen());
                                          },
                                          child: CircleAvatar(
                                            radius: 26,
                                            backgroundColor: Change_Color_Icons
                                                ? null
                                                : Get.isDarkMode
                                                    ? ColorDarkBackground
                                                    : ColorBackIcons,
                                            child: Center(
                                              // child: SvgPicture.asset(
                                              //   Change_Color_Icons
                                              //       ? ColorSvg.Messenger
                                              //       : SvgImages.Message,
                                              //   height: Get.height * 0.02,
                                              //   width: Get.width * 0.02,
                                              //   color: Colors.black,
                                              // ),
                                              child: Image.asset(
                                                images.AddPostsMyProfile,
                                                height: Get.height * 0.04,
                                                width: Get.width * 0.04,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ])),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                // width: Get.width * 0.90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Padding(
                                  padding: Friends_System
                                      ? const EdgeInsets.all(10.0)
                                      : const EdgeInsets.all(20.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                widget.contPosts.toString(),
                                                style: SafeGoogleFont(
                                                    Fonts.font3,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Posts'.tr,
                                                style: SafeGoogleFont(
                                                    Fonts.font3,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff64748B)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: Get.height * 0.05,
                                            width: Get.width * 0.001,
                                            color: Color(0xff64748B)),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                widget.contFollowers,
                                                style: SafeGoogleFont(
                                                    Fonts.font3,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                Friends_System
                                                    ? 'Friend'.tr
                                                    : 'Followers'.tr,
                                                style: SafeGoogleFont(
                                                    Fonts.font3,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff64748B)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (Friends_System == false)
                                          Container(
                                              height: Get.height * 0.05,
                                              width: Get.width * 0.001,
                                              color: Color(0xff64748B)),
                                        if (Friends_System == false)
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  widget.contFollooing,
                                                  style: SafeGoogleFont(
                                                      Fonts.font3,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Following'.tr,
                                                  style: SafeGoogleFont(
                                                      Fonts.font3,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff64748B)),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                      Container(
                        width: Get.width,
                        color:
                            Get.isDarkMode ? ColorDarkComponents : Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    postViews = 0;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: postViews == 0 ? ColorTheme : null,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    'Posts'.tr,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.bold,
                                        color: postViews == 0
                                            ? Colors.white
                                            : Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                  // Container(
                                  //   height: 1,
                                  //   width: Get.width,
                                  //   color: postViews == 0 ? ColorTheme : Colors.grey,
                                  // )
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    postViews = 1;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: postViews == 1 ? ColorTheme : null,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    'About'.tr,
                                    style: SafeGoogleFont(Fonts.font1,
                                        fontWeight: FontWeight.bold,
                                        color: postViews == 1
                                            ? Colors.white
                                            : Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black),
                                  ),
                                  // Container(
                                  //   height: 1,
                                  //   width: Get.width,
                                  //   color: postViews == 0 ? ColorTheme : Colors.grey,
                                  // )
                                ),
                              ),
                              if (Reels)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      postViews = 2;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                        color:
                                            postViews == 2 ? ColorTheme : null,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text(
                                      'Reels'.tr,
                                      style: SafeGoogleFont(Fonts.font1,
                                          fontWeight: FontWeight.bold,
                                          color: postViews == 2
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    // Container(
                                    //   height: 1,
                                    //   width: Get.width,
                                    //   color: postViews == 0 ? ColorTheme : Colors.grey,
                                    // )
                                  ),
                                ),
                              if (false)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      postViews = 3;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                        color:
                                            postViews == 3 ? ColorTheme : null,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text(
                                      'Followers'.tr,
                                      style: SafeGoogleFont(Fonts.font1,
                                          fontWeight: FontWeight.bold,
                                          color: postViews == 3
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    // Container(
                                    //   height: 1,
                                    //   width: Get.width,
                                    //   color: postViews == 0 ? ColorTheme : Colors.grey,
                                    // )
                                  ),
                                ),
                              if (false)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      postViews = 4;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                        color:
                                            postViews == 4 ? ColorTheme : null,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text(
                                      'Following'.tr,
                                      style: SafeGoogleFont(Fonts.font1,
                                          fontWeight: FontWeight.bold,
                                          color: postViews == 4
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    // Container(
                                    //   height: 1,
                                    //   width: Get.width,
                                    //   color: postViews == 0 ? ColorTheme : Colors.grey,
                                    // )
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.grey,
                        height: 1,
                      ),
                      if (postViews == 0)
                        for (var i = 0; i < controller.data.length; i++)
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         SizedBox(
                          //           height: Get.height * 0.005,
                          //         ),
                          //
                          //         Container(
                          //           child: Text(
                          //             'Details:',
                          //             style: SafeGoogleFont(Fonts.font3,
                          //                 fontWeight: FontWeight.bold, fontSize: 19),
                          //           ),
                          //         ),
                          //
                          //         if (getimydata.data[i].address.isNotEmpty)
                          //           About(
                          //             ontap: null,
                          //             title: getimydata.data[i].address,
                          //             icons: Ionicons.location_outline,
                          //           ),
                          //         if (getimydata.data[i].gender.isNotEmpty)
                          //           About(
                          //             ontap: null,
                          //             title: getimydata.data[i].gender,
                          //             icons: getimydata.data[i].gender == 'male'
                          //                 ? Ionicons.male
                          //                 : Ionicons.female,
                          //           ),
                          //         if (getimydata.data[i].working.isNotEmpty)
                          //           About(
                          //             ontap: null,
                          //             title: getimydata.data[i].working,
                          //             icons: Icons.work,
                          //           ),
                          //         if (getimydata.data[i].working_link.isNotEmpty)
                          //           About(
                          //             ontap: null,
                          //             title: getimydata.data[i].working_link,
                          //             icons: Icons.work_outline_sharp,
                          //           ),
                          //
                          //         if (getimydata.data[i].phone_number.isNotEmpty)
                          //           About(
                          //             ontap: null,
                          //             title: getimydata.data[i].phone_number,
                          //             icons: Ionicons.phone_portrait,
                          //           ),
                          //
                          //         if (getimydata.data[i].website.isNotEmpty)
                          //           About(
                          //               title: getimydata.data[i].website,
                          //               icons: Ionicons.link_outline,
                          //               ontap: () {
                          //                 UrlGo(getimydata.data[i].website);
                          //               }),
                          //
                          //         //social
                          //         if (Social_Links)
                          //           Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 horizontal: 4),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 if (getimydata
                          //                     .data[i].facebook.isNotEmpty)
                          //                   About(
                          //                       ontap: () {
                          //                         UrlGo(
                          //                             'https://facebook.com/${getimydata.data[i].facebook}');
                          //                       },
                          //                       icons: Icons.facebook),
                          //                 if (getimydata
                          //                     .data[i].linkedin.isNotEmpty)
                          //                   About(
                          //                       icons: Ionicons.logo_twitter,
                          //                       ontap: () {
                          //                         UrlGo(
                          //                             getimydata.data[i].twitter);
                          //                       }),
                          //                 if (getimydata
                          //                     .data[i].youtube.isNotEmpty)
                          //                   About(
                          //                       icons: Ionicons.logo_youtube,
                          //                       ontap: () {
                          //                         UrlGo(
                          //                             getimydata.data[i].youtube);
                          //                       }),
                          //                 if (getimydata
                          //                     .data[i].linkedin.isNotEmpty)
                          //                   About(
                          //                       icons: Ionicons.logo_linkedin,
                          //                       ontap: () {
                          //                         UrlGo(getimydata.data[i].vk);
                          //                       }),
                          //                 if (getimydata.data[i].vk.isNotEmpty)
                          //                   About(
                          //                       icons: Ionicons.logo_vk,
                          //                       ontap: null),
                          //                 if (getimydata
                          //                     .data[i].instgram.isNotEmpty)
                          //                   About(
                          //                       icons: Ionicons.logo_instagram,
                          //                       ontap: null),
                          //               ],
                          //             ),
                          //           )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          if (getimydata.data[i].working.isNotEmpty ||
                              getimydata.data[i].working_link.isNotEmpty ||
                              getimydata.data[i].website.isNotEmpty)
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.005,
                                      ),
                                      Container(
                                        child: Text(
                                          'Details:',
                                          style: SafeGoogleFont(Fonts.font3,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      if (getimydata.data[i].working.isNotEmpty)
                                        About(
                                          ontap: null,
                                          title: 'Working at: ' +
                                              getimydata.data[i].working,
                                          icons: Icons.work,
                                        ),
                                      if (getimydata
                                          .data[i].working_link.isNotEmpty)
                                        About(
                                          ontap: () {
                                            UrlGo(getimydata
                                                .data[i].working_link);
                                          },
                                          title:
                                              getimydata.data[i].working_link,
                                          icons: Icons.work_outline_sharp,
                                        ),
                                      if (getimydata.data[i].website.isNotEmpty)
                                        About(
                                            title: getimydata.data[i].website,
                                            icons: Ionicons.link_outline,
                                            ontap: () {
                                              UrlGo(getimydata.data[i].website);
                                            }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      if (postViews == 0)
                        lodingPosts
                            ? LodingPostsWidget(
                                len: 5,
                              )
                            : Column(
                                children: [
                                  for (var i = 0; i < data.length; i++)
                                    WidgetPosts(
                                      blur: data[i].blur,
                                      color_id: data[i].color_id,
                                      stream_name: data[i].stream_name,
                                      pro_type: data[i].pro_type,
                                      is_pro: data[i].is_pro,
                                      ad_media: data[i].ad_media,
                                      biddingAds: data[i].biddingAds,
                                      descriptionAds: data[i].descriptionAds,
                                      nameAds: data[i].nameAds,
                                      user_dataAds: data[i].user_dataAds,
                                      headline: data[i].headline,
                                      Boosted: false,
                                      yout: data[i].postYoutube,
                                      shared_info: data[i].shared_info,
                                      url_post: data[i].urlsss,
                                      trueflasecommet: data[i].comments_status,
                                      more: Container(
                                          child: IconButton(
                                              onPressed: () {
                                                Get.bottomSheet(
                                                  WidgetMorePosts(
                                                    refreshPost: () {
                                                      GetPosts();
                                                    },
                                                    postText: data[i].postText,
                                                    pos: data[i].post_id,
                                                    hidePost: () {
                                                      setState(() {
                                                        data.removeAt(i);
                                                      });
                                                    },
                                                    remove: () {
                                                      QuickAlert.show(
                                                        onConfirmBtnTap: () {
                                                          PostActionsApi.reaction(
                                                                  data[i]
                                                                      .post_id,
                                                                  'delete')
                                                              .asStream();
                                                          data.removeAt(i);

                                                          Get.back();
                                                          Get.back();
                                                        },
                                                        context: context,
                                                        type: QuickAlertType
                                                            .confirm,
                                                        text:
                                                            'Do you want to delete the post'
                                                                .tr,
                                                        confirmBtnText:
                                                            'Yes'.tr,
                                                        cancelBtnText: 'No'.tr,
                                                        confirmBtnColor:
                                                            Colors.red,
                                                      );
                                                    },
                                                    adminPost: data[i].admin,
                                                    avat: data[i].avatar,
                                                    name: data[i].name,
                                                    user_id: data[i].user_id,
                                                    url_post: data[i].urlsss,
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.more_vert))),
                                      reomvePost: () {
                                        setState(() {
                                          data.removeAt(i);
                                        });
                                      },
                                      comment_cont: data[i].comments_status,
                                      adminPost: data[i].admin,
                                      user_id: data[i].user_id,
                                      data: data,
                                      iint: i,
                                      imReaction: data[i].type,
                                      reaction: data[i].reaction,
                                      post_id: data[i].post_id,
                                      postType: data[i].postType,
                                      verified: data[i].verified,
                                      postFeeling: data[i].postFeeling,
                                      time: data[i].post_time,
                                      name: data[i].name,
                                      avat: data[i].avatar,
                                      postText: data[i].postText,
                                      postFile: data[i].postFile,
                                      p1080p: data[i].p1080,
                                      p2048p: data[i].p2048,
                                      p240p: data[i].p240,
                                      p360p: data[i].p360,
                                      p4096p: data[i].p4096,
                                      p480p: data[i].p480,
                                      p720p: data[i].p720,
                                      options: data[i].options,
                                      postRecord: data[i].postRecord,
                                      contLike: data[i].reaction,
                                      contcoment:
                                          int.parse(data[i].post_comments),
                                      islike: data[i].reaction1,
                                      photoMulti2: data[i].photoMulti2,
                                      photo_album: data[i].photo_album,
                                      postimage: data[i].postFile,
                                      type: data[i].type,
                                      page_id: data[i].page_id,
                                      group_id: data[i].group_id,
                                      avatar_group: data[i].avatargroupe,
                                      name_group: data[i].group_name,
                                      cover: data[i].cover,
                                      product_id: data[i].product_id,
                                      product: data[i].product,
                                      event: data[i].event,
                                    ),
                                ],
                              ),
                      if (postViews == 1)
                        for (var i = 0; i < getimydata.data.length; i++)
                          Container(
                            color: Get.isDarkMode
                                ? ColorDarkComponents
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    Container(
                                      child: Text(
                                        'Details:',
                                        style: SafeGoogleFont(Fonts.font3,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    if (getimydata.data[i].about.isNotEmpty)
                                      About(
                                        ontap: null,
                                        title: getimydata.data[i].about,
                                        icons: Ionicons.information_circle,
                                      ),
                                    if (getimydata.data[i].address.isNotEmpty)
                                      About(
                                        ontap: null,
                                        title: getimydata.data[i].address,
                                        icons: Ionicons.location_outline,
                                      ),

                                    if (getimydata.data[i].gender.isNotEmpty)
                                      About(
                                        ontap: null,
                                        title: getimydata.data[i].gender,
                                        icons:
                                            getimydata.data[i].gender == 'male'
                                                ? Ionicons.male
                                                : Ionicons.female,
                                      ),
                                    if (getimydata.data[i].working.isNotEmpty)
                                      About(
                                        ontap: null,
                                        title: getimydata.data[i].working,
                                        icons: Icons.work,
                                      ),
                                    if (getimydata
                                        .data[i].working_link.isNotEmpty)
                                      About(
                                        ontap: () {
                                          UrlGo(
                                              getimydata.data[i].working_link);
                                        },
                                        title: getimydata.data[i].working_link,
                                        icons: Icons.work_outline_sharp,
                                      ),

                                    if (getimydata
                                        .data[i].phone_number.isNotEmpty)
                                      About(
                                        ontap: null,
                                        title: getimydata.data[i].phone_number,
                                        icons: Ionicons.phone_portrait,
                                      ),

                                    if (getimydata.data[i].website.isNotEmpty)
                                      About(
                                          title: getimydata.data[i].website,
                                          icons: Ionicons.link_outline,
                                          ontap: () {
                                            UrlGo(getimydata.data[i].website);
                                          }),

                                    //social
                                    if (Social_Links)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (getimydata
                                                .data[i].facebook.isNotEmpty)
                                              SocialMedia(
                                                  icons: Icons.facebook,
                                                  ontap: () {
                                                    UrlGo(
                                                        'https://facebook.com/${getimydata.data[i].facebook}');
                                                  }),
                                            if (getimydata
                                                .data[i].twitter.isNotEmpty)
                                              SocialMedia(
                                                  icons: Ionicons.logo_twitter,
                                                  ontap: () {
                                                    UrlGo(
                                                        'https://twitter.com/${getimydata.data[i].twitter}');
                                                  }),
                                            if (getimydata
                                                .data[i].youtube.isNotEmpty)
                                              SocialMedia(
                                                  icons: Ionicons.logo_youtube,
                                                  ontap: () {
                                                    UrlGo(
                                                        'https://youtube.com/${getimydata.data[i].youtube}');
                                                  }),
                                            if (getimydata
                                                .data[i].linkedin.isNotEmpty)
                                              SocialMedia(
                                                  icons: Ionicons.logo_linkedin,
                                                  ontap: () {
                                                    UrlGo(
                                                        'https://linkedin.com/${getimydata.data[i].linkedin}');
                                                  }),
                                            if (getimydata
                                                .data[i].vk.isNotEmpty)
                                              SocialMedia(
                                                  icons: Ionicons.logo_vk,
                                                  ontap: () {
                                                    UrlGo(
                                                        'https://facebook.com/${getimydata.data[i].vk}');
                                                  }),
                                            if (getimydata
                                                .data[i].instgram.isNotEmpty)
                                              SocialMedia(
                                                  icons:
                                                      Ionicons.logo_instagram,
                                                  ontap: () {
                                                    UrlGo(
                                                        'https://instgram.com/${getimydata.data[i].instgram}');
                                                  }),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
