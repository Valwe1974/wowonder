import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class WithdarawalsScreen extends StatefulWidget {
  const WithdarawalsScreen({super.key});

  @override
  State<WithdarawalsScreen> createState() => _WithdarawalsScreenState();
}

class _WithdarawalsScreenState extends State<WithdarawalsScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(GetMyUserDataCont());
    return Scaffold(
        backgroundColor: Get.isDarkMode? ColorDarkBackground : Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Withdrawals'),
          backgroundColor:  Get.isDarkMode? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode? Colors.white : Colors.black,
        ),
        body: GetBuilder<GetMyUserDataCont>(
          init: GetMyUserDataCont(),
          builder: (controller) {
            return SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(

                    gradient: linearGradientBoxMore,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.07, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 31,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                maxRadius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    controller.data[controller.data.length - 1]
                                        .avatar),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text(
                              controller.data[controller.data.length - 1].name,
                              style: SafeGoogleFont(Fonts.font1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '\$${controller.data[controller.data.length - 1].balance}',
                              style: SafeGoogleFont(Fonts.font1,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'Current Balance',
                              style: SafeGoogleFont(Fonts.font3,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Withdrawals',
                        style: SafeGoogleFont(Fonts.font1,
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Text(
                        'Minimum Withdrawal request is \$${GetSetList[0]['m_withdrawal']}',
                        style: SafeGoogleFont(Fonts.font1,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Get.isDarkMode ? Colors.white: Colors.black),
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Center(
                        child: Container(
                          width: Get.width * 0.90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Get.isDarkMode
                                  ? ColorDarkTextBox
                                  : Colors.white,),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'PayPal',
                              style: SafeGoogleFont(Fonts.font2,
                                  color: Get.isDarkMode? Colors.white :Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Center(
                        child: Container(
                            width: Get.width * 0.90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:  Get.isDarkMode
                                    ? ColorDarkTextBox
                                    : Colors.white,),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              child: TextField(
                                decoration: InputDecoration(

                                    border: InputBorder.none,
                                    hintText: 'Amount'),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Center(
                        child: Container(
                            width: Get.width * 0.90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Get.isDarkMode
                                    ? ColorDarkTextBox
                                    : Colors.white,),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'PayPal E-mail'),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          if (GetSetList[0]['m_withdrawal'] ==
                              controller
                                  .data[controller.data.length - 1].balance) {
                            print('paypal');
                          } else {
                            Get.snackbar('Error',
                                'Your balance is less than \$${GetSetList[0]['m_withdrawal']}, this is the minimum withdrawal amount');
                          }
                        },
                        child: Center(
                          child: Container(
                            width: Get.width * 0.90,
                            decoration: BoxDecoration(
                              color: ColorTheme,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Center(
                                  child: Text(
                                'Requst Withdarawal',
                                style: SafeGoogleFont(Fonts.font1,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
          },
        ));
  }
}
