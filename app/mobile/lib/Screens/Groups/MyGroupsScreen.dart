import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/GroupsScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetMyGroups.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetGroupDataModel.dart';
import 'package:wowondertimelineflutterapp/main.dart';

import '../../ThemesWoWonder.dart';

class MyGroupsScreen extends StatefulWidget {
  const MyGroupsScreen({super.key});

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  @override
  void initState() {
    GetGroupsMy();
    joind();
    super.initState();
  }

  String? lastId;
  @override
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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await Joined.getgroups('joined_groups', lastId!);

    // print('onLoding');
    // print(lastId);
    // print(list.length - 1);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].id;

    // if (list.length - 1 == -1) {
    //   post = true;
    // } else {
    //   post = false;
    // }
    setState(() {
      refreshController.loadComplete();
      lastId == null ? dispose() : joindgroup.addAll(list);
    });
  }

  void onRefresh() async {
    var list = await await Joined.getgroups('joined_groups', '0');

    setState(() {
      joindgroup.clear();
      joindgroup.addAll(list.toList());

      refreshController.refreshCompleted();

      lastId = joindgroup[joindgroup.length - 1].id;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Groups'.tr,
          ),
          centerTitle: true,
          elevation: 1,backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'My Groups'.tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Card(
              child: Container(
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      for (var i = 0; i < mygroups.length; i++)
                        InkWell(
                          onTap: () {
                            Get.to(GroupsScreen(group_id: mygroups[i].id));
                          },
                          child: _WidgetMyGroups(
                            namegroup: mygroups[i].group_title,
                            // imagess:
                            //     'https://talkeyi.com/upload/photos/d-group.jpg',
                            imagess: mygroups[i].avatar,
                          ),
                        ),
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Groups'.tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              height: Get.height * 0.55,
              width: Get.width,
              child: SmartRefresher(
                controller: refreshController,
                onLoading: onLoding,
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: onRefresh,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(joindgroup.length, (index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                                GroupsScreen(group_id: joindgroup[index].id));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: Get.height * 0.13,
                              width: Get.width * 0.3,
                              child: CachedNetworkImage(
                                  imageUrl: joindgroup[index].avatar,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      CachedNetworkImage(
                                          imageUrl:
                                              '${accounts[0]['url']}upload/photos/d-group.jpg')),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Color.fromARGB(34, 255, 255, 255)
                                  : Color.fromARGB(35, 0, 0, 0),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(joindgroup[index].group_title),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}

class _WidgetMyGroups extends StatelessWidget {
  _WidgetMyGroups({
    required this.imagess,
    required this.namegroup,
    super.key,
  });
  String imagess;
  String namegroup;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(),
                height: Get.height * 0.13,
                width: Get.width * 0.3,
                child: Image.network(
                  imagess.replaceAll(' ', ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(12, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  namegroup,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: Get.width * 0.02,
        )
      ],
    );
  }
}
