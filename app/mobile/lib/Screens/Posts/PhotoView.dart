import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({
    super.key,
    required this.photoMulti2,
    required this.contLike,
    required this.contcoment,
    required this.postimage,
    required this.type,
    required this.islike,
    required this.post_id,
  });

  final photoMulti2;
  final contLike;
  final contcoment;
  final postimage;
  final type;
  final islike;
  final post_id;

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  int dot = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 80,
          height: Get.height * 0.40,
          child: PageView.builder(
            onPageChanged: (val) {
              setState(() {
                dot = val;
              });
            },
            itemBuilder: ((context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Get.to(NewWidget(
                      photoMulti2: widget.photoMulti2,
                      photoMulti2Lin: index,
                    ));
                  },
                  child: CachedNetworkImage(
                    width: Get.width * 80,
                    height: Get.height * 0.30,
                    imageUrl: widget.photoMulti2[index]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
            itemCount: widget.photoMulti2.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.photoMulti2.length; i++)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: Get.height * 0.02,
                  width: Get.width * 0.02,
                  decoration: BoxDecoration(
                      color: i == dot ? ColorTheme : Colors.grey,
                      shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    required this.photoMulti2Lin,
    super.key,
    this.ontap,
    this.delete,
    required this.photoMulti2,
  });
  final photoMulti2Lin;
  final photoMulti2;
  final delete;
  final ontap;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          actions: [
            if (widget.delete != null)
              IconButton(
                  onPressed: widget.delete,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ))
          ],
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: PageView.builder(
            controller: PageController(
              initialPage: widget.photoMulti2Lin.toInt(),
            ),
            pageSnapping: true,
            onPageChanged: (value) {},
            padEnds: false,
            itemCount: widget.photoMulti2.length,
            itemBuilder: (BuildContext context, int index) {
              return PhotoView(
                imageProvider: NetworkImage(widget.photoMulti2[index]['image']),
              );
            },
          ),
        ));
  }
}
