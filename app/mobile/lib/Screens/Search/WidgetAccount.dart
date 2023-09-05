import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class WidgetAccount extends StatelessWidget {
  WidgetAccount({
    required this.image,
    required this.name,
    required this.username,
    required this.verified,
    super.key,
  });
  String image;
  String name;
  String username;
  String verified;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 27,
                backgroundColor: ColorTheme,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  maxRadius: 26,
                  child: CircleAvatar(
                    maxRadius: 24,
                    backgroundImage: CachedNetworkImageProvider(image),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: SafeGoogleFont(Fonts.font2,
                                  fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                            if (verified == '1')
                              Icon(
                                Icons.verified,
                                color: Color(0xff0153FF),
                                size: 17,
                              )
                          ],
                        ),
                        Text(
                          username,
                          style: SafeGoogleFont(Fonts.font2,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        )
      ],
    );
  }
}
