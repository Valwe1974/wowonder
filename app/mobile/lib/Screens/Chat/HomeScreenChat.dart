import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/ChatsHomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GroupsChatScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/PagesChatScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class HomeScreenChat extends StatefulWidget {
  const HomeScreenChat({super.key});

  @override
  State<HomeScreenChat> createState() => _HomeScreenChatState();
}

class _HomeScreenChatState extends State<HomeScreenChat> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 4,
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   elevation: 0,
        //   hoverElevation: 0,
        //   focusElevation: 0,
        //   highlightElevation: 0,
        //   disabledElevation: 0,
        //   tooltip: 'Add'.tr,

        //   // shape:
        //   //     BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
        //   splashColor: ColorThme,
        //   backgroundColor: Get.isDarkMode ? ColorThme : ColorThme,
        //   onPressed: () {
        //     // changePageTo(3);
        //   },
        //   child: Icon(Icons.add),
        // ),
        bottomNavigationBar: Container(
          height: Get.height * 0.07,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.black : Colors.white,
          ),
          child: TabBar(
              indicatorColor: Get.isDarkMode ? Colors.grey : Colors.white,
              indicatorWeight: 4,
              isScrollable: false,
              tabs: [
                _TextWidget(
                  text: 'Chats'.tr,
                ),
                _TextWidget(
                  text: 'Group'.tr,
                ),
                _TextWidget(
                  text: 'Page'.tr,
                ),
                _TextWidget(
                  text: 'Calls'.tr,
                ),
              ]),
        ),
        body: TabBarView(children: [
          ChatsHomeScreen(),
          GroupsChatScreen(),
          PagesChatScreen(),
          Container(
            child: Center(
              child: Text('Home'.tr),
            ),
          )
        ]),
      ));
}

class _TextWidget extends StatelessWidget {
  const _TextWidget({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: SafeGoogleFont(
          Fonts.font1,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
