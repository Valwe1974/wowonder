import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/VerificationApi.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final getimydata = Get.find<GetMyUserDataCont>();
  @override
  void initState() {
    verfi();
    getimydata.getUserdata();
    super.initState();
  }

  XFile? ImagePost;
  XFile? ImagePicture;

  final ImagePicker _picker = ImagePicker();
  String? filename;
  String? filename2;

  void ImageUplode() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    image = await image!;
    image;

    setState(() {
      filename = image!.path.split('/').last;
      ImagePost = image;
      print(image.path);

      ;
    });
  }

  void ImageUplodePricture() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    image = await image!;
    image;

    setState(() {
      filename2 = image!.path.split('/').last;
      ImagePicture = image;
      print(image.path);

      ;
    });
  }

  TextEditingController fullname = TextEditingController();
  TextEditingController comments = TextEditingController();

  bool varf = true;

  verfi() async {
    setState(() {
      for (var i = 0; i < getimydata.data.length; i++)
        varf = getimydata.data[i].verified == '1' ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
// endorsement-icon.svg
    return ScaffoldWidget(
      title: 'Verification'.tr,
      centerTitle: false,
      elevation: 0,
      body: varf
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/images/svg/endorsement-icon.svg',
                    color: Get.isDarkMode ? Colors.white : ColorTheme,
                    height: Get.height * 0.30,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.10,
                ),
                Text(
                  'Congratulations, you have been verified'.tr,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : ColorTheme,
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Full Name'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: ColorTheme,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          boxShadow: [
                            BoxShadow(color: ColorTheme, spreadRadius: 0.1),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          controller: fullname,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Comments1'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: ColorTheme,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          boxShadow: [
                            BoxShadow(color: ColorTheme, spreadRadius: 0.1),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: TextField(
                          controller: comments,
                          maxLines: 7,
                          maxLength: 300,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Passport'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: ColorTheme,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        ImageUplode();
                      },
                      child: Container(
                        height: Get.height * 0.20,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                                image: FileImage(File(ImagePost == null
                                    ? ''
                                    : ImagePost!.path)))),
                        child: Center(
                          child: Icon(Icons.photo),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Picture of you'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: ColorTheme,
                          fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        ImageUplodePricture();
                      },
                      child: Container(
                        height: Get.height * 0.20,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                                image: FileImage(File(ImagePicture == null
                                    ? ''
                                    : ImagePicture!.path)))),
                        child: Center(
                          child: Icon(Icons.photo),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (ImagePost == null) {
                          Get.snackbar('Message', 'الرجاء تبعئة كامل البيانات');
                        } else if (ImagePicture == null) {
                          Get.snackbar('Message', 'الرجاء تبعئة كامل البيانات');
                        }
                        var ameen = await VerificationApi.verificatio(
                            ImagePost!.path,
                            ImagePicture!.path,
                            fullname.text,
                            filename,
                            comments.text);
                        if (ameen['api_status'] == 200) {
                          Get.back(closeOverlays: true);
                        }
                        if (ameen['api_status'] == '400') {
                          if (ameen['errors']['error_text'] ==
                              'name (POST) is missing')
                            Get.snackbar('Message', 'Please enter the Name');
                          if (ameen['errors']['error_text'] ==
                              'text (POST) is missing')
                            Get.snackbar('Message', 'Please write a comment');
                        }
// error_text: text (POST) is missing
                        print(ameen);
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorTheme,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Send Requst'.tr,
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.08,
                  )
                ],
              ),
            ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}
