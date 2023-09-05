import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Movies/ViewMMoviesScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiMovies.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/MoviesModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/NotFoundWidget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool lod = false;
  bool noData = false;
  List<MoviesModel> data = [];

  void getMove() {
    setState(() {
      lod = true;
    });
    ApiMovies.get().then((value) {
      setState(() {
        data = value.toList();
        lod = false;
        value.length > 0 ? noData = false : noData = true;
      });
    });
  }

  int dot = 0;
  @override
  void initState() {
    getMove();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            'Movies'.tr,
            style: SafeGoogleFont(Fonts.font1,
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: lod
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : noData
                ? NotFoundWidget(text: 'There are no movies'.tr)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: Get.width * 80,
                          height: Get.height * 0.50,
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: PageController(initialPage: dot),
                                onPageChanged: (val) {
                                  setState(() {
                                    dot = val;
                                  });
                                },
                                itemBuilder: ((context, index) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: Get.height,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(ViewMMoviesScreen(
                                                  source: data[dot].source,
                                                  title: data[dot].name,
                                                  iframe: data[dot]
                                                      .iframe
                                                      .replaceAll(
                                                          'https://www.youtube.com/embed/',
                                                          ''),
                                                  description:
                                                      data[dot].description));
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: data[dot].cover,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: Get.width * 0.1,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    169, 49, 22, 199),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  data[index].name,
                                                  style: SafeGoogleFont(
                                                      Fonts.font2,
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 0),
                                                    ),
                                                  ),
                                                  Text(
                                                    '10/${data[index].rating}',
                                                    style: SafeGoogleFont(
                                                        Fonts.font2,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                itemCount: data.length,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (var i = 0; i < data.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                height: Get.height * 0.02,
                                width: Get.width * 0.02,
                                decoration: BoxDecoration(
                                    color: i == dot ? ColorTheme : Colors.grey,
                                    shape: BoxShape.circle),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Watching'.tr,
                              style: SafeGoogleFont(Fonts.font2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                for (var i = 0; i < data.length; i++)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        dot = i;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Container(
                                              width: Get.width * 0.35,
                                              height: Get.height * 0.27,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data[i].cover,
                                                    fit: BoxFit.cover,
                                                  ))),
                                        ),
                                        Text(
                                          data[i].name,
                                          style: SafeGoogleFont(Fonts.font1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                              ]),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
      ),
    );
  }
}

class _text extends StatelessWidget {
  const _text({
    required this.titleMove,
    required this.title,
    super.key,
  });

  final String titleMove;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: SafeGoogleFont(
                Fonts.font1,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Divider(),
            Container(
              width: Get.width * 0.40,
              child: Text(
                titleMove,
                style: SafeGoogleFont(Fonts.font1,
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
