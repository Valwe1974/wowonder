import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class WidgetAddPost extends StatelessWidget {
  const WidgetAddPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            Get.isDarkMode ? Colors.black : Color.fromARGB(82, 205, 204, 204),
      ),
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.to(CreatePostScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<GetMyUserDataCont>(
                          init: GetMyUserDataCont(),
                          builder: ((cont) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < cont.data.length; i++)
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(cont.data[i].avatar),
                                    ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  for (var i = 0; i < cont.data.length; i++)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cont.data[i].name,
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Type Something here'.tr,
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(CreatePostScreen(
                      open: 'gallery'.tr,
                    ));
                  },
                  child: _AddPostsImages(
                    svg: 'gallery-add-svgrepo-com.svg',
                    color: Get.isDarkMode
                        ? Color.fromARGB(255, 171, 246, 173)
                        : Colors.green,
                    name: 'Gallery'.tr,
                  ),
                ),
                _AddPostsImages(
                  svg: 'female-person-svgrepo-com.svg',
                  color: Get.isDarkMode
                      ? Color.fromARGB(255, 186, 178, 226)
                      : Color(0xff3119a9),
                  name: 'Tag Friends'.tr,
                ),
                _AddPostsImages(
                  svg: 'listening-svgrepo-com.svg',
                  color: Get.isDarkMode
                      ? Color.fromARGB(255, 154, 147, 126)
                      : Color.fromARGB(255, 92, 70, 4),
                  name: 'Gallery'.tr,
                ),
                _AddPostsImages(
                  svg: 'conference-live-video-svgrepo-com.svg',
                  color: Get.isDarkMode
                      ? Color.fromARGB(255, 182, 150, 150)
                      : Color.fromARGB(255, 163, 4, 4),
                  name: 'Live'.tr,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AddPostsImages extends StatelessWidget {
  _AddPostsImages({
    required this.svg,
    required this.name,
    required this.color,
    super.key,
  });
  String svg;
  String name;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/svg/$svg',
          color: color,
          height: 20,
          width: 20,
        ),
        SizedBox(
          width: Get.width * 0.01,
        ),
        Text(
          name,
          style: GoogleFonts.poppins(color: color, fontSize: 14),
        ),
      ],
    );
  }
}
