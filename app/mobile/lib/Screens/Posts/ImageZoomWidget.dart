import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomWidget extends StatefulWidget {
  String imageapi;
  String reaction;
  String comments;
  final islike;
  final contLike;
  final post_id;
  String type;
  final contcoment;
  ImageZoomWidget({
    required this.imageapi,
    required this.reaction,
    required this.comments,
    required this.islike,
    required this.type,
    required this.post_id,
    required this.contLike,
    required this.contcoment,
  });

  @override
  State<ImageZoomWidget> createState() => _ImageZoomWidgetState();
}

class _ImageZoomWidgetState extends State<ImageZoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomSheet: bottomSheet(
      //   reaction: widget.reaction,
      //   comments: widget.comments,
      //   contLike: widget.contLike,
      //   type: widget.type,
      //   islike: widget.islike,
      //   contcoment: widget.contcoment,
      //   post_id: widget.post_id,
      // ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       SvgPicture.asset('assets/images/SendImage.svg'),
          //       SizedBox(
          //         width: Get.width * 0.02,
          //       ),
          //       Icon(
          //         Icons.more_horiz_rounded,
          //         color: Colors.white,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
      body: Container(
        width: Get.width,
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.imageapi),
        ),
      ),
    );
  }
}

class bottomSheet extends StatelessWidget {
  String reaction;
  String comments;
  final islike;
  final contLike;
  final post_id;
  String type;
  final contcoment;
  bottomSheet({
    required this.reaction,
    required this.comments,
    required this.islike,
    required this.type,
    required this.post_id,
    required this.contLike,
    required this.contcoment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: Get.height * 0.14,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.022,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Like.svg',
                      color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    // LikeWidget(
                    //   contLike: contLike,
                    //   type: type,
                    //   islike: islike,
                    //   contcoment: contcoment,
                    //   post_id: post_id,
                    // ),
                    Text(
                      'Like'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: Get.width * 0.07,
                    ),
                    SvgPicture.asset(
                      'assets/images/Iconly-Light-Chat.svg',
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'Comment'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Send.svg',
                      color: Colors.white,
                      height: 17,
                      width: 17,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'Like'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Container(
            color: Colors.white,
            height: 1,
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/Like.svg',
                      color: Colors.grey,
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      '$reaction Reaction '.tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '$comments Comments'.tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      '0 Shares'.tr,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: Get.height * 0.02,
          // )
        ],
      ),
    );
  }
}
