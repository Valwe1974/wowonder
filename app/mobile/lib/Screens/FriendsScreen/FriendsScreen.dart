import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFollowUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/FriendsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';

import '../../ThemesWoWonder.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<GetAllFrindsModel> data = [];
  TextEditingController controller = new TextEditingController();
  String userid = '0';
  GetAllFrind() async {
    FriendsApi.allFrinds('', '', userid).then((ameen) {
      setState(() {
        data = ameen.toList();

        userid = data[data.length - 1].user_id;
      });
    });
  }

  @override
  void initState() {
    GetAllFrind();
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   foregroundColor:
      //       Get.isDarkMode ? colorTextBordingDark1 : colorTextBordingLighet1,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
      body: Container(
        color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        margin: EdgeInsets.only(top: Get.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),

            ///TapBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(89, 214, 211, 211),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ), SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(

                              width: Get.width - 120,
                              child: TextField(
                                controller: controller,
                                // onChanged: onSearchTextChanged,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search For Friends...'.tr,
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                'Friends'.tr,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ///tapBar
            Container(
              height: Get.height - 200,
              width: Get.width,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  // Get.toNamed(Routes.profileUserScreen,
                                  //     arguments: ({
                                  //       'user_id': data[i].user_id,
                                  //       'avatar': data[i].avatar,
                                  //     }));
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              data[i].avatar),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: Get.width * 0.60,
                                            child: Text(
                                              data[i].name,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                              maxLines: 1,
                                            ),
                                          ),
                                          Text(
                                            data[i].friends_count.toString() +
                                                'mutual frinds'.tr,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  print('More');
                                },
                                child: InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                        height: Get.height * 0.3,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.04,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/group_uszi7a40l1if.svg',
                                                        color: Get.isDarkMode
                                                            ? ColorsTextCommentsDark
                                                            : ColorsTextCommentsLight,
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Text(
                                                        'Report a comment'.tr,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.03,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // Get.to(ScreenChatUser(
                                                      //     username:
                                                      //         data[i].user_id,
                                                      //     avat: data[i].avatar,
                                                      //     name: data[i].name,
                                                      //     userid:
                                                      //         data[i].user_id));
                                                      print('chat');
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/images/svg/send_message_flvpeit0ht4l.svg',
                                                          color: Get.isDarkMode
                                                              ? ColorsTextCommentsDark
                                                              : ColorsTextCommentsLight,
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Text(
                                                          'Message to${data[i].name}'
                                                              .tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.03,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      data.removeAt(i);
                                                      ApiFollowUser.folow(
                                                          data[i].user_id);
                                                      Get.back();

                                                      setState(() {});
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/images/svg/unfollow_46hcwd4krgp5.svg',
                                                          color: Get.isDarkMode
                                                              ? ColorsTextCommentsDark
                                                              : ColorsTextCommentsLight,
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.01,
                                                        ),
                                                        Text(
                                                          'Unfollow'.tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/svg/block_friend_tm216oukw7zr.svg',
                                                        color: Get.isDarkMode
                                                            ? ColorsTextCommentsDark
                                                            : ColorsTextCommentsLight,
                                                        height: 27,
                                                        width: 27,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      Text(
                                                        'Block'.tr,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.03,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [Icon(Icons.more_horiz)],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
