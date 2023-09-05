import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class EventsFetchScreen extends StatefulWidget {
  EventsFetchScreen(
      {super.key,
      required this.going,
      required this.interested,
      required this.descirp,
      required this.start_date,
      required this.end_date,
      required this.title,
      required this.imagee,
      required this.location,
      required this.is_interested,
      required this.is_going});
  String start_date;
  String end_date;
  String title;
  String imagee;
  String descirp;
  String location;
  String interested;
  final going;
  bool is_going;
  bool is_interested;

  @override
  State<EventsFetchScreen> createState() => _EventsFetchScreenState();
}

class _EventsFetchScreenState extends State<EventsFetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: Get.height * 0.30,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.imagee,
                ),
              ),
              Positioned(
                left: 2,
                right: 2,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(119, 0, 0, 0),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Start Date'.tr,
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(119, 0, 0, 0),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              widget.start_date,
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(119, 0, 0, 0),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'End Date'.tr,
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(119, 0, 0, 0),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              widget.end_date,
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            Container(
                color: Color.fromARGB(22, 147, 146, 146),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          widget.title,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.is_going = !widget.is_going;
                              });
                            },
                            child: Container(
                              width: Get.width * 0.40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: widget.is_going
                                      ? Colors.blue
                                      : ColorTheme),
                              child: Center(
                                  child: Text(
                                widget.is_going ? 'Going'.tr : 'Go'.tr,
                                style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.is_interested = !widget.is_interested;
                              });
                            },
                            child: Container(
                              width: Get.width * 0.40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: widget.is_interested
                                      ? Colors.blue
                                      : ColorTheme),
                              child: Center(
                                  child: Text(
                                'Interested',
                                style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              color: Color.fromARGB(22, 147, 146, 146),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'People Going'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700, color: ColorTheme),
                        ),
                        Text(
                          widget.going,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'People Interested'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w700, color: ColorTheme),
                        ),
                        Text(
                          widget.interested,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: Get.width,
              color: Color.fromARGB(22, 147, 146, 146),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Event Description'.tr,
                      style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme),
                    ),
                  ),
                  Html(
                    data: widget.descirp,
                  )
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              color: Color.fromARGB(22, 147, 146, 146),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Location'.tr,
                      style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Container(
                          width: Get.width * 0.80,
                          child: Text(
                            widget.location,
                            style: GoogleFonts.cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
