import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/MangeSessionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/MangeSessionsModel.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class ManageSessionsScreen extends StatefulWidget {
  const ManageSessionsScreen({super.key});

  @override
  State<ManageSessionsScreen> createState() => _ManageSessionsScreenState();
}

class _ManageSessionsScreenState extends State<ManageSessionsScreen> {
  @override
  List<MangeSessionsModel> data = [];

  @override
  void initState() {
    _sesion();
    myPhon();
    super.initState();
  }

  bool myPhone = false;

  void _sesion() {
    MangeSessionsApi.getsessio().then((ameen) {
      setState(() {
        data = ameen.toList();
      });
    });
  }

  void myPhon() async {
    var myP = await SharedP.Get('tok');
    setState(() {
      for (var i = 0; i < data.length; i++)
        if (myP == data[i].session_id) myPhone = true;
    });
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Manage Sessions'.tr,
      centerTitle: false,
      elevation: 1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < data.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorDarkComponents,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (data[i].platform == 'Phone')
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorTheme, shape: BoxShape.circle),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/mobile.svg',
                                      color: Colors.white,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                            if (data[i].platform == 'Mac')
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorTheme, shape: BoxShape.circle),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/mac-screen-svgrepo-com.svg',
                                      color: Colors.white,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                            if (data[i].platform == 'Windows')
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorTheme, shape: BoxShape.circle),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/microsoft-windows-22-logo-svgrepo-com.svg',
                                      color: Colors.white,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[i].platform,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.timelapse,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    Text(
                                      data[i].time,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: Text(
                            myPhone ? 'My Phone' : 'IP: ${data[i].ip_address}',
                            style:
                                GoogleFonts.cairo(fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            QuickAlert.show(
                              onConfirmBtnTap: () async {
                                var delteSession =
                                    await DeleteSessionsApi.delete(data[i].id);
                                Get.snackbar('Delete', delteSession['message']);
                                print(delteSession);
                                setState(() {
                                  data.removeAt(i);
                                });
                              },
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'delete the device?'.tr,
                              confirmBtnText: 'Yes'.tr,
                              cancelBtnText: 'No'.tr,
                              confirmBtnColor: Colors.red,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorTheme,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child: Center(
                                  child: Text(
                                'Delete'.tr,
                                style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}
