import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class postYoutubeScreen extends StatelessWidget {
  postYoutubeScreen({super.key, required this.yout});
  final String yout;

  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController.fromVideoId(
        
        videoId: yout,
        
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      ),
      aspectRatio: 16 / 9,
    );
  }
}
