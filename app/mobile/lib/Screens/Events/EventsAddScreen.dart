import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCreateEvent.dart';

class EventsAddScreen extends StatefulWidget {
  EventsAddScreen({super.key, required this.updite});
  dynamic updite;

  @override
  State<EventsAddScreen> createState() => _EventsAddScreenState();
}

class _EventsAddScreenState extends State<EventsAddScreen> {
  bool lod = false;
  PageController _pageController = PageController();
  int page = 0;
  TextEditingController event_name = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  void _Finsh() async {
    setState(() {
      lod = true;
    });
    var prinApi = await ApiCreateEvent.send(
        event_name.text,
        location.text,
        description.text,
        startDate.text,
        endDate.text,
        startTime.text,
        endTime.text,
        ImagePost == null ? '' : ImagePost!.path);
    if (prinApi['api_status'] == 200) {
      widget.updite();
      Get.back();
      setState(() {
        lod = false;
      });
    }
    if (prinApi['api_status'] == '400') {
      setState(() {
        lod = false;
      });
      Get.snackbar('', prinApi['errors']['error_text']);
    }
  }

  //Uplde Image
  final ImagePicker picker = ImagePicker();
  XFile? ImagePost;
  Future<void> UplodeImage() async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print(picker);
    setState(() {
      ImagePost = image;
    });
    print(ImagePost!.path);
  }

/////
  ///start
  ///
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            useRootNavigator: true,
            lastDate: DateTime(2099))
        .then((value) {
      setState(() {
        print(value!.year);
        int mont = 100;
        if (value.month < 10) mont = 0;

        startDate.text =
            '${value.year}-${mont == 100 ? '' : mont}${value.month}-${value.day}';
      });
    });
  }

  TimeOfDay _timeOfDay =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  // Show the modal that contains the CupertinoDatePicker
  void _startTime() async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    print(newTime!.minute);
    setState(() {
      startTime.text = '${newTime.hour}:${newTime.minute}';
    });
  }

  ///
  ///
  ///
  ///
  ///
  ///End
  /////
  ///start
  ///
  void _showDatePickerEnd() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            useRootNavigator: true,
            lastDate: DateTime(2099))
        .then((value) {
      setState(() {
        print(value!.year);
        int mont = 100;
        if (value.month < 10) mont = 0;

        endDate.text =
            '${value.year}-${mont == 100 ? '' : mont}${value.month}-${value.day}';
      });
    });
  }

  TimeOfDay _timeOfDayEnd =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  // Show the modal that contains the CupertinoDatePicker
  void _EndTime() async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    print(newTime!.minute);
    setState(() {
      endTime.text = '${newTime.hour}:${newTime.minute}';
    });
  }

  ///

  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        elevation: 2,
        centerTitle: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Create Event'.tr),
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Setp ${page}/5',
                    style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StepProgressIndicator(
                    totalSteps: 5,
                    currentStep: page,
                    size: 10,
                    padding: 1,
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.cyan,
                    roundedEdges: Radius.circular(10),
                    selectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.red, Colors.red],
                    ),
                    unselectedGradientColor: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.blue],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(51, 158, 158, 158),
            height: Get.height * 0.01,
            width: Get.width,
          ),
          Container(
            width: Get.width,
            height: Get.height * 0.30,
            child: PageView(
                onPageChanged: (val) {
                  setState(() {
                    page = val.toInt();
                  });
                },
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Name'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Colors.red
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                controller: event_name,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///2

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 56, 55, 55)
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                controller: startDate,
                                onTap: _showDatePicker,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Start Time'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 56, 55, 55)
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                controller: startTime,
                                onTap: _startTime,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //endtine

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 56, 55, 55)
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                onTap: _showDatePickerEnd,
                                controller: endDate,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'End Time'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 56, 55, 55)
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                onTap: _EndTime,
                                controller: endTime,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
//images
                  if (ImagePost != null)
                    InkWell(
                      onTap: UplodeImage,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: Get.width,
                            height: Get.height,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(ImagePost!.path),
                                  fit: BoxFit.cover,
                                ))),
                      ),
                    ),
                  if (ImagePost == null)
                    InkWell(
                      onTap: UplodeImage,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Get.height * 0.20,
                          width: Get.width * 0.20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey,
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            size: 100,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  ///location
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          'Location'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 56, 55, 55)
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                controller: location,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///finsh
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Text(
                          'Event Desctiprion'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Get.isDarkMode
                                  ? Color.fromARGB(255, 56, 55, 55)
                                  : Color.fromARGB(28, 0, 0, 0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              height: Get.height * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              width: Get.width,
                              child: TextField(
                                controller: description,
                                maxLines: null,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          if (lod) CircularProgressIndicator(),
          if (page > 4)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: backPage,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width * 0.40,
                      decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        'Back'.tr,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: _Finsh,
                  child: Container(
                    width: Get.width * 0.50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ColorTheme,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          'Finish'.tr,
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (page < 5)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (page > 0)
                      InkWell(
                        onTap: backPage,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: Get.width * 0.40,
                            decoration: BoxDecoration(
                              color: ColorTheme,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              'Back'.tr,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: nextPage,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: page > 0 ? Get.width * 0.40 : Get.width * 0.90,
                          decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            'Next'.tr,
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }

  void nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void backPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
