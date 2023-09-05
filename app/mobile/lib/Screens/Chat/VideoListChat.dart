import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoListChat extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const VideoListChat(
      {Key, key, required this.videoPlayerController, required this.looping})
      : super(key: key);

  @override
  _VideoListChatState createState() => _VideoListChatState();
}

class _VideoListChatState extends State<VideoListChat> {
  late ChewieController videosController;

  @override
  void initState() {
    super.initState();

    videosController = ChewieController(
      startAt: Duration.zero,
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return progressBar();
      },
    );
  }

  Widget progressBar() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black),
      height: Get.height * 0.40,
      width: Get.width * 0.60,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Chewie(
          controller: videosController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    videosController.dispose();
    super.dispose();
  }
}
