import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFollowUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSearch.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CearchModel.dart';
import 'package:wowondertimelineflutterapp/Util/routes/routes.dart';

class AddFrinedScreen extends StatefulWidget {
  AddFrinedScreen({Key? key}) : super(key: key);

  @override
  State<AddFrinedScreen> createState() => _AddFrinedScreenState();
}

class _AddFrinedScreenState extends State<AddFrinedScreen> {
  bool follow = false;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? ColorTheme : ColorTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Get.offNamed(Routes.homenavebar);
            },
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Text(
                'Done'.tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Get.isDarkMode ? ColorTheme : ColorTheme),
              ),
            ),
          ),
        ],
        title: Text(
          'Add Friends'.tr,
          style: GoogleFonts.poppins(),
        ),
      ),
      body: FutureBuilder(
          future: ApiSearch.Getposts('0'),
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<CearchModel> data = snapshot.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: data.length,
                itemBuilder: ((context, index) => Column(
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: Get.width * 0.45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 1,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CircleAvatar(
                                  maxRadius: Get.width * 0.10,
                                  backgroundImage:
                                      NetworkImage(data[index].avatar),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Text(data[index].name),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                _BottomFooloow(user_id: data[index].user_id)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}

class _BottomFooloow extends StatefulWidget {
  _BottomFooloow({Key? key, required this.user_id}) : super(key: key);
  final user_id;
  @override
  State<_BottomFooloow> createState() => __BottomFooloowState();
}

class __BottomFooloowState extends State<_BottomFooloow> {
  @override
  bool follow = false;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: Get.height * 0.03,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Get.isDarkMode ? ColorTheme : ColorTheme, spreadRadius: 1)
          ],
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              if (follow) {
                ApiFollowUser.folow(widget.user_id);
                follow = !follow;
              } else {
                ApiFollowUser.folow(widget.user_id);
                follow = !follow;
              }
            });
          },
          child: Center(
              child: Text(follow ? 'Request'.tr : 'Add  Friend '.tr,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode ? ColorTheme : ColorTheme,
                  ))),
        ),
      ),
    );
  }
}
