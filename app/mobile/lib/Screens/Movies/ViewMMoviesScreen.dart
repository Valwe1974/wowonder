import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/postYoutubeScree.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Widget/VideoFmmpeg.dart';

class ViewMMoviesScreen extends StatefulWidget {
  const ViewMMoviesScreen({
    super.key,
    required this.source,
    required this.title,
    required this.iframe,
    required this.description,
  });
  final String title;
  final String iframe;
  final String source;
  final String description;
  @override
  State<ViewMMoviesScreen> createState() => _ViewMMoviesScreenState();
}

class _ViewMMoviesScreenState extends State<ViewMMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      AppBarTrueOrFalse: true,
      title: widget.title,
      centerTitle: true,
      elevation: 0,
      loding: false,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.iframe.isNotEmpty) video(),
          if (widget.source.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: VideoFFmpeg(
                  PostFile: widget.source,
                  p720p: '',
                  p480p: '',
                  p1080p: '',
                  p240p: '',
                  p360p: '',
                  p4096p: '',
                  p2048p: '',
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'description',
              style: SafeGoogleFont(Fonts.font2,
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          //"https://player.vimeo.com/video/392669912",
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: Get.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.description),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget video() {
    if (widget.iframe.isURL) {
      return VimeoVideoPlayer(
          url:
              widget.iframe.replaceAll('player.', '').replaceAll('/video', ''));
    } else {
      return postYoutubeScreen(
        yout: widget.iframe,
      );
    }
    ;
  }
}
