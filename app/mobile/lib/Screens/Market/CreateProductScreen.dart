import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/CreateProductApi.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Util/routes/routes.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  /////here
  ///
  bool wait = false;
  TextEditingController product_title = TextEditingController();
  TextEditingController product_category = TextEditingController();
  TextEditingController product_description = TextEditingController();
  TextEditingController product_price = TextEditingController();
  TextEditingController product_location = TextEditingController();
  TextEditingController product_sub_category = TextEditingController();
  TextEditingController fid_3 = TextEditingController();
  TextEditingController product_utl = TextEditingController();

  Future<void> _onTapPublish() async {}

  final FocusNode NodeTextDone = FocusNode();
  final FocusNode NodeTextDone2 = FocusNode();
  final FocusNode NodeTextDone3 = FocusNode();
  final FocusNode NodeTextDone4 = FocusNode();
  final FocusNode NodeTextDone5 = FocusNode();
  @override
  final ImagePicker picker = ImagePicker();
  List<XFile> imageFileList = [];
  void selectimges() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
    print('images List Lenth' + imageFileList.length.toString());
  }

  bool type = false;
  String typeText = 'New';
  String currencyText = 'USD';
  bool currencyflase = false;
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: ' Sell new product'.tr,
      centerTitle: true,
      elevation: 0,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(53, 158, 158, 158),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: Get.width,
                            height: 50,
                            child: KeyboardActions(
                              config: buildConfigDone(context, NodeTextDone),
                              child: TextField(
                                controller: product_title,
                                focusNode: NodeTextDone,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Product Name'.tr,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(53, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: Get.width,
                          height: 50,
                          child: KeyboardActions(
                            config: buildConfigDone(context, NodeTextDone2),
                            child: TextField(
                              controller: product_location,
                              focusNode: NodeTextDone2,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Location'.tr,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(53, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: Get.width,
                          height: 200,
                          child: KeyboardActions(
                            config: buildConfigDone(context, NodeTextDone3),
                            child: TextField(
                              controller: product_description,
                              focusNode: NodeTextDone3,
                              textInputAction: TextInputAction.done,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Description'.tr,
                                hintText: 'Please describe yout ptoduct.'.tr,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                type = !type;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(53, 158, 158, 158),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(11),
                                child: Row(
                                  children: [
                                    Text(
                                      typeText,
                                      style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (type)
                            Card(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        typeText = 'New';
                                        type = false;
                                      });
                                    },
                                    child: Card(
                                      shadowColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('New'.tr),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        typeText = 'Used';
                                        type = false;
                                      });
                                    },
                                    child: Card(
                                      shadowColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Used'.tr),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),

                      /////////////currencyText
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                currencyflase = !currencyflase;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                    width: Get.width * 0.30,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(53, 158, 158, 158),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: KeyboardActions(
                                      config: buildConfigDone(
                                          context, NodeTextDone4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextField(
                                          focusNode: NodeTextDone4,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Total Item'.tr,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Container(
                                    width: Get.width * 0.22,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(53, 158, 158, 158),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: KeyboardActions(
                                        config: buildConfigDone(
                                            context, NodeTextDone5),
                                        child: TextField(
                                          controller: product_price,
                                          keyboardType: TextInputType.number,
                                          focusNode: NodeTextDone5,
                                          decoration: InputDecoration(
                                            hintText: 'Price'.tr,
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(53, 158, 158, 158),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          currencyText,
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (currencyflase)
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        currencyText = 'USD';
                                        currencyflase = false;
                                      });
                                    },
                                    child: Card(
                                      shadowColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('USD'),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        currencyText = 'EUR';
                                        currencyflase = false;
                                      });
                                    },
                                    child: Card(
                                      shadowColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('EUR'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('Images');
                  },
                  child: InkWell(
                    onTap: () {
                      selectimges();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(47, 158, 158, 158),
                          borderRadius: BorderRadius.circular(20)),
                      height: Get.height * 0.15,
                      width: Get.width * 0.30,
                      child: Icon(Icons.camera_alt_sharp),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                if (imageFileList.isNotEmpty)
                  Container(
                    height: Get.height * 0.55,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageFileList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 9),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageFileList.removeAt(index);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: Get.width * 0.60,
                                          height: Get.height * 0.09,
                                          decoration: BoxDecoration(
                                              color: ColorTheme,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                            width: Get.width * 0.60,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 21,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: Get.width * 0.70,
                                  height: Get.height * 0.70,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          File(imageFileList[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                              ],
                            );
                          })),
                    ),
                  ),
                _wigetSend(),
                SizedBox(
                  height: Get.height * 0.05,
                ),
              ],
            ),
            if (wait)
              Container(
                  width: Get.width,
                  height: Get.height,
                  color: Color.fromARGB(10, 0, 0, 0),
                  child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
      AppBarTrueOrFalse: true,
      loding: false,
    );
  }

  Widget _wigetSend() {
    return InkWell(
      onTap: () async {
        setState(() {
          wait = true;
        });
        var ameen = await CreateProductApi.create(
            product_title.text.toString(),
            '1',
            product_description.text.toString(),
            product_price.text.toString(),
            product_location.text.toString(),
            product_sub_category.text.toString(),
            fid_3.text.toString(),
            typeText.toString(),
            imageFileList,
            product_utl.text);
        if (ameen['errors'] != null) {
          if (ameen['errors']['error_text'] ==
              'images (STREAM FILE) is missing')
            Get.snackbar('Error'.tr, 'Please add pictures of the product'.tr);
          if (ameen['errors']['error_text'] ==
              'product_title (POST) is missing')
            Get.snackbar('Error'.tr, 'Type in the product name'.tr);
          if (ameen['errors']['error_text'] ==
              'product_description (POST) is missing')
            Get.snackbar(
                'Error'.tr, 'Please write a description of the product');
          if (ameen['errors']['error_text'] ==
              'product_price (POST) is missing')
            Get.snackbar(
                'Error'.tr, 'Please write the price of the product'.tr);
          if (ameen['errors']['error_text'] ==
              'product_location (POST) is missing')
            Get.snackbar(
                'Error'.tr, 'Please write the location of the product');
          setState(() {
            wait = false;
          });
        }
        if (ameen['api_status'] == 200) {
          setState(() {
            wait = false;
          });
          Get.offAllNamed(AppRoutes.hoMeNavBar);
        }

        print(ameen);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        width: Get.width,
        decoration: BoxDecoration(
            color: ColorTheme, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Publish',
              style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
