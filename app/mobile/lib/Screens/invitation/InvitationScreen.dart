import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiInvitation.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/InvitationModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class invitationScreen extends StatefulWidget {
  const invitationScreen({super.key});

  @override
  State<invitationScreen> createState() => _invitationScreenState();
}

class _invitationScreenState extends State<invitationScreen> {
  List<InvitationModel> invait = [];
  void GetInvit() {
    ApiInvitation.invite().then((value) {
      setState(() {
        invait = value.toList();
      });
    });
  }

  @override
  void initState() {
    GetInvit();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      title: 'Invitation Links'.tr,
      centerTitle: false,
      elevation: 0,
      loding: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Used Links'.tr,
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        '20',
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Advailabel Links'.tr,
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        '10',
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Generated Links'.tr,
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        '10',
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // Text('Generated Links'),
                  // Text('Advailabel Links'),
                ],
              ),
              Divider(),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: ColorTheme, borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Crate Link'.tr,
                      style: SafeGoogleFont(Fonts.font1,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Divider(),
              // Text('Url , data , Invited User'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Url',
                        style: SafeGoogleFont(Fonts.font1,
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text('Data'.tr,
                          style: SafeGoogleFont(Fonts.font1,
                              fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Divider(),
                  Column(
                    children: [
                      Text('Invited User'.tr,
                          style: SafeGoogleFont(Fonts.font1,
                              fontSize: 16, fontWeight: FontWeight.w700)),
                    ],
                  )
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
