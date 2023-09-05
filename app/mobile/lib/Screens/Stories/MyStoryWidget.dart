import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class MyStoryWidget extends StatelessWidget {
  MyStoryWidget({super.key, required this.images, required this.name});

  String images;
  final name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: ColorTheme),
          height: Get.height * 0.10,
          width: Get.width * 0.20,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: images,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 2,
                  right: 0,
                  child: CircleAvatar(
                    maxRadius: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        Text(
          name,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class MyStoryWidgetv2 extends StatelessWidget {
  MyStoryWidgetv2({super.key, required this.images, required this.name});

  String images;
  final name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Get.isDarkMode
              ? ColorDarkBackground
              : Theme.of(context).scaffoldBackgroundColor),
      height: Get.height * 0.16,
      width: Get.width * 0.25,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Get.height * 0.12,
                width: Get.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: CachedNetworkImage(
                      imageUrl: images,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 5,
                  left: 5,
                  child: CircleAvatar(
                    maxRadius: 12,
                    child: CircleAvatar(
                      backgroundColor: ColorTheme,
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                name,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );
  }
}
