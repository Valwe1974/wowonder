import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/AlbumsScreen/FetchImageAlbums.dart';
import 'package:wowondertimelineflutterapp/Screens/AlbumsScreen/ScreenAddAlbums.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetAlbums.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAlbumsModel.dart';
import 'package:wowondertimelineflutterapp/Widget/NotFoundWidget.dart';

class AlbumsScreen extends StatefulWidget {
  AlbumsScreen({required this.title, super.key});
  String title;

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  bool lod = true;
  bool nodata = true;
  List<GetAlbumsModel> data = [];
  void GetData() {
    ApiGetAlbums.GetBlock().then((value) => {
          setState(() {
            data = value.toList();
            lod = false;
            if (value.length > 0) nodata = false;
            if (value.length < 0) nodata = true;
          }),
        });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text('Albums'.tr),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Get.to(ScreenAddAlbums(
                  type: 'create',
                  GetData: GetData,
                ));
              },
              icon: Icon(Icons.add),
            ),
          )
        ],
      )),
      body: lod
          ? Center(child: CircularProgressIndicator())
          : nodata
              ? NotFoundWidget(text: 'no albums'.tr)
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.length,
                  itemBuilder: ((context, index) => Column(
                        children: [
                          SizedBox(height: Get.height * 0.01),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.26,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(FetchImageAlbums(
                                        GetData: GetData,
                                        id: data[index].id,
                                        image: data[index].photo_album,
                                        title: data[index].album_name,
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: Get.height,
                                        width: Get.width,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                  height: Get.height,
                                                  width: Get.width,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      data[index].first_image),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                width: Get.width,
                                                height: Get.height * 0.07,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Color.fromARGB(
                                                      84, 0, 0, 0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        data[index].album_name,
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                      ),
                                                      Text(
                                                        data[index]
                                                            .photo_album
                                                            .length
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
    );
  }
}
