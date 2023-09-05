import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPayPro.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ScreenPackages extends StatefulWidget {
  const ScreenPackages({super.key});

  @override
  State<ScreenPackages> createState() => _ScreenPackagesState();
}

class _ScreenPackagesState extends State<ScreenPackages> {
  final listsss = GetSetList[0]['pro_packages'];
  @override
  void initState() {
    var cont = Get.put(GetMyUserDataCont());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor:  Get.isDarkMode ? Colors.white : Colors.black,
        title: Text('Pro Packages'),
      ),
      body: Container(
        width: Get.width,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.07,
              ),
              _Pacge(
                color: listsss['1']['color'],
                title: listsss['1']['type'],
                price: '\$${listsss['1']['price']} ${listsss['1']['time']}',
                trufalse: false,
                listsss: listsss['1'],
              ),
              _Pacge(
                color: listsss['2']['color'],
                title: listsss['2']['type'],
                price: '\$${listsss['2']['price']} ${listsss['2']['time']}',
                trufalse: false,
                listsss: listsss['2'],
              ),
              _Pacge(
                listsss: listsss['3'],
                color: listsss['3']['color'],
                title: listsss['3']['type'],
                price: '\$${listsss['3']['price']} ${listsss['3']['time']}',
                trufalse: false,
              ),
              _Pacge(
                listsss: listsss['4'],
                color: listsss['4']['color'],
                title: listsss['4']['type'],
                price: '\$${listsss['4']['price']} ${listsss['4']['time']}',
                trufalse: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pacge extends StatefulWidget {
  _Pacge({
    super.key,
    required this.title,
    required this.price,
    required this.color,
    required this.trufalse,
    required this.listsss,
  });
  final String title;
  final String price;
  final String color;
  final listsss;
  bool trufalse;

  @override
  State<_Pacge> createState() => _PacgeState();
}

class _PacgeState extends State<_Pacge> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.trufalse = !widget.trufalse;
          print(widget.trufalse);
        });
      },
      child: Container(
        width: Get.width * 0.90,
        child: Stack(
          children: [
            if (widget.trufalse == false)
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Container(
                    width: Get.width * 0.90,
                    height: Get.height * 0.15,
                    decoration: ShapeDecoration(
                      color: Color(
                          int.parse(widget.color.replaceAll('#', '0xff'))),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: Get.width * 0.02,),
                                  CircleAvatar(
                                    maxRadius: 30,
                                  ),
                                  SizedBox(width: Get.width * 0.02,),
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                child: Text(
                                  widget.price,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            if (widget.trufalse == true)
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Container(
                    width: Get.width * 0.90,
                    decoration: ShapeDecoration(
                      color: Color(
                          int.parse(widget.color.replaceAll('#', '0xff'))),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 30),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 30,
                                  ),
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: Text(
                                  widget.price,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            _ChekBox(
                              title: 'Featured member',
                              value: widget.listsss['featured_member'] == '0'
                                  ? false
                                  : true,
                            ),
                            _ChekBox(
                              title: 'See profile visitors',
                              value: widget.listsss['profile_visitors'] == '0'
                                  ? false
                                  : true,
                            ),
                            _ChekBox(
                              title: 'Show / Hide last seen',
                              value: widget.listsss['last_seen'] == '0'
                                  ? false
                                  : true,
                            ),
                            _ChekBox(
                              title: 'Verified badge',
                              value: widget.listsss['verified_badge'] == '0'
                                  ? false
                                  : true,
                            ),
                            _promotion(
                              title: 'Posts promotion',
                              promotion: widget.listsss['posts_promotion'] ==
                                      '0'
                                  ? 'X'
                                  : '${widget.listsss['posts_promotion']} Posts',
                            ),
                            _promotion(
                              title: 'Pages promotion',
                              promotion: widget.listsss['pages_promotion'] ==
                                      '0'
                                  ? 'X'
                                  : '${widget.listsss['pages_promotion']} Pages',
                            ),
                            _promotion(
                              title: 'Discount',
                              promotion: widget.listsss['discount'] == '0'
                                  ? 'X'
                                  : '${widget.listsss['discount']} Pages',
                            ),
                            _promotion(
                                title: 'Max upload size',
                                promotion:
                                    '${int.parse(widget.listsss['max_upload']) / 1000000} MB'),
                            _promotion(
                                title: 'Packages',
                                promotion: widget.listsss['description']),
                          ],
                        ),
                        GetX<GetMyUserDataCont>(
                          init: GetMyUserDataCont(),
                          builder: (controller) {
                            return InkWell(
                              onTap: () async {
                                controller.isloding.value = true;
                                if (controller.data[controller.data.length - 1]
                                        .pro_type ==
                                    widget.listsss['id']) {
                                  controller.isloding.value = false;
                                } else {
                                  var pay = await ApiPayPro.pay(
                                      p: widget.listsss[accounts[0]['is']]);
                                  if (pay['api_status'] == '400') {
                                    Get.snackbar(
                                      snackPosition: SnackPosition.BOTTOM,
                                      'Error',
                                      'You do not have enough balance to purchase the package ${widget.listsss['type']}',
                                      colorText: Colors.black,
                                    );
                                  } else if (pay['api_status'] == 200) {
                                    print('done');
                                    print(pay);
                                    Get.snackbar('Done',
                                        ' upgraded to pro ${widget.listsss['type']}');
                                  }
                                  controller.updi();
                                  controller.isloding.value = false;
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade200
                                                    .withOpacity(0.5),
                                                blurRadius: 1,
                                                spreadRadius: 5)
                                          ]),
                                      child: controller.isloding.value
                                          ? Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                controller
                                                            .data[controller
                                                                    .data
                                                                    .length -
                                                                1]
                                                            .pro_type ==
                                                        widget.listsss['id']
                                                    ? 'You are subscribed'
                                                    : 'Upgrade Now',
                                                style: SafeGoogleFont(
                                                    Fonts.font2,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            Positioned(
                bottom: 30,
                right: Get.width * 0.06,
                child: Image.asset('assets/ImageNew/Expand_down_double.png'))
          ],
        ),
      ),
    );
  }
}

class _ChekBox extends StatelessWidget {
  const _ChekBox({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: SafeGoogleFont(Fonts.font1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Checkbox(autofocus: false, value: value, onChanged: (val) {}),
            ],
          ),
          Divider(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class _promotion extends StatelessWidget {
  const _promotion({
    super.key,
    required this.title,
    required this.promotion,
  });

  final String title;
  final promotion;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: SafeGoogleFont(Fonts.font1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  promotion.toString(),
                  style: SafeGoogleFont(Fonts.font1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
