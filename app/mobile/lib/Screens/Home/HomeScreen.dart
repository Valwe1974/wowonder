import 'package:expandable_menu/expandable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/broadcast_page.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/HomeScreenChat.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/CreateGroupScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Market/CreateProductScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Notification/NotificationScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/CreatePageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/SearchScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/AddStoriesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/MyStoryWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/StoriesScreenView.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/StroyWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/AdsMob/BannerExampleState.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetUserStories.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPromoted.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/NotificationsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserStoriesModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingWidgetStroy.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var lastId = '0';
  bool lodingPosts = false;
  bool lodingPostsMore = false;
  List<PostModel> data = [];
  List<PostModel> boost = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  GetBoost() async {
    ApiPromoted.Getposts().then((value) {
      setState(() {
        boost = value.toList();
      });
    });
  }

  GetPost() async {
    lodingPostsSet();
    GetBoost();
    ApiPosts.Getposts('get_news_feed', '').then((value) {
      print('refresh');
      if (mounted) {
        setState(() {
          data = value.toList();
          if (value.length - 1 == -1 ? false : lastId.isNotEmpty)
            value.length - 1 == -1
                ? ''
                : lastId = value[value.length - 1].post_id;
          if (lastId.isEmpty)
            value.length - 1 == -1
                ? ''
                : lastId = value[value.length - 2].post_id;
          print(lastId);
          // ignore: unnecessary_null_comparison

          lodingPostsSet();
          // make your changes here
        });
      }
    });
  }

  bool post = false;
  var tabIndex = 0;

  void onLoding() async {
    lodingPostsMoreSet();
    var list = await ApiPosts.Getposts(lastId, tabIndex);
    if (list.length - 1 == -1 ? false : lastId.isNotEmpty)
      list.length - 1 == -1 ? '' : lastId = list[list.length - 1].post_id;
    if (lastId.isEmpty)
      list.length - 1 == -1 ? '' : lastId = list[list.length - 2].post_id;
    print(lastId);
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

  void refesh() async {
    setState(() {
      boost.clear();
      data.clear();
    });
    GetStories();
    GetBoost();

    lodingPostsSet();

    ApiPosts.Getposts('get_news_feed', '').then((value) {
      setState(() {
        data = value.toList();
        value.length - 1 == -1 ? '' : lastId = value[value.length - 1].post_id;

        lodingPostsSet();
        _refreshController.refreshCompleted();
      });
    });
  }

  void lodingPostsSet() {
    setState(() {
      lodingPosts = !lodingPosts;
    });
  }

  void lodingPostsMoreSet() {
    setState(() {
      lodingPostsMore = !lodingPostsMore;
    });
  }

  @override
  void initState() {
    Story_Theme_Version;
    print('ThamesVersion ' + Story_Theme_Version.toString());

    soketUp();
    GetPost();
    meassgesCont();
    GetStories();
    Get.put(GetMyUserDataCont());
    Get.put(SettingController());
    SocketNew.onncteSoket();
    norfiCation();
    // opens();
    soketUp();

    super.initState();
  }

  List<GetUserStoriesModel> stor = [];
  bool isLodingStory = true;

  void GetStories() async {
    isLodingStory = await true;
    ApiGetUserStories.getstor().then((value) {
      stor = value.toList();
    });

    if (mounted) {
      setState(() {
        var list = ApiGetUserStories.getstor();
        isLodingStory = false;
      });
    }
  }

  @override
  void dispose() {
    GetStories();
    super.dispose();
  }

  //notfication count
  var notfi;

  void norfiCation() async {
    Newnotifications_count.Notifications().then((value) {
      setState(() {
        notfi = value;
      });
      print('object');
    });
  }

  var count_new_messagesApi2;

  void meassgesCont() async {
    Count_new_messagesApi.Notifications().then((value) {
      setState(() {
        count_new_messagesApi2 = value;
      });
    });
    var list = await Count_new_messagesApi.Notifications();
  }

  // final cont = Get.put(GetMyUserDataCont());
  // opens() {
  //   for (var i = 0; i < cont.data.length; i++) onncteSoket('ameen');
  // }

  void soketUp() {
    SocketNew.socket.on(
        'new_notification',
        (data) async => {
              await Newnotifications_count.Notifications().then((value) {
                setState(() {
                  notfi = value;
                  print(notfi);
                });
              }),
            });
  }

  void AllData() {}

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? ColorDarkBackground
            : Theme.of(context).scaffoldBackgroundColor,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor:
                    Get.isDarkMode ? ColorDarkComponents : Colors.white,
                elevation: 2,
                centerTitle: true,
                pinned: true,
                foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
                title: Row(children: [
                  Image.asset(
                    images.logoApar,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(nameApp,
                      style: SafeGoogleFont(Fonts.font3,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode ? Colors.white : ColorNameApp))
                ]),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Get.isDarkMode
                              ? Color.fromARGB(44, 210, 202, 202)
                              : ColorBackIcons,
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                SearchScreen(),
                              );
                            },
                            child: SvgPicture.asset(
                              Change_Color_Icons
                                  ? ColorSvg.Search
                                  : SvgImages.Search,
                              height: Get.height * 0.02,
                              width: Get.width * 0.02,
                              color: Change_Color_Icons
                                  ? null
                                  : Get.isDarkMode
                                      ? Colors.white
                                      : ColorTheme,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(NotificationScreen());
                            },
                            child: CircleAvatar(
                              backgroundColor: Get.isDarkMode
                                  ? Color.fromARGB(44, 210, 202, 202)
                                  : ColorBackIcons,
                              child: Stack(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      Change_Color_Icons
                                          ? notfi.toString() == '0' ||
                                                  notfi.toString() == 'null'
                                              ? ColorSvg.Null_Notifications
                                              : ColorSvg.NotNull_Notifications
                                          : SvgImages.Notifications,
                                      height: Get.height * 0.02,
                                      width: Get.width * 0.02,
                                      color: Change_Color_Icons
                                          ? null
                                          : Get.isDarkMode
                                              ? Colors.white
                                              : ColorTheme,
                                    ),
                                  ),
                                  notfi.toString() == 'null'
                                      ? SizedBox()
                                      : notfi.toString() == '0'
                                          ? SizedBox()
                                          : Positioned(
                                              right: 3,
                                              top: 5,
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                ],
                              ),
                            )),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.to(ChatScreenGpt());
                            Get.to(HomeScreenChat());
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Get.isDarkMode
                                    ? Color.fromARGB(44, 210, 202, 202)
                                    : ColorBackIcons,
                                child: SvgPicture.asset(
                                  Change_Color_Icons
                                      ? ColorSvg.Messenger
                                      : SvgImages.Message,
                                  height: Get.height * 0.02,
                                  width: Get.width * 0.02,
                                  color: Change_Color_Icons
                                      ? null
                                      : Get.isDarkMode
                                          ? Colors.white
                                          : ColorTheme,
                                ),
                              ),
                              count_new_messagesApi2.toString() == 'null'
                                  ? SizedBox()
                                  : count_new_messagesApi2.toString() == '0'
                                      ? SizedBox()
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              count_new_messagesApi2.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color:
                          Get.isDarkMode ? ColorDarkComponents : Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: Get.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GetBuilder<GetMyUserDataCont>(
                                init: GetMyUserDataCont(),
                                builder: ((cont) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          for (var i = 0;
                                              i < cont.data.length;
                                              i++)
                                            InkWell(
                                              onTap: () {
                                                Get.bottomSheet(
                                                    AddStoriesScreen()); // Get.to(StoryPage());
                                              },
                                              child: Column(
                                                children: [
                                                  if (Story_Theme_Version == 1)
                                                    MyStoryWidget(
                                                      name: cont.data[i].name,
                                                      images:
                                                          cont.data[i].avatar,
                                                    ),
                                                  if (Story_Theme_Version == 2)
                                                    MyStoryWidgetv2(
                                                      name: cont.data[i].name,
                                                      images:
                                                          cont.data[i].avatar,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          isLodingStory
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    for (var i = 0; i < 10; i++)
                                                      LodingWidgetStorye(),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    for (var i = 0;
                                                        i < stor.length;
                                                        i++)
                                                      InkWell(
                                                        onTap: () {
                                                          Get.to(StoriesScreenView(
                                                              user_id: stor[
                                                                      stor.length -
                                                                          1]
                                                                  .user_id,
                                                              stior: stor,
                                                              i: i));
                                                        },
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Column(
                                                              children: [
                                                                if (Story_Theme_Version ==
                                                                    1)
                                                                  StroyWidget(
                                                                    avatir: stor[
                                                                            i]
                                                                        .avatar,
                                                                    images: stor[
                                                                            i]
                                                                        .stories,
                                                                    name: stor[
                                                                            i]
                                                                        .name,
                                                                  ),
                                                                if (Story_Theme_Version ==
                                                                    2)
                                                                  StroyWidgetv2(
                                                                    avatir: stor[
                                                                            i]
                                                                        .avatar,
                                                                    images: stor[
                                                                            i]
                                                                        .stories,
                                                                    name: stor[
                                                                            i]
                                                                        .name,
                                                                  ),
                                                              ],
                                                            )),
                                                      ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Divider(),
                //// add posts//
                ///

                // WidgetAddPost(),
                // Divider(),

                ///posts
                ///
                ///
                if (Active_AdmobBanner) BannerExample(),
                for (var i = 0; i < boost.length; i++)
                  if (boost[i].avatar.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.05,
                                ),
                                SvgPicture.asset(
                                  SvgImages.Promoted,
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  'Promoted',
                                  style: SafeGoogleFont(Fonts.font1,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                WidgetPosts(
                                  blur: boost[i].blur,
                                  color_id: boost[i].color_id,
                                  stream_name: boost[i].stream_name,
                                  pro_type: boost[i].pro_type,
                                  is_pro: boost[i].is_pro,
                                  headline: boost[i].headline,
                                  Boosted: false,
                                  yout: boost[i].postYoutube,
                                  shared_info: boost[i].shared_info,
                                  url_post: boost[i].urlsss,
                                  trueflasecommet: boost[i].comments_status,
                                  event: boost[i].event,
                                  product_id: boost[i].product_id,
                                  product: boost[i].product,
                                  more: Container(
                                      child: IconButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              WidgetMorePosts(
                                                url_post: boost[i].urlsss,
                                                refreshPost: () {
                                                  GetPost();
                                                },
                                                postText: boost[i].postText,
                                                pos: boost[i].post_id,
                                                hidePost: () {
                                                  setState(() {
                                                    boost.removeAt(i);
                                                  });
                                                },
                                                remove: () {
                                                  QuickAlert.show(
                                                    onConfirmBtnTap: () {
                                                      PostActionsApi.reaction(
                                                              boost[i].post_id,
                                                              'delete')
                                                          .asStream();
                                                      setState(() {
                                                        data.removeAt(i);
                                                      });

                                                      Get.back();
                                                      Get.back();
                                                    },
                                                    context: context,
                                                    type:
                                                        QuickAlertType.confirm,
                                                    text:
                                                        'Do you want to delete the post',
                                                    confirmBtnText: 'Yes',
                                                    cancelBtnText: 'No',
                                                    confirmBtnColor: Colors.red,
                                                  );
                                                },
                                                adminPost: boost[i].admin,
                                                avat: boost[i].avatar,
                                                name: boost[i].name,
                                                user_id: boost[i].user_id,
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.more_vert))),
                                  user_id: boost[i].user_id,
                                  reomvePost: () {
                                    setState(() {
                                      boost.removeAt(i);
                                    });
                                  },
                                  data: boost,
                                  adminPost: boost[i].admin,
                                  iint: i,
                                  imReaction: boost[i].type,
                                  reaction: boost[i].reaction,
                                  post_id: boost[i].post_id,
                                  postType: boost[i].postType,
                                  verified: boost[i].verified,
                                  postFeeling: boost[i].postFeeling,
                                  time: boost[i].post_time,
                                  name: boost[i].name,
                                  avat: boost[i].avatar,
                                  postText: boost[i].postText,
                                  postFile: boost[i].postFile,
                                  p1080p: boost[i].p1080,
                                  p2048p: boost[i].p2048,
                                  p240p: boost[i].p240,
                                  p360p: boost[i].p360,
                                  p4096p: boost[i].p4096,
                                  p480p: boost[i].p480,
                                  p720p: boost[i].p720,
                                  options: boost[i].options,
                                  postRecord: boost[i].postRecord,
                                  contLike: boost[i].reaction,
                                  contcoment: int.parse(data[i].post_comments),
                                  islike: boost[i].reaction1,
                                  photoMulti2: boost[i].photoMulti2,
                                  photo_album: boost[i].photo_album,
                                  postimage: boost[i].postFile,
                                  type: boost[i].type,
                                  page_id: boost[i].page_id,
                                  group_id: boost[i].group_id,
                                  avatar_group: boost[i].avatargroupe,
                                  name_group: boost[i].group_title,
                                  cover: boost[i].cover,
                                  comment_cont: boost[i].comments_status,
                                  ad_media: boost[i].ad_media,
                                  biddingAds: boost[i].biddingAds,
                                  descriptionAds: boost[i].descriptionAds,
                                  nameAds: boost[i].nameAds,
                                  user_dataAds: boost[i].user_dataAds,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                lodingPosts
                    ? LodingPostsWidget(
                        len: 5,
                      )
                    : Column(
                        children: [
                          for (var i = 0; i < data.length; i++)
                            Column(
                              children: [
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
                                                  GetPost();
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
                                                      setState(() {
                                                        data.removeAt(i);
                                                      });

                                                      Get.back();
                                                      Get.back();
                                                    },
                                                    context: context,
                                                    type:
                                                        QuickAlertType.confirm,
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
                                  user_id: data[i].user_id,
                                  reomvePost: () {
                                    setState(() {
                                      data.removeAt(i);
                                    });
                                  },
                                  data: data,
                                  adminPost: data[i].admin,
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
                                  name_group: data[i].group_title,
                                  cover: data[i].cover,
                                  comment_cont: data[i].comments_status,
                                ),
                              ],
                            ),
                        ],
                      ),
                if (lodingPostsMore)
                  LodingPostsWidget(
                    len: 2,
                  ),
              ]),
            ),
          ),
        ));
  }
}

