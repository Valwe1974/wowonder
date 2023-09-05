import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiReportUser.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class WidgetReportUser extends StatelessWidget {
  WidgetReportUser({
    required this.user_id,
    required this.name,
    required this.Report,
  });
  String user_id;
  String name;
  String Report;
  @override
  Widget build(BuildContext context) {
    TextEditingController commentsReport = TextEditingController();
    return ScaffoldWidget(
      title: 'Report User'.tr,
      centerTitle: true,
      elevation: 0,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          child: Column(
            children: [
              Text(
                'Comments Report'.tr,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: ColorTheme),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(170, 205, 202, 202),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 100,
                    maxLines: 4,
                    controller: commentsReport,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: Get.width * 0.40,
                      decoration: BoxDecoration(
                          color: ColorTheme,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Cancel'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // var report = await ApiReportUser.reportUser(
                      //     user_id, 'Report message== ${commentsReport.text}');
                      // print(report);

                      QuickAlert.show(
                        onConfirmBtnTap: () async {
                          var report = await ApiReportUser.reportUser(
                              user_id, Report + commentsReport.text);
                          print(report);
                          Get.back();
                          Get.back();
                          if (report['code'] == 1)
                            Get.snackbar('Report', 'تم الإبلاغ بنجاح');
                        },
                        context: context,
                        type: QuickAlertType.confirm,
                        text: 'Do you want to Report ${name}',
                        confirmBtnText: 'Yes'.tr,
                        cancelBtnText: 'No'.tr,
                        confirmBtnColor: Colors.red,
                      );
                    },
                    child: Container(
                      width: Get.width * 0.40,
                      decoration: BoxDecoration(
                          color: ColorTheme,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Report'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      loding: false,
      AppBarTrueOrFalse: true,
    );
  }
}
