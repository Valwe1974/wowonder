import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/Country.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/EditeProfileScreen2.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdateUserData.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class MyAccountSetScreen extends StatefulWidget {
  const MyAccountSetScreen({super.key});

  @override
  State<MyAccountSetScreen> createState() => _MyAccountSetScreenState();
}

class _MyAccountSetScreenState extends State<MyAccountSetScreen> {
  int str = 0;
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            useRootNavigator: true,
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        str = DateTime.now().year - _dateTime.year;
        _dateTime = value!;
        str < 17
            ? contDateTime.text =
                '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}'
            : contDateTime.text = 'You must be 18 or over';
      });
    });
  }

  TextEditingController contDateTime = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  final getimydata = Get.find<GetMyUserDataCont>();
  String Country = 'Select Country';
  String countryNup = '0';
  bool male = false;
  String Gender = 'Gender';
  String error_text = '';
  bool wit = false;
  ameenj() {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        username.text = getimydata.data[i].username;
        email.text = getimydata.data[i].email;
        contDateTime.text = getimydata.data[i].birthday;
        if (getimydata.data[i].gender == 'male') Gender = 'Male';
        if (getimydata.data[i].gender == 'female') Gender = 'Female';
        countryNup = getimydata.data[i].country_id;
      });
  }

  @override
  void initState() {
    ameenj();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'My Account'.tr,
      centerTitle: false,
      elevation: 1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            WidgetUpdateEditeProfile(
              controller: username,
              icon: Icons.portable_wifi_off,
              name: 'username'.tr,
            ),
            WidgetUpdateEditeProfile(
              controller: email,
              icon: Icons.email,
              name: 'Email'.tr,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                  controller: contDateTime,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date Of Birth'.tr,
                    suffixIcon: InkWell(
                      onTap: _showDatePicker,
                      child: Icon(
                        Icons.date_range,
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1
                    ),
                    color:  Get.isDarkMode ? ColorDarkTextBox : Colors.white),
                height: Get.height * 0.07,
                width: Get.width,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Get.isDarkMode ? ColorDarkTextBox : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: ps.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      Country = ps[index].toString();
                                      countryNup = index.toString();
                                    });
                                    Get.back();
                                  },
                                  child: Container(
                                    width: Get.width,
                                    child: Center(
                                      child: Text(
                                        ps[index].toString().tr,
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                      ),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < ContText.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${ContText[i][countryNup]}'.tr,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.keyboard_arrow_down),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  male = !male;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1
                      ),
                      color: Get.isDarkMode ? ColorDarkTextBox : Colors.white),
                  height: Get.height * 0.07,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            if (Gender == 'Male')
                              Icon(
                                Icons.male,
                                color: Colors.blue,
                              ),
                            if (Gender == 'Female')
                              Icon(
                                Icons.female,
                                color: Color.fromARGB(255, 219, 33, 243),
                              ),
                            Text(Gender),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: male
                            ? Icon(Icons.keyboard_arrow_up)
                            : Icon(Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            male
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            Gender = 'Male';

                            male = !male;
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Male'.tr),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            leading: Icon(
                              Icons.male,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Gender = 'Female'.tr;
                            male = !male;
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text('Female'.tr),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            leading: Icon(
                              Icons.female,
                              color: Color.fromARGB(255, 251, 4, 255),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: Get.height * 0.01,
            ),
            str < 18 ? SizedBox() : Text('Your age $str'),
            InkWell(
                onTap: () async {
                  setState(() {
                    wit = true;
                  });
                  var api = await ApiUpdateUserData.UpdateUserData(
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    username.text,
                    email.text,
                    Gender,
                    contDateTime.text,
                    '',
                    '',
                    countryNup,
                    '','',
                    
                  );
                  if (api['api_status'] == 200) Get.back(closeOverlays: true);

                  Get.snackbar(
                      'Update',
                      api['message'].toString() == 'null'
                          ? api['errors']['error_text'].toString()
                          : api['message']);
                  getimydata.getUserdata();

                  setState(() {
                    api['errors'] == null
                        ? error_text = ''
                        : error_text = api['errors']['error_text'];

                    if (api['errors'] != null) wit = false;
                  });

                  print(api);
                },
                child: WidgetSaveBot()),
            if (error_text.isNotEmpty) Text(error_text),
            if (wit) CircularProgressIndicator()
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}

class WidgetSaveBot extends StatelessWidget {
  const WidgetSaveBot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: ColorTheme),
        width: Get.width,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Save'.tr,
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
          ),
        )),
      ),
    );
  }
}
