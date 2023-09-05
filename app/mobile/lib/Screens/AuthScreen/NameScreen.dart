import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/AddFriendScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/Country.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpditeUserData.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  XFile? ImagePost;
  String? filename;

  final ImagePicker _picker = ImagePicker();
  void ImageUplode() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    image = await _cropImage(image!);
    image;

    setState(() {
      filename = image!.path.split('/').last;
      ImagePost = image;
      print(image.path);

      ;
    });
  }

  Future<XFile?> _cropImage(XFile filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath.path,
      cropStyle: CropStyle.circle,
      maxHeight: 1080,
      maxWidth: 1080,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return XFile(croppedFile!.path);
  }

  bool male = false;

  String Gender = 'Gender';
  DateTime _dateTime = DateTime.now();
  TextEditingController contDateTime = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController numperPhone = TextEditingController();
  TextEditingController contGender = TextEditingController();
  int str = 0;
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

  String Country = 'Select Country';
  String countryNup = '0';
//////
  @override
  Widget build(BuildContext context) {
    FocusNode inputNode = FocusNode();
// to open keyboard call this function;
    void openKeyboard() {
      FocusScope.of(context).requestFocus(inputNode);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Fill your profile'.tr),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
        child: UpditeUserData.ameen
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                            height: Get.height * 0.19,
                            width: Get.width * 0.41,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: ImagePost == null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        'assets/images/images (7).png'),
                                  )
                                : Container(
                                    height: Get.height * 0.19,
                                    width: Get.width * 0.41,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(
                                              ImagePost!.path,
                                            )))),
                                  )),
                        InkWell(
                          onTap: () {
                            ImageUplode();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 114, left: 100, right: 20),
                            child: CircleAvatar(
                                backgroundColor:
                                    Get.isDarkMode ? ColorTheme : ColorTheme,
                                maxRadius: 15,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 17,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: firstname,
                        autofocus: true,
                        focusNode: inputNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'First Name'.tr,
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: lastname,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Last Name'.tr,
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
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
                  str < 18 ? SizedBox() : Text('Your age $str'),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                        controller: numperPhone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Phone Number'.tr,
                          prefixIcon:
                              InkWell(onTap: () {}, child: Icon(Icons.phone)),
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ],
                          color: Theme.of(context).scaffoldBackgroundColor),
                      height: Get.height * 0.07,
                      width: Get.width,
                      child: InkWell(
                        onTap: () {
                          Get.bottomSheet(Container(
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
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
                                              ps[index].toString(),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Country,
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
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        male = !male;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black)
                            ],
                            color: Theme.of(context).scaffoldBackgroundColor),
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
                                  Gender = 'Female';
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
                    height: Get.height * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      UpditeUserData.updite(
                          firstname.text,
                          lastname.text,
                          contDateTime.text,
                          ImagePost == null ? '' : ImagePost!.path,
                          filename,
                          numperPhone.text,
                          Gender,
                          countryNup,
                          '',
                          '');
                      Get.off(AddFrinedScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.isDarkMode ? ColorTheme : ColorTheme),
                        height: Get.height * 0.07,
                        child: Center(
                            child: Text(
                          'Next'.tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  )
                ],
              ),
      ),
    );
  }
}
