import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/DeleteUserApi.dart';
import 'package:wowondertimelineflutterapp/Util/routes/routes.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Widget/TextFiledWidget.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class DeleteAccontScreen extends StatefulWidget {
  const DeleteAccontScreen({super.key});

  @override
  State<DeleteAccontScreen> createState() => _DeleteAccontScreenState();
}

class _DeleteAccontScreenState extends State<DeleteAccontScreen> {
  TextEditingController Password = TextEditingController();
  @override
  bool vals = false;
  bool isVisibilty = true;
  bool yesiwant = false;
  bool wit = false;
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: 'Delete Accont'.tr,
      centerTitle: false,
      elevation: 1,
      body: wit
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/cancel.png',
                    height: Get.height * 0.26,
                    width: Get.width * 0.50,
                  ),
                  TextFiledWidget(
                    controller: Password,
                    hintText: 'Password'.tr,
                    icon: Icon(Icons.abc_outlined),
                    obscureText: isVisibilty,
                    suffixIcon: IconButton(
                      icon: isVisibilty
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isVisibilty = !isVisibilty;
                        });
                      },
                    ),
                    validato: () {},
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: vals,
                          onChanged: (val) {
                            setState(() {
                              vals = val!;
                              yesiwant = false;
                              print(val);
                            });
                          }),
                      Container(
                        width: Get.width * 0.80,
                        child: Text(
                          'Yes, I want to delete the account and I agree to delete all data'
                              .tr,
                          style: GoogleFonts.cairo(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      if (vals) {
                        QuickAlert.show(
                          onConfirmBtnTap: () async {
                            setState(() {
                              wit = true;
                            });
                            var deleapi =
                                await DeleteUserApi.cratepost(Password.text);

                            print(deleapi);
                            if (deleapi['api_status'] == 200) {
                              await SharedP.Remove();

                              if (await SharedP.Get('user_id') == null) {
                                Get.offAllNamed(Routes.languageScreen);
                                Get.snackbar('Remove'.tr,
                                    'The account has been deleted'.tr);
                              } else {
                                Get.snackbar('sign out', 'Logout Failed');
                                setState(() {
                                  wit = false;
                                });
                              }
                            }

                            print(deleapi);

                            if (deleapi['api_status'] == '400') {
                              if (deleapi['errors']['error_text'] ==
                                  'password (POST) is missing')
                                Get.snackbar(
                                    'Passoerd', 'The password is wrong');
                              setState(() {
                                wit = false;
                              });
                            }
                          },
                          context: context,
                          type: QuickAlertType.confirm,
                          text:
                              'Are you sure you want to delete the account?'.tr,
                          confirmBtnText: 'Yes'.tr,
                          cancelBtnText: 'No'.tr,
                          confirmBtnColor: Colors.red,
                        );
                      } else {
                        setState(() {
                          yesiwant = true;
                        });
                      }
                    },
                    child: Container(
                      width: Get.width * 0.90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorTheme),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Delete Account'.tr,
                          style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  if (yesiwant)
                    Text('Please agree to delete the account first'.tr)
                ],
              ),
            ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }
}
