import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdateUserData.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final getimydata = Get.find<GetMyUserDataCont>();
  @override
  void initState() {
    ameen();
    super.initState();
  }

  TextEditingController about = TextEditingController();
  ameen() {
    setState(() {
      for (var i = 0; i < getimydata.data.length; i++)
        about.text = getimydata.data[i].about;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: InkWell(
              onTap: () async {
                var fin = await ApiUpdateUserData.UpdateUserData(
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  about.text,
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                );
                if (fin['api_status'] == await 200) getimydata.getUserdata();

                if (fin['api_status'] == 200) {
                  Get.back(closeOverlays: true);
                }

                await Get.snackbar('Update', fin['message']);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: ColorTheme),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Save'.tr,
                      style: GoogleFonts.cairo(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        elevation: 3,
        backgroundColor: Get.isDarkMode ?  ColorDarkComponents : Colors.white ,
        centerTitle: false,
        title: Text(
          'About'.tr,
          style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var i = 0; i < getimydata.data.length; i++)
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundImage:
                          CachedNetworkImageProvider(getimydata.data[i].avatar),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < getimydata.data.length; i++)
                          Text(
                            getimydata.data[i].name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                          ),
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.public,
                                color: Colors.grey,
                                size: 18,
                              ),
                              SizedBox(
                                width: Get.width * 0.001,
                              ),
                              Text(
                                'Public'.tr,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ColorDarkTextBox
                        : Color.fromARGB(255, 245, 243, 243),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: about,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLength: 1000,
                    maxLines: 10,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                var fin = await ApiUpdateUserData.UpdateUserData(
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  ' ',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                );
                if (fin['api_status'] == 200) Get.back(closeOverlays: true);
                Get.snackbar('Update', fin['message']);
                getimydata.getUserdata();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Iconly-Light-Delete.svg',
                      color: Color(0xffD03738),
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'Delete Bio'.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffD03738),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
