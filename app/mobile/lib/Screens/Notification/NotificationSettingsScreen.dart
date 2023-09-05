import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/UpdateNotificationsApi.dart';

import '../../Widget/ScaffoldWidget.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final getimydata = Get.put(GetMyUserDataCont());

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Notification Setting'.tr,
      centerTitle: false,
      elevation: 0,
      body: Column(
        children: [
          for (var i = 0; i < getimydata.data.length; i++)
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(getimydata.data[i].avatar),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: ColorTheme,
                            child: Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width * 0.60,
                          child: Text(
                            getimydata.data[i].name,
                            maxLines: 1,
                            style:
                                GoogleFonts.cairo(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          'Notification Settings',
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          for (var i = 0; i < getimydata.data.length; i++)
            Container(
              height: Get.height * 0.70,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    ChekBoxNorfi(
                      chekbox1: 'e_liked',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_liked'],
                      text: 'Someone liked my posts',
                      icons: Icon(
                        Icons.thumb_up,
                        size: 15,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_commented',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_commented'],
                      text: 'Someone commented on my posts',
                      icons: Icon(
                        Icons.post_add_sharp,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_shared',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_shared'],
                      text: 'Someone shared on my posts',
                      icons: Icon(
                        Icons.share_outlined,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_followed',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_followed'],
                      text: 'Someone followed me',
                      icons: Icon(
                        Icons.follow_the_signs_outlined,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_mentioned',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_mentioned'],
                      text: 'Someone mentioned me',
                      icons: Icon(
                        Icons.motion_photos_auto,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_joined_group',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_joined_group'],
                      text: 'Someone joined my groups',
                      icons: Icon(
                        Icons.groups_2_sharp,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_accepted',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_accepted'],
                      text: 'Someone accepted my friend/follow requset',
                      icons: Icon(
                        Icons.add_task_sharp,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_profile_wall_post',
                      API_notification_settings: getimydata.data[i]
                          .API_notification_settings['e_profile_wall_post'],
                      text: 'Someone posted on my timeline',
                      icons: Icon(
                        Icons.view_timeline_outlined,
                        size: 20,
                      ),
                    ),
                    ChekBoxNorfi(
                      chekbox1: 'e_memory',
                      API_notification_settings: getimydata
                          .data[i].API_notification_settings['e_memory'],
                      text: 'You have remembrance on this day',
                      icons: Icon(
                        Icons.settings_backup_restore_sharp,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    )
                  ]),
                ),
              ),
            )
        ],
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}

class ChekBoxNorfi extends StatefulWidget {
  ChekBoxNorfi(
      {required this.icons,
      required this.text,
      required this.API_notification_settings,
      required this.chekbox1,
      super.key});

  String text;
  Icon icons;
  var chekbox1;
  @override
  final API_notification_settings;

  State<ChekBoxNorfi> createState() => _ChekBoxNorfiState();
}

class _ChekBoxNorfiState extends State<ChekBoxNorfi> {
  @override
  bool chekBox = true;
  final getimydata = Get.put(GetMyUserDataCont());

  cheboChek() {
    setState(() {
      if (widget.API_notification_settings == '0') chekBox = false;
      if (widget.API_notification_settings == '1') chekBox = true;
    });
  }

  @override
  void initState() {
    cheboChek();
    super.initState();
  }

  Widget build(BuildContext context) {
    print(widget.API_notification_settings);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(45, 158, 158, 158),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.icons,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Container(
                  width: Get.width * 0.70,
                  child: Text(
                    widget.text,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 14),
                  ),
                ),
              ],
            ),
            Checkbox(
                activeColor: Get.isDarkMode ? Colors.black : ColorTheme,
                checkColor: Get.isDarkMode ? Colors.white : Colors.white,
                value: chekBox,
                onChanged: (val) async {
                  setState(() {
                    chekBox = val!;
                  });
                  if (widget.chekbox1 == 'e_liked') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_liked', '1')
                        : UpditeNotificationsApi.updite('e_liked', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_commented') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_commented', '1')
                        : UpditeNotificationsApi.updite('e_commented', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_shared') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_shared', '1')
                        : UpditeNotificationsApi.updite('e_shared', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_followed') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_followed', '1')
                        : UpditeNotificationsApi.updite('e_followed', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_mentioned') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_mentioned', '1')
                        : UpditeNotificationsApi.updite('e_mentioned', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_joined_group') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_joined_group', '1')
                        : UpditeNotificationsApi.updite('e_joined_group', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_accepted') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_accepted', '1')
                        : UpditeNotificationsApi.updite('e_accepted', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_profile_wall_post') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite(
                            'e_profile_wall_post', '1')
                        : UpditeNotificationsApi.updite(
                            'e_profile_wall_post', '0');
                    getimydata.updi();
                  }
                  ;
                  if (widget.chekbox1 == 'e_memory') {
                    widget.API_notification_settings == '0'
                        ? UpditeNotificationsApi.updite('e_memory', '1')
                        : UpditeNotificationsApi.updite('e_memory', '0');
                    getimydata.updi();
                  }
                }),
          ],
        ),
        Divider()
      ],
    );
  }
}
