import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Events/EventsAddScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Events/EventsFetchScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetEvents.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetEventsModel.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<GetEventsModel> data = [];
  void getevent() {
    ApiGetEvents.fetch().then((value) => {
          setState(() {
            data = value.toList();
          }),
        });
  }

  @override
  void initState() {
    getevent();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        elevation: 0,
        centerTitle: false,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        title: Text('Events'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(EventsAddScreen(
                updite: getevent,
              ));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
              children: List.generate(
                  data.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(EventsFetchScreen(
                              end_date: data[index].end_date,
                              start_date: data[index].start_date,
                              location: data[index].location,
                              descirp: data[index].description,
                              imagee: data[index].cover,
                              title: data[index].name,
                              interested: data[index].interested_count,
                              is_interested: data[index].is_interested,
                              is_going: data[index].is_going,
                              going: data[index].going_count,
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(61, 255, 255, 255)
                                  : Color.fromARGB(26, 0, 0, 0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : Color.fromARGB(55, 245, 234, 234)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black,
                                                  ),
                                                  height: Get.height * 0.2,
                                                  width: Get.width * 0.4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.3),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl: data[
                                                                        index]
                                                                    .cover)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  right: 0,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: ColorTheme,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(7.0),
                                                        child: Text(
                                                          'Event'.tr,
                                                          style:
                                                              GoogleFonts.cairo(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            data[index].name,
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          // child: Html(
                                          //   data: data[index].description,

                                          // ),
                                          child: Text(
                                            data[index].description,
                                            maxLines: 1,
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: ColorTheme,
                                                  ),
                                                  Text(
                                                    data[index].start_date,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: ColorTheme,
                                                  ),
                                                  Container(
                                                    width: Get.width * 0.40,
                                                    child: Text(
                                                        data[index].location,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )))),
    );
  }
}
