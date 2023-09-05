import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdateUserData.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class EditeProfileScreen2 extends StatefulWidget {
  EditeProfileScreen2({required this.firstname, super.key});

  String firstname;

  @override
  State<EditeProfileScreen2> createState() => _EditeProfileScreen2State();
}

class _EditeProfileScreen2State extends State<EditeProfileScreen2> {
  bool wit = false;
  final getimydata = Get.find<GetMyUserDataCont>();
  TextEditingController firs = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController working = TextEditingController();
  TextEditingController hart = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController working_link = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    ameen();
    super.initState();
  }

  ameen() {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        firs.text = getimydata.data[i].first_name;
        lastname.text = getimydata.data[i].last_name;
        phonenumber.text = getimydata.data[i].phone_number;
        website.text = getimydata.data[i].website;
        working.text = getimydata.data[i].working;
        school.text = getimydata.data[i].school;
        working_link.text = getimydata.data[i].working_link;
        address.text = getimydata.data[i].address;
      });
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
      centerTitle: true,
      elevation: 0,
      title: 'Update Profile'.tr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: firs,
                icon: Icons.person,
                name: 'FirstName'.tr,
              ),
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: lastname,
                icon: Icons.home,
                name: 'Lastname'.tr,
              ),
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: phonenumber,
                icon: Icons.phone,
                name: 'Phone'.tr,
              ),
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: address,
                icon: Ionicons.location_sharp,
                name: 'Location'.tr,
              ),
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: website,
                icon: Icons.travel_explore,
                name: 'WebSite'.tr,
              ),
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: working,
                icon: Icons.work,
                name: 'Work Place'.tr,
              ),
            for (var i = 0; i < getimydata.data.length; i++)
              WidgetUpdateEditeProfile(
                controller: working_link,
                icon: Icons.work_outline,
                name: 'Company website'.tr,
              ),
            WidgetUpdateEditeProfile(
              controller: school,
              icon: Icons.school,
              name: 'School'.tr,
            ),
            if (wit)
              Container(
                child: Center(child: CircularProgressIndicator()),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    wit = true;
                  });
                  var next = await ApiUpdateUserData.UpdateUserData(
                    phonenumber.text,
                    lastname.text,
                    firs.text,
                    website.text,
                    working.text,
                    school.text,
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    working_link.text,
                    address.text,
                  );
                  if (next['api_status'] == 200)
                    Get.back(closeOverlays: true);
                  Get.snackbar('Update', next['message']);
                  getimydata.getUserdata();
                  if (next['api_status'] == await 200) {
                    setState(() {
                      wit = false;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorTheme,
                      borderRadius: BorderRadius.circular(10)),
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                      child: Text(
                        'Save'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}

class WidgetUpdateEditeProfile extends StatefulWidget {
  WidgetUpdateEditeProfile(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.name})
      : super(key: key);
  final icon;
  String name;
  TextEditingController controller;

  @override
  State<WidgetUpdateEditeProfile> createState() =>
      _WidgetUpdateEditeProfileState();
}

class _WidgetUpdateEditeProfileState extends State<WidgetUpdateEditeProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                  backgroundColor: Get.isDarkMode
                      ? ColorDarkComponents: ColorTheme,
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  )),
              Container(
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode
                        ? ColorDarkTextBox
                        : Color.fromARGB(8, 45, 44, 44)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: widget.name,
                        labelStyle: SafeGoogleFont(Fonts.font1,
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
