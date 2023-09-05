import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiDownInfo.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

import '../../Util/DarkMode/DarkModeWidget.dart';

class DownloadMyInfoScreen extends StatefulWidget {
  const DownloadMyInfoScreen({
    super.key,
    required this.name,
    required this.avat,
  });

  final String name;
  final String avat;

  @override
  State<DownloadMyInfoScreen> createState() => _DownloadMyInfoScreenState();
}

class _DownloadMyInfoScreenState extends State<DownloadMyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBarTrueOrFalse: true,
      // centerTitle: false,
      // elevation: 0,
      // loding: false,
      // title: 'Download My Information'.tr,
      appBar: AppBar(
        title: Text('Download My Information'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
              color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: CachedNetworkImageProvider(widget.avat),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      widget.name,
                      style: SafeGoogleFont(Fonts.font3,
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Please choose which informaiton you would like to download'.tr,
              style: SafeGoogleFont(Fonts.font1,
                  fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          InkWell(
            onTap: () async {
              final dwon = await ApiDownInfo.down('my_information');
              print(dwon['link']);
              await UrlGo(dwon['link']);
            },
            child: _WidgetDwonload(
              text: 'Download My Informaiton'.tr,
            ),
          ),
          InkWell(
            onTap: () async {
              final dwon = await ApiDownInfo.down('posts');
              print(dwon['link']);
              await UrlGo(dwon['link']);
            },
            child: _WidgetDwonload(
              text: 'Download Post'.tr,
            ),
          ),
          InkWell(
            onTap: () async {
              final dwon = await ApiDownInfo.down('groups');
              print(dwon['link']);
              await UrlGo(dwon['link']);
            },
            child: _WidgetDwonload(
              text: 'Download Groups'.tr,
            ),
          ),
          InkWell(
            onTap: () async {
              final dwon = await ApiDownInfo.down('pages');
              print(dwon['link']);
              await UrlGo(dwon['link']);
            },
            child: _WidgetDwonload(
              text: 'Download Pages'.tr,
            ),
          ),
          InkWell(
            onTap: () async {
              final dwon = await ApiDownInfo.down('followers');
              print(dwon['link']);
              await UrlGo(dwon['link']);
            },
            child: _WidgetDwonload(
              text: 'Download Followers'.tr,
            ),
          ),
          InkWell(
            onTap: () async {
              final dwon = await ApiDownInfo.down('following');
              print(dwon['link']);
              await UrlGo(dwon['link']);
            },
            child: _WidgetDwonload(
              text: 'Download Following'.tr,
            ),
          ),
        ],
      ),
    );
  }
}

class _WidgetDwonload extends StatelessWidget {
  const _WidgetDwonload({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          borderRadius: BorderRadius.circular(5),

        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          child: Center(
            child: Text(
              text,
              style: SafeGoogleFont(Fonts.font3,
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
