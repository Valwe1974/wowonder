import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageData.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPagePosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';

class HomePagesScreen extends StatefulWidget {
  HomePagesScreen({super.key, required this.page_id});
  String page_id;

  @override
  State<HomePagesScreen> createState() => _HomePagesScreenState();
}

class _HomePagesScreenState extends State<HomePagesScreen> {
  var lastId = '0';
  bool lodingPosts = false;
  bool lodingPostsMore = false;
  List<PostModel> data = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void GetPost() async {
    lodingPostsSet();

    ApiPagePosts.Getposts('get_news_feed', '', widget.page_id).then((value) {
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
    });
  }

  bool post = false;
  var tabIndex = 0;
  int countLike = 0;
  void onLoding() async {
    lodingPostsMoreSet();
    var list = await ApiPagePosts.Getposts(lastId, tabIndex, widget.page_id);

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

  void refesh() async {
    setState(() {
      data.clear();
    });

    lodingPostsSet();
    GetDataPage();
    ApiPagePosts.Getposts('get_news_feed', '', widget.page_id).then((value) {
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

  void lodingPostsSet() {
    setState(() {
      lodingPosts = !lodingPosts;
    });
  }

  bool likePage = false;
  @override
  void initState() {
    GetPost();
    GetDataPage();
    super.initState();
  }

  List<GetPagesDataModel> datapage = [];
  void GetDataPage() {
    ApiPageData.postsData(widget.page_id).then((value) {
      setState(() {
        datapage = value.toList();
        likePage = value[value.length - 1].is_liked;
        var myInt = int.parse(value[value.length - 1].likes_count);

        countLike = myInt;
      });
    });
  }

  Future<void> UrlGo(ur) async {
    final Uri _url = Uri.parse(ur);

    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Widget build(BuildContext context) {
    //////
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 0,
      //   foregroundColor: Get.isDarkMode ? Colors.white : ColorThme,
      // ),
      body: SafeArea(
        child: SmartRefresher(
          onRefresh: refesh,
          onLoading: onLoding,
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          child: lodingPosts
              ? LodingPostsWidget(
                  len: 5,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < datapage.length; i++)
                        Container(
                          height: Get.height * 0.35,
                          width: Get.width,
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height * 0.28,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            datapage[i].cover))),
                              ),
                              Positioned(
                                bottom: 0,
                                left: Get.width * 0.01,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 57,
                                      backgroundColor: ColorTheme,
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        maxRadius: 55,
                                        child: CircleAvatar(
                                          maxRadius: 53,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  datapage[i].avatar),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.90,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            datapage[i].page_title,
                                            style: SafeGoogleFont(Fonts.font1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          if (datapage[i].verified == '1')
                                            Icon(Icons.verified,
                                                size: 14, color: ColorTheme),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(93, 0, 0, 0),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(Icons.arrow_back_ios)),
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(93, 0, 0, 0),
                                      child: IconButton(
                                          color: Colors.white,
                                          splashRadius: 10,
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(Icons.more_horiz)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: Get.height * 0.05,
                        child: Divider(),
                      ),
                      for (var i = 0; i < datapage.length; i++)
                        if (datapage[i].is_page_onwer)
                          Container(
                            width: Get.width * 0.30,
                            decoration: BoxDecoration(
                              color: ColorTheme,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                'Edite Page'.tr,
                                style: SafeGoogleFont(Fonts.font1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17),
                              )),
                            ),
                          ),
                      for (var i = 0; i < datapage.length; i++)
                        if (datapage[0].is_page_onwer == false)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        likePage = !likePage;
                                        for (var i = 0;
                                            i < datapage.length;
                                            i++)
                                          if (likePage) {
                                            countLike++;
                                          } else {
                                            countLike--;
                                          }
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: Get.width * 0.30,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: ColorTheme,
                                                blurRadius: 1,
                                                spreadRadius: 1),
                                          ],
                                          color: likePage
                                              ? ColorTheme
                                              : Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text(
                                            likePage ? 'Liked'.tr : 'Like'.tr,
                                            style: SafeGoogleFont(Fonts.font1,
                                                fontWeight: FontWeight.bold,
                                                color: likePage
                                                    ? Colors.white
                                                    : null,
                                                fontSize: 17),
                                          )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: Get.width * 0.30,
                                      decoration: BoxDecoration(
                                        color: ColorTheme,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          'Messages'.tr,
                                          style: SafeGoogleFont(Fonts.font1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 17),
                                        )),
                                      ),
                                    ),
                                    for (var i = 0; i < datapage.length; i++)
                                      if (datapage[i]
                                          .call_action_type_text
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () async {
                                            if (datapage[i]
                                                .call_action_type_url
                                                .isNotEmpty) {
                                              UrlGo(datapage[i]
                                                  .call_action_type_url);
                                            }
                                            //         ..onTap = () async {
                                          },
                                          child: Container(
                                            width: Get.width * 0.30,
                                            decoration: BoxDecoration(
                                              color: ColorTheme,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Text(
                                                datapage[i]
                                                    .call_action_type_text,
                                                style: SafeGoogleFont(
                                                    Fonts.font1,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              )),
                                            ),
                                          ),
                                        ),
                                  ]),
                            ),
                          ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Divider(),
                      for (var i = 0; i < datapage.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About'.tr,
                                      style: SafeGoogleFont(Fonts.font3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(datapage[i].about)
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Divider(),
                                if (datapage[i].phone.isNotEmpty)
                                  About(
                                    ontap: null,
                                    title: datapage[i].phone,
                                    icons: Ionicons.phone_portrait,
                                  ),

                                About(
                                  ontap: null,
                                  title: countLike.toString(),
                                  icons: Icons.thumb_up,
                                ),
                                if (datapage[i].website.isNotEmpty)
                                  About(
                                      title: datapage[i].website,
                                      icons: Ionicons.link_outline,
                                      ontap: () {
                                        UrlGo(datapage[i].website);
                                      }),
                                if (datapage[i].address.isNotEmpty)
                                  About(
                                      ontap: null,
                                      title: datapage[i].address,
                                      icons: Ionicons.location),
                                if (datapage[i].category.isNotEmpty)
                                  About(
                                    ontap: null,
                                    title: datapage[i].category,
                                    icons: Icons.category_outlined,
                                  ),
                                About(
                                  ontap: null,
                                  title: 'Invite friends to like this Page'.tr,
                                  icons: Icons.add_box_sharp,
                                ),

                                //social
                                if (Social_Links)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (datapage[i].facebook.isNotEmpty)
                                          SocialMedia(
                                              ontap: () {
                                                UrlGo(
                                                    'https://facebook.com/${datapage[i].facebook}');
                                              },
                                              icons: Icons.facebook),
                                        if (datapage[i].linkedin.isNotEmpty)
                                          SocialMedia(
                                              icons: Ionicons.logo_twitter,
                                              ontap: () {
                                                UrlGo(datapage[i].twitter);
                                              }),
                                        if (datapage[i].youtube.isNotEmpty)
                                          SocialMedia(
                                              icons: Ionicons.logo_youtube,
                                              ontap: () {
                                                UrlGo(datapage[i].youtube);
                                              }),
                                        if (datapage[i].linkedin.isNotEmpty)
                                          SocialMedia(
                                              icons: Ionicons.logo_linkedin,
                                              ontap: () {
                                                UrlGo(datapage[i].linkedin);
                                              }),
                                        if (datapage[i].vk.isNotEmpty)
                                          SocialMedia(
                                              icons: Ionicons.logo_vk,
                                              ontap: () {
                                                UrlGo(datapage[i].vk);
                                              }),
                                        if (datapage[i].linkedin.isNotEmpty)
                                          SocialMedia(
                                              icons: Ionicons.logo_instagram,
                                              ontap: () {
                                                UrlGo(datapage[i].instgram);
                                              }),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        width: Get.width,
                        height: 2,
                        color: Get.isDarkMode ? Colors.black : Colors.white,
                      ),
                      for (var i = 0; i < datapage.length; i++)
                        if (datapage[i].users_post == '1')
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                    103,
                                    158,
                                    158,
                                    158,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(CreatePostScreen(),
                                          arguments: ({
                                            'page_id': widget.page_id
                                          }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        children: [
                                          GetBuilder<GetMyUserDataCont>(
                                              init: GetMyUserDataCont(),
                                              builder: ((controller) => Row(
                                                    children: [
                                                      for (var i = 0;
                                                          i <
                                                              controller
                                                                  .data.length;
                                                          i++)
                                                        CircleAvatar(
                                                          maxRadius: 15,
                                                          backgroundImage:
                                                              CachedNetworkImageProvider(
                                                                  controller
                                                                      .data[i]
                                                                      .avatar
                                                                      .replaceAll(
                                                                          ' ',
                                                                          '')),
                                                        ),
                                                      SizedBox(),
                                                      Text(
                                                        'Write your post here ?'
                                                            .tr,
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Image.asset(
                                      'assets/images/smile.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      Divider(),
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
                                        headline: data[i].headline,
                                        Boosted: false,
                                        yout: data[i].postYoutube,
                                        trueflasecommet:
                                            data[i].comments_status,
                                        event: data[i].event,
                                        product_id: data[i].product_id,
                                        product: data[i].product,
                                        more: Container(
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.bottomSheet(
                                                    WidgetMorePosts(
                                                      url_post:
                                                          data[i].postLink,
                                                      refreshPost: () {
                                                        GetPost();
                                                      },
                                                      postText:
                                                          data[i].postText,
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
                                                            setState(() {
                                                              data.removeAt(i);
                                                            });

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
                                                          cancelBtnText:
                                                              'No'.tr,
                                                          confirmBtnColor:
                                                              Colors.red,
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
                                        shared_info: data[i].shared_info,
                                        p1080p: data[i].p1080,
                                        p2048p: data[i].p2048,
                                        p240p: data[i].p240,
                                        p360p: data[i].p360,
                                        p4096p: data[i].p4096,
                                        p480p: data[i].p480,
                                        p720p: data[i].p720,
                                        pro_type: data[i].pro_type,
                                        is_pro: data[i].is_pro,
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
                                        name_group: data[i].group_title,
                                        cover: data[i].cover,
                                        comment_cont: data[i].comments_status,
                                        url_post: data[i].urlsss,
                                        ad_media: data[i].ad_media,
                                        biddingAds: data[i].biddingAds,
                                        descriptionAds: data[i].descriptionAds,
                                        nameAds: data[i].nameAds,
                                        user_dataAds: data[i].user_dataAds,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                              ],
                            ),
                      if (lodingPostsMore)
                        LodingPostsWidget(
                          len: 2,
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({
    this.title,
    required this.icons,
    required this.ontap,
    super.key,
  });
  final String? title;
  final icons;
  final ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (ontap != null) ontap();
      },
      child: Container(
        // width: 100,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      // color: ColorTheme,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    icons,
                    color: ColorTheme,
                    size: 18,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.015,
                ),
                if (title != null)
                  Expanded(
                      child: Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                    softWrap: true,
                    style: SafeGoogleFont(
                      Fonts.font1,
                      fontSize: 15,
                    ),
                  ))
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    this.title,
    required this.icons,
    required this.ontap,
    super.key,
  });
  final String? title;
  final icons;
  final ontap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        if (ontap != null) ontap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: ColorTheme, borderRadius: BorderRadius.circular(50)),
        child: Icon(
          icons,
          color: Colors.white,
          size: 18,
        ),
      ),
    ));
  }
}
