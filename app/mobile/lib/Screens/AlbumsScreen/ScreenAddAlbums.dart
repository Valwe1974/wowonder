import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAddImagesAlbum.dart';

class ScreenAddAlbums extends StatefulWidget {
  ScreenAddAlbums({super.key, this.GetData, required this.type});
  dynamic GetData;
  String type;

  @override
  State<ScreenAddAlbums> createState() => _ScreenAddAlbumsState();
}

class _ScreenAddAlbumsState extends State<ScreenAddAlbums> {
  bool lod = false;
  List<XFile> imageFileList = [];

  final ImagePicker picker = ImagePicker();
  void selectimges() async {
    await Permission.storage.request();
    await Permission.photos.request();
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        imageFileList.addAll(selectedImages);
      });
    }
    print('images List Lenth' + imageFileList.length.toString());
  }

  TextEditingController album_name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  lod = true;
                });
                final data = await ApiAddImagesAlbum.add(
                    widget.type, album_name.text, '', '', imageFileList);

                if (data['errors'] != null) {
                  if (data['errors']['error_text'].toString() ==
                      'album_name and postPhotos can not be empty')
                    Get.snackbar(
                        '', 'album_name and postPhotos can not be empty'.tr);
                  setState(() {
                    lod = false;
                  });
                }
                if (data['api_status'] == 200) {
                  widget.GetData();
                  setState(() {
                    lod = false;
                  });
                }
                if (data['api_status'] == 200) Get.back();
              },
              icon: Icon(Icons.send)),
          IconButton(
            onPressed: selectimges,
            icon: Icon(Icons.add),
          )
        ],
        centerTitle: false,
        title: Text(
          'Add Album'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                'Album name'.tr,
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(68, 158, 158, 158),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextField(
                      controller: album_name,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            if (imageFileList.isNotEmpty)
              Container(
                height: Get.height * 0.70,
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: lod
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          scrollDirection: Axis.vertical,
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
            // Container(
            //   decoration: BoxDecoration(
            //     color: colorTextBordingDark1,
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text('Post'),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
