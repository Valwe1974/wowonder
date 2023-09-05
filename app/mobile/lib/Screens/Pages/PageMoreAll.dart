import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetMyPage.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class PageMoreAll extends StatefulWidget {
  const PageMoreAll({super.key});

  @override
  State<PageMoreAll> createState() => _PageMoreAllState();
}

class _PageMoreAllState extends State<PageMoreAll> {
  String lastId = '0';
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<GetPagesDataModel> mypage = [];
  void getData() async {
    ApiGetMyPage.mypage().then((value) {
      setState(() {
        mypage = value.toList();
      });
    });
  }

  List<GetPagesDataModel> page = [];
  void getDataPage() async {
    ApiGetAllMyPage.mypage(
      '0',
    ).then((value) {
      setState(() {
        mypage = value.toList();
        lastId = value[value.length - 1].page_id;
      });
    });
  }

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await ApiGetAllMyPage.mypage('0');

    // print('onLoding');
    // print(lastId);
    // print(list.length - 1);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].page_id;

    // if (list.length - 1 == -1) {
    //   post = true;
    // } else {
    //   post = false;
    // }
    setState(() {
      refreshController.loadComplete();
      lastId == null ? dispose() : page.addAll(list);
    });
  }

  void onRefresh() async {
    var list = await ApiGetAllMyPage.mypage(
      '0',
    );

    setState(() {
      page.clear();
      page.addAll(list.toList());

      refreshController.refreshCompleted();

      lastId = page[page.length - 1].page_id;
    });
  }

  @override
  void initState() {
    getData();
    getDataPage();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        elevation: 0,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //my Pages

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Pages'.tr,
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Divider(),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (var i = 0; i < mypage.length; i++)
                        InkWell(
                          onTap: () {
                            Get.to(HomePagesScreen(page_id: mypage[i].page_id));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: (BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 2)
                                      ],
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              mypage[i].avatar)),
                                      borderRadius: BorderRadius.circular(20))),
                                  width: Get.width * 0.28,
                                  height: Get.height * 0.14,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(mypage[i].page_title)
                              ],
                            ),
                          ),
                        ),
                    ]),
                  )
                ],
              ),
            ),
            //my Page
            //***-------- */

            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pages'.tr,
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
                  children: List.generate(page.length, (index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                                HomePagesScreen(page_id: page[index].page_id));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: Get.height * 0.13,
                              width: Get.width * 0.3,
                              child: CachedNetworkImage(
                                  imageUrl: page[index].avatar,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      CachedNetworkImage(
                                          imageUrl:
                                              'https://talkeyi.com/upload/photos/d-group.jpg')),
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
                            child: Text(page[index].page_title),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
