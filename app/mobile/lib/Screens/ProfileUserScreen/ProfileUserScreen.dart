import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quickalert/quickalert.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GetUserMessageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/WidgetReportUser.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiBlockUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFetchPokes.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFollowUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPostsProfile.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ProfileUserScreen extends StatefulWidget {
  ProfileUserScreen({
    super.key,
    required this.avat,
    required this.user_id,
    required this.cover,
    required this.name,
  });
  String user_id;
  String avat;
  String cover;
  String name;

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  int postViews = 0;
  bool lodingPosts = false;
  bool follow = false;
  @override
  List<PostModel> data = [];
  void GetPosts() async {
    lodingPosts = true;
    ApiPostsProfile.Getposts('', widget.user_id).then((value) {
      data = value.toList();
      lodingPosts = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    getUserdata();
    GetPosts();

    super.initState();
  }

  List<GetUserDataModel> datauser = [];

  void getUserdata() async {
    GetUserDataApi.getUserData(widget.user_id).then((ameen) {
      datauser = ameen.toList();
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                Image.asset(
                  images.ShareImage,
                ),
                IconButton(
                  onPressed: () {
                    showAdaptiveActionSheet(
                      context: context,

                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                          title: Text('Poke'.tr),
                          onPressed: (BuildContext context) {
                            ApiSendPoke.Send(widget.user_id);
                            Get.back();
                            Get.snackbar('Poke'.tr, 'done'.tr);
                          },
                        ),
                        BottomSheetAction(
                          title: Text('Report'.tr),
                          onPressed: (BuildContext context) {
                            Get.dialog(WidgetReportUser(
                                user_id: widget.user_id,
                                name: datauser[0].name,
                                Report: 'Report Page User'.tr));
                          },
                        ),
                        BottomSheetAction(
                          title: Text('Block User'.tr),
                          onPressed: (BuildContext context) async {
                            var test = await ApiBlockUnBlockUser.blcked(
                                widget.user_id, 'block');
                            // onRefresh();
                            Get.back();
                            Get.back();

                            print(test);
                          },
                        ),
                      ],
                      cancelAction: CancelAction(
                          title: Text('Cancel'
                              .tr)), // onPressed parameter is optional by default will dismiss the ActionSheet
                    );
                  },
                  icon: Icon(Icons.more_horiz),
                ),
              ],
              foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: Get.height * 0.33,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
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
                                  imageUrl: widget.cover),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            child: Container(
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: ColorTheme,
                                                shape: BoxShape.circle),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                height: Get.height * 0.15,
                                                width: Get.width * 0.3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                widget.avat))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //     bottom: Get.height * 0.02,
                                      //     right: 0,
                                      //     child: Image.asset(
                                      //         images.CameraProfile)),
                                    ],
                                  ),
                                  Text(
                                    Stringlength(text: widget.name, length: 25),
                                    style: SafeGoogleFont(Fonts.font3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  for (var i = 0; i < datauser.length; i++)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          postViews = 1;
                                        });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  Stringlength(
                                                      text: datauser[i].about,
                                                      length: 150),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  style: SafeGoogleFont(
                                                    Fonts.font3,
                                                    fontSize: 14,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var i = 0; i < datauser.length; i++)
                            if (Enable_Profile_Share)
                              Expanded(
                                flex: 2,
                                child: Container(
                                    child: InkWell(
                                  onTap: () async {
                                    await Share.share(
                                        '${datauser[i].name}\'s private profile ' +
                                            accounts[0]['sm0'] +
                                            '/' +
                                            datauser[i].username);
                                  },
                                  child: CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Change_Color_Icons
                                        ? null
                                        : Get.isDarkMode
                                            ? Colors.black
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
                                            : null,
                                      ),
                                    ),
                                  ),
                                )),
                              ),
                          for (var i = 0; i < datauser.length; i++)
                            Expanded(
                              flex: 8,
                              child: Container(
                                child: Friends_System
                                    ? OnTapFrind(
                                        user_id: datauser[i].user_id,
                                        confirm_followers:
                                            datauser[i].confirm_followers,
                                        is_following: datauser[i].is_following,
                                        can_follow: datauser[i].can_follow,
                                        message_privacy:
                                            datauser[i].message_privacy,
                                        // controller.data[i].user_id;
                                      )
                                    : OnTapFoloow(
                                        user_id: datauser[i].user_id,
                                        confirm_followers:
                                            datauser[i].confirm_followers,
                                        is_following: datauser[i].is_following,
                                        can_follow: datauser[i].can_follow,
                                        message_privacy:
                                            datauser[i].message_privacy,
                                        // controller.data[i].user_id;
                                      ),
                              ),
                            ),
                          for (var i = 0; i < datauser.length; i++)
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: InkWell(
                                onTap: () {
                                  Get.to(GetUserMessageScreen(
                                    avat: datauser[i].avatar,
                                    userid: datauser[i].user_id,
                                    username: datauser[i].username,
                                    name: datauser[i].name,
                                  ));
                                  // Get.to(CreatePostScreen());
                                },
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Change_Color_Icons
                                      ? null
                                      : Get.isDarkMode
                                          ? Colors.black
                                          : ColorTheme,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Change_Color_Icons
                                          ? ColorSvg.Messenger
                                          : SvgImages.Message,
                                      height: Get.height * 0.025,
                                      width: Get.width * 0.025,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                            ),
                        ],
                      ),
                    ),
                    for (var i = 0; i < datauser.length; i++)
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
                                          datauser[i].post_count,
                                          style: SafeGoogleFont(Fonts.font3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Posts'.tr,
                                          style: SafeGoogleFont(Fonts.font3,
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
                                          datauser[i].followers_count,
                                          style: SafeGoogleFont(Fonts.font3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          Friends_System
                                              ? 'Friend'.tr
                                              : 'Followers'.tr,
                                          style: SafeGoogleFont(Fonts.font3,
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
                                            datauser[i].following_count,
                                            style: SafeGoogleFont(Fonts.font3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Following'.tr,
                                            style: SafeGoogleFont(Fonts.font3,
                                                fontWeight: FontWeight.w600,
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

              // for (var i = 0; i < datauser.length; i++)
              Container(
                width: Get.width,
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              color: postViews == 0 ? ColorTheme : null,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'Posts'.tr,
                            style: SafeGoogleFont(Fonts.font1,
                                fontWeight: FontWeight.bold,
                                color: postViews == 0
                                    ? Colors.white
                                    : Colors.grey),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                              color: postViews == 1 ? ColorTheme : null,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'About'.tr,
                            style: SafeGoogleFont(Fonts.font1,
                                fontWeight: FontWeight.bold,
                                color: postViews == 1
                                    ? Colors.white
                                    : Colors.grey),
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
                                color: postViews == 2 ? ColorTheme : null,
                                borderRadius: BorderRadius.circular(50)),
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
                                color: postViews == 3 ? ColorTheme : null,
                                borderRadius: BorderRadius.circular(50)),
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
                                color: postViews == 4 ? ColorTheme : null,
                                borderRadius: BorderRadius.circular(50)),
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
                for (var i = 0; i < datauser.length; i++)
                  if (datauser[i].working.isNotEmpty ||
                      datauser[i].working_link.isNotEmpty ||
                      datauser[i].website.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color:
                          Get.isDarkMode ? ColorDarkComponents : Colors.white,
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
                              if (datauser[i].working.isNotEmpty)
                                About(
                                  ontap: null,
                                  title: 'Working at: ' + datauser[i].working,
                                  icons: Icons.work,
                                ),
                              if (datauser[i].working_link.isNotEmpty)
                                About(
                                  ontap: () {
                                    UrlGo(datauser[i].working_link);
                                  },
                                  title: datauser[i].working_link,
                                  icons: Icons.work_outline_sharp,
                                ),
                              if (datauser[i].website.isNotEmpty)
                                About(
                                    title: datauser[i].website,
                                    icons: Ionicons.link_outline,
                                    ontap: () {
                                      UrlGo(datauser[i].website);
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
                              headline: data[i].headline,
                              Boosted: false,
                              yout: data[i].postYoutube,
                              shared_info: data[i].shared_info,
                              trueflasecommet: data[i].comments_status,
                              event: data[i].event,
                              product_id: data[i].product_id,
                              product: data[i].product,
                              more: Container(
                                  child: IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          WidgetMorePosts(
                                            url_post: data[i].urlsss,
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
                                                          data[i].post_id,
                                                          'delete')
                                                      .asStream();
                                                  data.removeAt(i);

                                                  Get.back();
                                                  Get.back();
                                                },
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                text:
                                                    'Do you want to delete the post'
                                                        .tr,
                                                confirmBtnText: 'Yes'.tr,
                                                cancelBtnText: 'No'.tr,
                                                confirmBtnColor: Colors.red,
                                              );
                                            },
                                            adminPost: data[i].admin,
                                            avat: data[i].avatar,
                                            name: data[i].name,
                                            user_id: data[i].user_id,
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
                              ad_media: data[i].ad_media,
                              biddingAds: data[i].biddingAds,
                              descriptionAds: data[i].descriptionAds,
                              nameAds: data[i].nameAds,
                              user_dataAds: data[i].user_dataAds,
                              adminPost: data[i].admin,
                              user_id: data[i].user_id,
                              data: data,
                              pro_type: data[i].pro_type,
                              is_pro: data[i].is_pro,
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
                              contcoment: int.parse(data[i].post_comments),
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
                              url_post: data[i].urlsss,
                            ),
                        ],
                      ),

              if (postViews == 1)
                for (var i = 0; i < datauser.length; i++)
                  Container(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
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
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            if (datauser[i].about.isNotEmpty)
                              About(
                                ontap: null,
                                title: datauser[i].about,
                                icons: Ionicons.information_circle,
                              ),
                            if (datauser[i].address.isNotEmpty)
                              About(
                                ontap: null,
                                title: datauser[i].address,
                                icons: Ionicons.location_outline,
                              ),
                            if (datauser[i].gender.isNotEmpty)
                              About(
                                ontap: null,
                                title: datauser[i].gender,
                                icons: datauser[i].gender == 'male'
                                    ? Ionicons.male
                                    : Ionicons.female,
                              ),
                            if (datauser[i].working.isNotEmpty)
                              About(
                                ontap: null,
                                title: datauser[i].working,
                                icons: Icons.work,
                              ),
                            if (datauser[i].working_link.isNotEmpty)
                              About(
                                ontap: () {
                                  UrlGo(datauser[i].working_link);
                                },
                                title: datauser[i].working_link,
                                icons: Icons.work_outline_sharp,
                              ),

                            if (datauser[i].phone_number.isNotEmpty)
                              About(
                                ontap: null,
                                title: datauser[i].phone_number,
                                icons: Ionicons.phone_portrait,
                              ),

                            if (datauser[i].website.isNotEmpty)
                              About(
                                  title: datauser[i].website,
                                  icons: Ionicons.link_outline,
                                  ontap: () {
                                    UrlGo(datauser[i].website);
                                  }),

                            //social
                            if (Social_Links)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (datauser[i].facebook.isNotEmpty)
                                      SocialMedia(
                                          icons: Icons.facebook,
                                          ontap: () {
                                            UrlGo(
                                                'https://facebook.com/${datauser[i].facebook}');
                                          }),
                                    if (datauser[i].twitter.isNotEmpty)
                                      SocialMedia(
                                          icons: Ionicons.logo_twitter,
                                          ontap: () {
                                            UrlGo(
                                                'https://twitter.com/${datauser[i].twitter}');
                                          }),
                                    if (datauser[i].youtube.isNotEmpty)
                                      SocialMedia(
                                          icons: Ionicons.logo_youtube,
                                          ontap: () {
                                            UrlGo(
                                                'https://youtube.com/${datauser[i].youtube}');
                                          }),
                                    if (datauser[i].linkedin.isNotEmpty)
                                      SocialMedia(
                                          icons: Ionicons.logo_linkedin,
                                          ontap: () {
                                            UrlGo(
                                                'https://linkedin.com/${datauser[i].linkedin}');
                                          }),
                                    if (datauser[i].vk.isNotEmpty)
                                      SocialMedia(
                                          icons: Ionicons.logo_vk,
                                          ontap: () {
                                            UrlGo(
                                                'https://facebook.com/${datauser[i].vk}');
                                          }),
                                    if (datauser[i].instgram.isNotEmpty)
                                      SocialMedia(
                                          icons: Ionicons.logo_instagram,
                                          ontap: () {
                                            UrlGo(
                                                'https://instgram.com/${datauser[i].instgram}');
                                          }),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),

              if (postViews == 2)
                // for (var i = 0; i < datauser.length; i++)
                Container(
                  color: Colors.white,
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
                              'Reels:',
                              style: SafeGoogleFont(Fonts.font3,
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: Get.height * 0.25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: Get.height * 0.25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: Get.height * 0.25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (postViews == 3)
                // for (var i = 0; i < datauser.length; i++)
                Container(
                  color: Colors.white,
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
                              'Followers:',
                              style: SafeGoogleFont(Fonts.font3,
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GridView.count(crossAxisCount: 3, children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: Get.height * 0.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    'https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnTapFoloow extends StatefulWidget {
  const OnTapFoloow({
    required this.confirm_followers,
    required this.can_follow,
    required this.is_following,
    required this.message_privacy,
    required this.user_id,
    Key? key,
  }) : super(key: key);
  final is_following;
  final can_follow;
  final confirm_followers;
  final message_privacy;
  final user_id;
  @override
  State<OnTapFoloow> createState() => _OnTapFoloowState();
}

class _OnTapFoloowState extends State<OnTapFoloow> {
  @override
  late String fowllow;

  void initState() {
    setState(() {
      if (widget.is_following == 0) fowllow = 'Fowllow';
      if (widget.is_following == 1) fowllow = 'Following';
      if (widget.is_following == 2) fowllow = 'Requested'.toString();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (fowllow == 'Requested') {
            ApiFollowUser.folow(widget.user_id);
            fowllow = 'Fowllow';
          } else if (fowllow == 'Fowllow') {
            widget.confirm_followers == '1'
                ? fowllow = 'Requested'
                : fowllow = 'Following';
            ApiFollowUser.folow(widget.user_id);
          } else if (fowllow == 'Following') {
            fowllow = 'Fowllow';
            ApiFollowUser.folow(widget.user_id);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: Get.width * 0.75,
        // height: Get.height * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            color: Get.isDarkMode
                ? fowllow == 'Fowllow'
                    ? ColorTheme
                    : Colors.blue
                : fowllow == 'Fowllow'
                    ? ColorTheme
                    : Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(SvgImages.SavePost),
            // SizedBox(
            //   width: Get.width * 0.01,
            // ),
            Text(widget.can_follow == 1 ? fowllow.tr : 'can\'t follow up'.tr,
                style: SafeGoogleFont(Fonts.font2,
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class OnTapFrind extends StatefulWidget {
  const OnTapFrind({
    required this.confirm_followers,
    required this.can_follow,
    required this.is_following,
    required this.message_privacy,
    required this.user_id,
    Key? key,
  }) : super(key: key);
  final is_following;
  final can_follow;
  final confirm_followers;
  final message_privacy;
  final user_id;
  @override
  State<OnTapFrind> createState() => _OnTapFrindState();
}

class _OnTapFrindState extends State<OnTapFrind> {
  @override
  late String fowllow;

  void initState() {
    setState(() {
      if (widget.is_following == 0) fowllow = 'Add Friend';
      if (widget.is_following == 1) fowllow = 'Friend';
      if (widget.is_following == 2) fowllow = 'Requested'.toString();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (fowllow == 'Requested') {
            ApiFollowUser.folow(widget.user_id);
            fowllow = 'Add Friend';
          } else if (fowllow == 'Add Friend') {
            widget.confirm_followers == '1'
                ? fowllow = 'Friend'
                : fowllow = 'Requested';
            ApiFollowUser.folow(widget.user_id);
          } else if (fowllow == 'Friend') {
            fowllow = 'Add Friend';
            ApiFollowUser.folow(widget.user_id);
          }
        });
      },
      child: Container(
        width: Get.width * 0.75,
        height: Get.height * 0.08,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Get.isDarkMode
                ? fowllow == 'Add Friend'
                    ? ColorTheme
                    : Colors.blue
                : fowllow == 'Add Friend'
                    ? ColorTheme
                    : Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/Add User.svg'),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text(widget.can_follow == 1 ? fowllow.tr : 'can\'t follow up'.tr,
                style: SafeGoogleFont(Fonts.font2,
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
