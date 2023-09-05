import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreInfoProudct extends StatefulWidget {
  MoreInfoProudct({required this.product, super.key});

  final product;

  @override
  State<MoreInfoProudct> createState() => _MoreInfoProudctState();
}

class _MoreInfoProudctState extends State<MoreInfoProudct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: Get.height * 0.40,
                  flexibleSpace: FlexibleSpaceBar(
                    background: PageView.builder(
                        itemCount: widget.product['images'].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            widget.product['images'][index]['image'],
                            fit: BoxFit.cover,
                          );
                        }),
                  ),

                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 1,
                  centerTitle: false,
                  // bottom: Tab(child: _WidgetBotoomTapPar(cont2: cont2)),
                  floating: true,
                  snap: true,
                  // title: Text(
                  //   'Ameen',
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  actions: [],
                )
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product['name'],
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(widget.product['location'])
                          ],
                        ),
                        Text(
                          '\$' + widget.product['price'],
                          style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    Divider(),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Divider(),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      widget.product['edit_description'],
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(
                                  'Message'.tr,
                                  style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.orange[700],
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Text(
                              'Buy Now'.tr,
                              style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
