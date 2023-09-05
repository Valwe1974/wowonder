import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiBlockUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetBlocked.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FollowingModel.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class BlockedUserScreen extends StatefulWidget {
  const BlockedUserScreen({super.key});

  @override
  State<BlockedUserScreen> createState() => _BlockedUserScreenState();
}

class _BlockedUserScreenState extends State<BlockedUserScreen> {
  List<FollowingModel> data = [];
  @override
  void initState() {
    GetStories();
    super.initState();
  }

  void GetStories() async {
    ApiGetBlocked.GetBlock().then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(data);
    return ScaffoldWidget(
      centerTitle: false,
      elevation: 0,
      title: 'Blocked User'.tr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: data.isEmpty
            ? Center(
                child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/No data-pana.svg',
                    height: Get.height * 0.50,
                    width: Get.width * 0.60,
                  ),
                  Text(
                    'No Data'.tr,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ))
            : SingleChildScrollView(
                child: Column(children: [
                for (var i = 0; i < data.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode ? ColorDarkComponents : colorBackLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    CachedNetworkImageProvider(data[i].avatar),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Text(
                                data[i].name,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  // var lslslsls = await ApiBlockUnBlockUser.blcked(
                                  //     data[i].user_id, 'un-block');
                                  // Get.snackbar(
                                  //     'Un Block', lslslsls['block_status']);
                                  // setState(() {
                                  //   data.removeAt(i);
                                  // });

                                  // print(lslslsls['api_status'].toString());
                                  QuickAlert.show(
                                      onConfirmBtnTap: () async {
                                        var lslslsls =
                                            await ApiBlockUnBlockUser.blcked(
                                                data[i].user_id, 'un-block');

                                        setState(() {
                                          data.removeAt(i);
                                        });
                                        Get.back(closeOverlays: true);
                                        Get.snackbar('Un Block',
                                            lslslsls['block_status']);
                                      },
                                      context: context,
                                      type: QuickAlertType.confirm,
                                      animType: QuickAlertAnimType.rotate,
                                      text: 'Do you want to unblock'.tr +
                                          data[i].name,
                                      confirmBtnText: 'Yes'.tr,
                                      cancelBtnText: 'No'.tr,
                                      confirmBtnColor: Colors.red
                                      // customAsset: 'assets/images/love.gif'
                                      );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colorTextBoardingLight1),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Un Blocked'.tr,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ])),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}
