import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFetchAds.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/AdsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class AdvertisingScreen extends StatefulWidget {
  const AdvertisingScreen({super.key});

  @override
  State<AdvertisingScreen> createState() => _AdvertisingScreenState();
}

class _AdvertisingScreenState extends State<AdvertisingScreen> {
  List<AdsModel> data = [];
  void GetAds() {
    ApiFetchAds.Fetch().then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  @override
  void initState() {
    GetAds();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme,
        onPressed: () {},
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
      appBar: AppBar(
        actions: [],
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 15,
              backgroundColor: ColorTheme,
              child: Icon(
                Icons.campaign,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text('Campaigns')
          ],
        ),
        elevation: 0,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          for (var i = 0; i < data.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: Get.height * 0.1,
                                width: Get.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            data[i].ad_media))),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Ads(
                                    title2: data[i].name,
                                    title: 'Company'.tr,
                                  ),
                                  _Ads(
                                    title2: data[i].bidding,
                                    title: 'Bidding'.tr,
                                  ),
                                  _Ads(
                                    title2: data[i].clicks,
                                    title: 'Clicks'.tr,
                                  ),
                                  _Ads(
                                    title2: data[i].views,
                                    title: 'Views'.tr,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color.fromARGB(27, 92, 90, 90),
                                maxRadius: 20,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorTheme,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Actave',
                                    style: SafeGoogleFont(Fonts.font1,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          // for (var i = 0; i < data.length; i++)
          //   AdsWbeSite(
          //     ad_media: data[i].ad_media,
          //     biddingAds: data[i].bidding,
          //     descriptionAds: data[i].description,
          //     headline: data[i].headline,
          //     nameAds: data[i].name,
          //     urlss: data[i].url,
          //     user_dataAds: [],
          //   )
        ],
      )),
    );
  }
}

class _Ads extends StatelessWidget {
  const _Ads({
    super.key,
    required this.title,
    required this.title2,
  });
  final String title;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: SafeGoogleFont(Fonts.font1,
                fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          Text(
            ' : $title2',
            style: SafeGoogleFont(
              Fonts.font1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
