import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/SharePostGroupsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/SharePostMyTimelineScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class WidgetShare extends StatelessWidget {
  const WidgetShare({
    required this.postid,
    required this.url_post,
    super.key,
  });
  final String url_post;
  final String postid;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.30,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(SharePostMyTimelineScreen(
                  postid: postid,
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Share to my Timeline'.tr,
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Icon(Icons.sync),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
              child: Divider(),
            ),
            InkWell(
              onTap: () {
                Get.to(
                  SharePostGroupsScreen(
                    post_id: postid,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Share to a Group'.tr,
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Icon(Icons.group),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Share to a Page'.tr,
                  style: SafeGoogleFont(Fonts.font1,
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Icon(Icons.pages),
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
              child: Divider(),
            ),
            InkWell(
              onTap: () async {
                Share.share(url_post);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'More Options'.tr,
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Icon(Icons.ios_share_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
