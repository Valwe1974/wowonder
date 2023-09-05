import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/PhotoView.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAddImagesAlbum.dart';

class FetchImageAlbums extends StatefulWidget {
  FetchImageAlbums({
    super.key,
    required this.title,
    required this.GetData,
    required this.image,
    required this.id,
  });
  String title;
  final image;
  String id;
  dynamic GetData;

  @override
  State<FetchImageAlbums> createState() => _FetchImageAlbumsState();
}

class _FetchImageAlbumsState extends State<FetchImageAlbums> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(EditeAlbums(
                  id: widget.id,
                  albumName: widget.title,
                  type: 'add',
                  GetData: widget.GetData,
                ));
              },
              icon: Icon(Icons.edit))
        ],
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: widget.image.length,
          itemBuilder: ((context, index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: Get.height * 0.27,
                            width: Get.width,
                            child: InkWell(
                              onTap: () {
                                Get.to(NewWidget(
                                  photoMulti2: widget.image,
                                  photoMulti2Lin: index,
                                  delete: () async {
                                    final data = await ApiAddImagesAlbum.add(
                                        'delete_album_image',
                                        '',
                                        widget.image[index]['post_id'],
                                        widget.image[index]['id'],
                                        '');

                                    if (data['errors'] != null) {
                                      if (data['errors']['error_text']
                                              .toString() ==
                                          'album_name and postPhotos can not be empty')
                                        Get.snackbar(
                                            '',
                                            'album_name and postPhotos can not be empty'
                                                .tr);
                                    }
                                    print(data);
                                    widget.GetData();
                                    setState(() {
                                      widget.image.removeAt(index);
                                    });
                                  },
                                ));
                              },
                              child: CachedNetworkImage(
                                imageUrl: widget.image[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: InkWell(
                            onTap: () async {
                              final data = await ApiAddImagesAlbum.add(
                                  'delete_album_image',
                                  '',
                                  widget.image[index]['post_id'],
                                  widget.image[index]['id'],
                                  '');

                              if (data['errors'] != null) {
                                if (data['errors']['error_text'].toString() ==
                                    'album_name and postPhotos can not be empty')
                                  Get.snackbar(
                                      '',
                                      'album_name and postPhotos can not be empty'
                                          .tr);
                              }
                              print(data);
                              widget.GetData();
                              setState(() {
                                widget.image.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(51, 0, 0, 0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
                // children: [Image.network(widget.image[index]['image'])],
              )),
        ),
      ),
    );
  }
}

class EditeAlbums extends StatefulWidget {
  EditeAlbums({
    super.key,
    required this.id,
    this.GetData,
    required this.type,
    required this.albumName,
  });
  dynamic GetData;
  String type;
  String albumName;
  String id;

  @override
  State<EditeAlbums> createState() => _EditeAlbumsState();
}

class _EditeAlbumsState extends State<EditeAlbums> {
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
  void editeName() {
    setState(() {
      album_name.text = widget.albumName;
    });
  }

  @override
  void initState() {
    editeName();
    super.initState();
  }

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
                    widget.type, album_name.text, '', widget.id, imageFileList);

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
                if (data['api_status'] == 200) {
                  Get.back();
                  Get.back();
                }
              },
              icon: Icon(Icons.send)),
        ],
        centerTitle: false,
        title: Text(
          'Edit Album'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            InkWell(
              onTap: selectimges,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(68, 158, 158, 158),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.add,
                    size: 80,
                  ),
                ),
              ),
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
