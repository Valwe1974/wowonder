import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/AddFriend/FriendRequestsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/HomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/MoreScreen/MoreScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/PostVideoRels.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';

class HomeNavBar extends StatefulWidget {
  HomeNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

final cont = Get.put(GetMyUserDataCont());
PageController _controller = PageController(initialPage: 0);

class _HomeNavBarState extends State<HomeNavBar> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  var tabIndex = 0;
  var contFrind = '0';
  // var getToNamedList = [
  //   HomeScreen(),
  //   SearchScreen(),
  //   Container(),
  //   MoreScreen(),
  //   VideoScreen(),
  // ];
  String img = 'assets/images/';
  void changePageTo(int index) {
    tabIndex = index;
    setState(() {});
  }

  @override
  onLine() {
    SocketNew.UPDATEUSERLASTSEEN();
    Timer.periodic(Duration(seconds: 30), (timer) {
      if (NodeJS) {
        SocketNew.UPDATEUSERLASTSEEN();
      } else {}
    });
  }

  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.bounceIn, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 0).animate(curvedAnimation);
    OneSignalNotf();
    onLine();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(GetMyUserDataCont());

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionBubble(
        //   // Menu items
        //   items: <Bubble>[
        //     // Floating action menu item
        //     Bubble(
        //       title: "Settings",
        //       iconColor: Colors.white,
        //       bubbleColor: Colors.blue,
        //       icon: Icons.settings,
        //       titleStyle: TextStyle(fontSize: 16, color: Colors.white),
        //       onPress: () {
        //         _animationController.reverse();
        //       },
        //     ),
        //     // Floating action menu item
        //     Bubble(
        //       title: "Profile",
        //       iconColor: Colors.white,
        //       bubbleColor: Colors.blue,
        //       icon: Icons.people,
        //       titleStyle: TextStyle(fontSize: 16, color: Colors.white),
        //       onPress: () {
        //         _animationController.reverse();
        //       },
        //     ),
        //     //Floating action menu item
        //     Bubble(
        //       title: "Home",
        //       iconColor: Colors.white,
        //       bubbleColor: Colors.blue,
        //       icon: Icons.home,
        //       titleStyle: TextStyle(fontSize: 16, color: Colors.white),
        //       onPress: () {
        //         Navigator.push(
        //             context,
        //             new MaterialPageRoute(
        //                 builder: (BuildContext context) => Container()));
        //         _animationController.reverse();
        //       },
        //     ),
        //   ],

        //   // animation controller
        //   animation: _animation,

        //   // On pressed change animation state
        //   onPress: () => _animationController.isCompleted
        //       ? _animationController.reverse()
        //       : _animationController.forward(),

        //   // Floating Action button Icon color
        //   iconColor: Colors.blue,

        //   // Flaoting Action button Icon
        //   iconData: Icons.ac_unit,
        //   backGroundColor: Colors.white,
        // ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          disabledElevation: 0,
          tooltip: 'Add'.tr,

          // shape:
          //     BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
          splashColor: ColorTheme,
          backgroundColor: Change_Color_Icons
              ? Get.isDarkMode
                  ? Color.fromARGB(255, 93, 93, 93)
                  : Colors.white
              : Get.isDarkMode
                  ? ColorTheme
                  : ColorTheme,
          onPressed: () {
            // changePageTo(3);
            Get.bottomSheet(
              AddHomeScreen(),
            );
          },
          child: Change_Color_Icons
              ? SvgPicture.asset(
                  ColorSvg.Add,

                  // color: tabIndex == 0 ? ColorTheme : Colors.grey,
                  // color: Color.fromARGB(255, 255, 255, 255),
                  width: 60,
                  height: 60,
                )
              : Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          // color: Get.isDarkMode ? HomeNavBarcolordark : HomeNavBarcolorLight,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
              height: Get.height * 0.07,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          changePageTo(0);
                        },
                        child: Container(
                          width: Get.width * 0.20,
                          child: Center(
                            child: SvgPicture.asset(
                              Change_Color_Icons
                                  ? ColorSvg.Home
                                  : SvgImages.home,
                              color: Change_Color_Icons
                                  ? null
                                  : tabIndex == 0
                                      ? ColorTheme
                                      : Colors.grey,
                              // color: Color.fromARGB(255, 255, 255, 255),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changePageTo(1);
                        },
                        child: Container(
                          width: Get.width * 0.20,
                          child: Center(
                            child: SvgPicture.asset(
                              Change_Color_Icons
                                  ? ColorSvg.Reels
                                  : SvgImages.MyVideo,
                              color: Change_Color_Icons
                                  ? null
                                  : tabIndex == 1
                                      ? ColorTheme
                                      : Colors.grey,
                              // color: Color.fromARGB(255, 255, 255, 255),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.20,
                      ),
                      InkWell(
                          onTap: () {
                            changePageTo(2);
                          },
                          child: Container(
                            width: Get.width * 0.20,
                            child: Stack(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    Change_Color_Icons
                                        ? ColorSvg.Requests
                                        : SvgImages.users,
                                    color: Change_Color_Icons
                                        ? null
                                        : tabIndex == 2
                                            ? ColorTheme
                                            : Colors.grey,
                                    // color: Color.fromARGB(255, 255, 255, 255),
                                    width: Change_Color_Icons ? 28 : 20,
                                    height: Change_Color_Icons ? 28 : 20,
                                  ),
                                ),
                                if (contFrind != '0')
                                  Positioned(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorTheme),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          contFrind,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          changePageTo(4);
                        },
                        child: Container(
                          width: Get.width * 0.20,
                          child: Center(
                            child: SvgPicture.asset(
                              Change_Color_Icons
                                  ? ColorSvg.Menu
                                  : SvgImages.Menu,
                              color: Change_Color_Icons
                                  ? null
                                  : tabIndex == 4
                                      ? ColorTheme
                                      : Colors.grey,
                              // color: Color.fromARGB(255, 255, 255, 255),
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        body: PageView(
          onPageChanged: (index) {
            changePageTo(index);
          },
          controller: PageController(initialPage: tabIndex),
          children: [
            if (tabIndex == 0) HomeScreen(),
            if (tabIndex == 1) VideoScreen(),
            if (tabIndex == 2) FriendRequestsScreen(),
            if (tabIndex == 4) MoreScreen(),
          ],
        ));
  }
}
