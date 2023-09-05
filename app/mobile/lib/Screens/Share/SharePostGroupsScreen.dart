import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetMyGroups.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiShareOnGroup.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetGroupDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class SharePostGroupsScreen extends StatefulWidget {
  const SharePostGroupsScreen({super.key, required this.post_id});

  final String post_id;
  @override
  State<SharePostGroupsScreen> createState() => _SharePostGroupsScreenState();
}

var lastId = '0';

class _SharePostGroupsScreenState extends State<SharePostGroupsScreen> {
  List<GetGroupDataModel> mygroups = [];

  void GetGroupsMy() async {
    await ApiGetMyGroups.getgroups('my_groups').then((value) {
      setState(() {
        mygroups = value.toList();
      });
    });
  }

  List<GetGroupDataModel> joindgroup = [];

  void joind() async {
    await Joined.getgroups('joined_groups', '0').then((value) {
      setState(() {
        joindgroup = value.toList();
        lastId = value[value.length - 1].id;
      });
    });
  }

  @override
  void initState() {
    GetGroupsMy();
    joind();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      title: 'Share Post'.tr,
      centerTitle: false,
      elevation: 0,
      loding: false,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          for (var i = 0; i < mygroups.length; i++)
            _Group(
              group_id: mygroups[i].id,
              post_id: widget.post_id,
              name: mygroups[i].group_title,
              avat: mygroups[i].avatar,
            ),
          for (var i = 0; i < joindgroup.length; i++)
            _Group(
              group_id: joindgroup[i].id,
              post_id: widget.post_id,
              name: joindgroup[i].group_title,
              avat: joindgroup[i].avatar,
            ),
        ]),
      )),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    required this.group_id,
    required this.post_id,
    required this.name,
    required this.avat,
    super.key,
  });
  final String name;
  final String avat;
  final group_id;
  final String post_id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(avat),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Text(
                    name,
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  ApiShareOnGroup.Shere(
                    'share_post_on_group',
                    post_id,
                    group_id.toString(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorTheme),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Share'.tr,
                      style: SafeGoogleFont(Fonts.font1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Divider()
        ],
      ),
    );
  }
}
