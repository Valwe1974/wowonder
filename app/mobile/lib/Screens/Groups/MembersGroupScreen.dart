import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/WidgetFollowNew.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetGroupMembers.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetMembersGroupModel.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class MembersGroupScreen extends StatefulWidget {
  MembersGroupScreen({required this.group_id, super.key});
  String group_id;

  @override
  State<MembersGroupScreen> createState() => _MembersGroupScreenState();
}

class _MembersGroupScreenState extends State<MembersGroupScreen> {
  List<GetMembersGroupModel> data = [];
  bool moretrue = true;
  String? lastId;
  void getMempers() async {
    await ApiGetGroupMemburs.getdata(widget.group_id, '0').then((value) => {
          setState(() {
            data = value.toList();
            lastId = value[value.length - 1].member_id;
          }),
        });
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  // void onRefresh() async {
  //   data.clear();
  //   // print('onRefresh');
  //   // await Future.delayed(Duration(seconds: 3));
  //   var list = await ApiGetGroupMemburs.getdata(
  //     widget.group_id,
  //     lastId!.isNotEmpty ? '0' : lastId!,
  //   );

  //   ;
  //   setState(() {
  //     data.addAll(list.toList());

  //     refreshController.refreshCompleted();
  //   });

  //   var list2 = await ApiGetGroupMemburs.getdata(widget.group_id, lastId!);
  //   lastId = list2[list2.length - 1].member_id;
  // }

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await ApiGetGroupMemburs.getdata(widget.group_id, lastId!);

    setState(() {
      lastId == null ? dispose() : data.addAll(list);

      refreshController.loadComplete();
      lastId = data[data.length - 1].member_id;
      if (list.toString() == '[]') {
        setState(() {
          moretrue = false;
        });
      }
    });
  }

  @override
  void initState() {
    getMempers();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Members Group'.tr,
      centerTitle: true,
      elevation: 1,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Administrators and supervisors'.tr,
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: ColorTheme),
              ),
            ),
            for (var i = 0; i < data.length; i++)
              if (data[i].admin.toString() == '1')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                imageUrl: data[i].avatar,
                                errorWidget: (context, url, error) {
                                  return Icon(Icons.portable_wifi_off);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[i].name,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Admin'.tr,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz_rounded))
                    ],
                  ),
                ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Members'.tr,
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: ColorTheme),
              ),
            ),
            for (var i = 0; i < data.length; i++)
              if (data[i].admin.toString() == '0')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ProfileUserScreen(
                                  avat: data[i].avatar,
                                  user_id: data[i].user_id,
                                  cover: data[i].user_id,
                                  name: data[i].name));
                            },
                            child: CircleAvatar(
                              radius: 28,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  imageUrl: data[i].avatar,
                                  errorWidget: (context, url, error) {
                                    return Icon(Icons.portable_wifi_off);
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width * 0.5,
                                child: Text(
                                  maxLines: 1,
                                  data[i].name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Text(
                                'Members'.tr,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          if (true)
                            WidgetFollowNew(
                              sizew: 0.20,
                              confirm_followers: data[i].confirm_followers,
                              is_following: data[i].is_following,
                              can_follow: 0,
                              user_id: data[i].user_id,
                              // controller.data[i].user_id;
                            ),
                          // Container(
                          //   width: Get.width * 0.25,
                          //   decoration: BoxDecoration(
                          //       color: colorTextBordingDark1,
                          //       borderRadius: BorderRadius.circular(10)),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Center(
                          //       child: Text(
                          //         'Follow',
                          //         style: GoogleFonts.poppins(
                          //             fontWeight: FontWeight.w600,
                          //             color: Colors.white),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          if (false)
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                        ],
                      )
                    ],
                  ),
                ),
            if (moretrue)
              InkWell(
                onTap: onLoding,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'Show more'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: Get.height * 0.1,
            )
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}