class AddHomeScreen extends StatelessWidget {
  const AddHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get.to(CreatePostScreen());
    Future<void> onJoin({required bool isBroadcaster}) async {
      await [Permission.camera, Permission.microphone].request();
      var uuid = Uuid();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BroadcastPage(
            isBroadcaster: isBroadcaster,
            channelName: uuid.v4().toString(),
            token: null,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(10),
      height: Get.height * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  // Divider(),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 12,
                        child: InkWell(
                          onTap: () {
                            onJoin(isBroadcaster: true);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : ColorBackIcons,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.CreateLive,
                                  width: 22,
                                  height: 22,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  'Create a live broadcast'.tr,
                                  style: SafeGoogleFont(
                                    Fonts.font1,
                                    fontSize: 13,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(CreateProductScreen());
                  //   },
                  //   child: add('Create a new product'.tr, 6),
                  // ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            Get.to(CreatePostScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : ColorBackIcons,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.CreatePost,
                                  width: 20,
                                  height: 20,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  'Create a post'.tr,
                                  style: SafeGoogleFont(
                                    Fonts.font1,
                                    fontSize: 13,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            Get.to(CreateProductScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : ColorBackIcons,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.CreateGroup,
                                  width: 20,
                                  height: 20,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  'Create a new product'.tr,
                                  style: SafeGoogleFont(
                                    Fonts.font1,
                                    fontSize: 13,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            Get.to(CreateGroupScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : ColorBackIcons,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.CreateGroup,
                                  width: 20,
                                  height: 20,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  'Create a new group'.tr,
                                  style: SafeGoogleFont(
                                    Fonts.font1,
                                    fontSize: 13,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () {
                            Get.to(CreatePageScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : ColorBackIcons,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.CreatePost,
                                  width: 20,
                                  height: 20,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text(
                                  'Create a new Page'.tr,
                                  style: SafeGoogleFont(
                                    Fonts.font1,
                                    fontSize: 13,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // InkWell(
                  //   onTap: () {
                  //     Get.to(CreateGroupScreen());
                  //   },
                  //   child: add('Create a new group'.tr, 6),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(CreatePageScreen());
                  //   },
                  //   child: add('Create a new Page'.tr, 6),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     onJoin(isBroadcaster: true);
                  //   },
                  //   child: add('Create a live broadcast'.tr, 6),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget add(title) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Container(
            width: Get.width,
            child: Text(
              title,
              style: SafeGoogleFont(Fonts.font1,
                  fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
