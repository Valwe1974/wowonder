import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFollowUser.dart';

class WidgetFollowNew extends StatefulWidget {
  WidgetFollowNew({
    required this.confirm_followers,
    required this.can_follow,
    required this.is_following,
    required this.user_id,
    required this.sizew,
    Key? key,
  }) : super(key: key);
  final is_following;
  final can_follow;
  final confirm_followers;
  final sizew;

  String user_id;
  @override
  State<WidgetFollowNew> createState() => _WidgetFollowNewState();
}

class _WidgetFollowNewState extends State<WidgetFollowNew> {
  @override
  late String fowllow;

  void initState() {
    setState(() {
      if (widget.is_following == 0) fowllow = 'Fowllow';
      if (widget.is_following == 1) fowllow = 'Following';
      if (widget.is_following == 2) fowllow = 'Requested'.toString();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (fowllow == 'Requested') {
            ApiFollowUser.folow(widget.user_id);
            fowllow = 'Fowllow';
          } else if (fowllow == 'Fowllow') {
            widget.confirm_followers == '1'
                ? fowllow = 'Requested'
                : fowllow = 'Following';
            ApiFollowUser.folow(widget.user_id);
          } else if (fowllow == 'Following') {
            fowllow = 'Fowllow';
            ApiFollowUser.folow(widget.user_id);
          }
        });
      },
      child: Container(
        height: Get.height * 0.04,
        width: Get.width * widget.sizew,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode
              ? fowllow == 'Fowllow'
                  ? Colors.blue
                  : ColorTheme
              : fowllow == 'Fowllow'
                  ? Colors.blue
                  : ColorTheme,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/Add User.svg'),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text(
              fowllow.tr,
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
