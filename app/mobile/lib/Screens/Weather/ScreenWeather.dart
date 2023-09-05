import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ScreenWeather extends StatefulWidget {
  @override
  _ScreenWeatherState createState() => _ScreenWeatherState();
}

class _ScreenWeatherState extends State<ScreenWeather> {
  //  return ListView.separated(
  //     itemCount: controller.dataWhait.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(controller.dataWhait[index].toString()),
  //       );
  //     },
  //     separatorBuilder: (context, index) {
  //       return Divider();
  //     },
  //   );

  Widget contentFinishedDownload() {
    return GetBuilder<SettingController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < controller.dataWhait.length; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.dataWhait[i].areaName.toString(),
                    style: SafeGoogleFont(
                      Fonts.font3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    controller.dataWhait[i].country.toString(),
                    style: SafeGoogleFont(
                      Fonts.font3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Stack(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        '${controller.dataWhait[i].temperature}',
                        style: SafeGoogleFont(
                          Fonts.font3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.00, top: Get.height * 0.01),
                          child: Column(
                            children: [
                              Text(
                                controller.dataWhait[i].weatherMain.toString(),
                                style: SafeGoogleFont(Fonts.font3,
                                    color: Colors.white),
                              ),
                              Image(
                                height: Get.height * 0.14,
                                image: AssetImage('assets/images/sunny.png'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${controller.dataWhait[i].date!.day.toString()}, ${controller.dataWhait[i].date!.year.toString()} ${controller.dataWhait[i].date!.month.toString()} | ${controller.dataWhait[i].date!.hour.toString() + ':' + controller.dataWhait[i].date!.minute.toString()}',
                    style: SafeGoogleFont(
                      Fonts.font3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: Get.height * 0.15,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5842A9),
      appBar: AppBar(
        backgroundColor: Color(0xff5842A9),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
            child: Align(
                alignment: Alignment.center, child: contentFinishedDownload())),
      ),
    );
  }
}
