import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiOffers.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/OffersModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  List<OffersModel> ofr = [];
  void getOfers() {
    ApiOffers.ofse().then((value) {
      setState(() {
        ofr = value.toList();
      });
    });
  }

  @override
  void initState() {
    getOfers();
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScaffoldWidget(
        AppBarTrueOrFalse: true,
        title: 'Offers'.tr,
        centerTitle: false,
        elevation: 1,
        loding: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < ofr.length; i++)
                _widgetOffers(
                    image: ofr[i].image,
                    description: ofr[i].description,
                    time: ofr[i].expire_date,
                    offres: ofr[i].offer_text),
            ],
          ),
        ));
  }
}

class _widgetOffers extends StatelessWidget {
  const _widgetOffers({
    required this.description,
    required this.image,
    required this.time,
    required this.offres,
    super.key,
  });
  final String image;
  final String description;
  final String time;
  final String offres;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.30,
                height: Get.height * 0.15,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black, blurRadius: 4, spreadRadius: 1)
                  ],
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${offres} Offres',
                      style: SafeGoogleFont(Fonts.font1,
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: Get.width * 0.50,
                      child: Text(
                        description,
                        style: SafeGoogleFont(
                          Fonts.font2,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: Get.width * 0.50,
                child: Text(
                  'End Data : ${time}',
                  style: SafeGoogleFont(Fonts.font2,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 54, 91)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Divider()
      ],
    );
  }
}
