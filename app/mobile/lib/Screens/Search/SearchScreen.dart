import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/OnePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/ContSearch.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/ContSearchHashTag.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/NoResultsFoundScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/WidgetAccount.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/WidgetHastag.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchCont());
    Get.put(ContSearchHashTag());
    var cont = Get.find<SearchCont>();
    var contSreach = Get.find<ContSearchHashTag>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Search',
          style: SafeGoogleFont(Fonts.font2, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                width: Get.width,
                // height: Get.height * 0.03,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: ColorTheme, spreadRadius: 1)],
                    color: Get.isDarkMode
                        ? backRoundColorSearchDark
                        : backRoundColorSearch,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cont.catog.value)
                        Row(children: [
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(images.SearchIco),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Container(
                              width: Get.width * 0.65,
                              // height: Get.height * 0.08,
                              child: TextField(
                                controller: cont.SerchName,
                                onChanged: (val) {
                                  if (cont.catog.value) {
                                    cont.scrollToCursor(val);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search'.tr,
                                  border: InputBorder.none,
                                ),
                              )),
                        ]),
                      if (cont.catog1.value)
                        Row(children: [
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(images.SearchIco),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Container(
                              width: Get.width * 0.65,
                              height: Get.height * 0.08,
                              child: TextField(
                                controller: cont.SerchName,
                                onChanged: (val) {
                                  if (cont.catog.value) {
                                    cont.scrollToCursor(val);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search'.tr,
                                  border: InputBorder.none,
                                ),
                              )),
                          if (cont.SerchName.text.isNotEmpty)
                            IconButton(
                                onPressed: () {
                                  cont.deleteData();
                                },
                                icon: Icon(Icons.cancel,
                                    color: Get.isDarkMode
                                        ? backRoundColorSearch
                                        : ColorTheme)),
                        ]),
                      if (cont.catog4.value)
                        Row(children: [
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Image.asset(images.SearchIco),
                          SizedBox(
                            width: Get.width * 0.01,
                          ),
                          Container(
                              width: Get.width * 0.65,
                              child: TextField(
                                controller: contSreach.SerchName,
                                onChanged: (val) {
                                  if (contSreach.catog.value) {
                                    contSreach.scrollToCursor(val);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search'.tr,
                                  border: InputBorder.none,
                                ),
                              )),
                          if (contSreach.SerchName.text.isNotEmpty)
                            IconButton(
                                onPressed: () {
                                  contSreach.deleteData();
                                },
                                icon: Icon(Icons.cancel,
                                    color: Get.isDarkMode
                                        ? backRoundColorSearch
                                        : ColorTheme)),
                        ]),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        cont.catog.value = true;
                        cont.catog1.value = false;
                        cont.catog2.value = false;
                        cont.catog4.value = false;
                      },
                      child: _WidgetSearchCatgor(
                        cato: cont.catog.value,
                        name: 'Account'.tr,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cont.catog.value = false;
                        cont.catog1.value = true;
                        cont.catog2.value = false;
                        cont.catog4.value = false;
                      },
                      child: _WidgetSearchCatgor(
                        name: 'Groups'.tr,
                        cato: cont.catog1.value,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cont.catog.value = false;
                        cont.catog1.value = false;
                        cont.catog2.value = true;
                        cont.catog4.value = false;
                      },
                      child: _WidgetSearchCatgor(
                        name: 'Pages'.tr,
                        cato: cont.catog2.value,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cont.catog.value = false;

                        cont.catog1.value = false;
                        cont.catog2.value = false;
                        cont.catog4.value = true;
                      },
                      child: _WidgetSearchCatgor(
                        name: 'HashTag',
                        cato: cont.catog4.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (cont.catog.value)
              Container(
                width: Get.width,
                height: Get.height * 0.56,
                child: SmartRefresher(
                  onLoading: cont.moreFrind,
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: cont.refreshController,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < cont.data.length; i++)
                          InkWell(
                            onTap: () {
                              Get.to(ProfileUserScreen(
                                user_id: cont.data[i].user_id,
                                avat: cont.data[i].avatar,
                                name: cont.data[i].name,
                                cover: cont.data[i].cover,
                              ));
                            },
                            child: WidgetAccount(
                              name: cont.data[i].name,
                              username: cont.data[i].username,
                              verified: cont.data[i].verified,
                              image: cont.data[i].avatar,
                            ),
                          ),
                        if (cont.data.length.toString() == '0')
                          NoResultsFoundScreen(),
                      ],
                    ),
                  ),
                ),
              ),
            if (cont.catog1.value)
              Container(
                width: Get.width,
                height: Get.height * 0.56,
                child: SmartRefresher(
                  onLoading: cont.moreFrind,
                  enablePullDown: false,
                  enablePullUp: true,
                  controller: cont.refreshController,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WidgetAccount(
                          name: 'ameen',
                          username: 'ameen',
                          verified: '1',
                          image: '',
                        ),
                        if (cont.data.length.toString() == '0')
                          NoResultsFoundScreen(),
                      ],
                    ),
                  ),
                ),
              ),
            if (cont.catog4.value)
              Obx(
                () => Column(
                  children: [
                    if (contSreach.data.length.toString() == '0')
                      NoResultsFoundScreen(),
                    for (var i = 0; i < contSreach.data.length; i++)
                      InkWell(
                        onTap: () {
                          Get.to(OnePostScreenGo(
                            post_id: contSreach.data[i].post_id,
                            title: 'HashTag ${contSreach.SerchName.text}',
                          ));
                        },
                        child: WigsetHastag(
                          name: contSreach.SerchName.text,
                          conut: contSreach.data[i].postText,
                        ),
                      ),
                  ],
                ),
              ),
            if (cont.catog2.value) NoResultsFoundScreen(),
          ],
        ),
      ),
    );
  }
}

class _WidgetSearchCatgor extends StatelessWidget {
  _WidgetSearchCatgor({
    required this.name,
    required this.cato,
    super.key,
  });
  bool cato;
  String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 1)],
            color:
                cato ? ColorTheme : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            name,
            style: SafeGoogleFont(Fonts.font1,
                color: cato ? Colors.white : ColorTheme,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
