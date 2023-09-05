import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class VideoFFmpeg extends StatefulWidget {
  final PostFile;
  final p360p;
  final p480p;
  final p240p;
  final p720p;
  final p1080p;
  final p2048p;
  final p4096p;
  const VideoFFmpeg(
      {Key? key,
      required this.p240p,
      required this.PostFile,
      required this.p1080p,
      required this.p2048p,
      required this.p360p,
      required this.p4096p,
      required this.p480p,
      required this.p720p})
      : super(key: key);

  @override
  State<VideoFFmpeg> createState() => _VideoFFmpegState();
}

String ffmpeg = '240p';

class _VideoFFmpegState extends State<VideoFFmpeg> {
  @override
  Widget build(BuildContext context) {
    var v4096p = '${widget.PostFile}'.replaceAll(RegExp('240p'), '4096p');
    var v2048p = '${widget.PostFile}'.replaceAll(RegExp('240p'), '2048p');
    var v1080 = '${widget.PostFile}'.replaceAll(RegExp('240p'), '1080p');
    var v720p = '${widget.PostFile}'.replaceAll(RegExp('240p'), '720p');
    var v480p = '${widget.PostFile}'.replaceAll(RegExp('240p'), '480p');
    var v360p = '${widget.PostFile}'.replaceAll(RegExp('240p'), '360p');
    var v240p = '${widget.PostFile}'.replaceAll(RegExp('240p'), '240p');

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        TestVidoPlyer(
          has240p: widget.p240p,
          v240p: v240p,
          audovid: widget.PostFile,
          v1080: v1080,
          v2048p: v2048p,
          v360p: v360p,
          v4096p: v4096p,
          v480p: v480p,
          v720p: v720p,
          has1080: widget.p1080p,
          has2048p: widget.p2048p,
          has360p: widget.p360p,
          has4096p: widget.p4096p,
          has480p: widget.p480p,
          has720p: widget.p720p,
        ),
      ],
    );
  }
}

class TestVidoPlyer extends StatefulWidget {
  String audovid;
  String v360p;
  String v480p;
  String v720p;
  String v1080;
  String v2048p;
  String v4096p;
  String v240p;
  final has240p;
  final has360p;
  final has480p;
  final has720p;
  final has1080;
  final has2048p;
  final has4096p;
  TestVidoPlyer(
      {Key? key,
      required this.has240p,
      required this.v240p,
      required this.has1080,
      required this.audovid,
      required this.v1080,
      required this.v2048p,
      required this.v360p,
      required this.v4096p,
      required this.v480p,
      required this.v720p,
      required this.has2048p,
      required this.has360p,
      required this.has4096p,
      required this.has480p,
      required this.has720p})
      : super(key: key);

  @override
  State<TestVidoPlyer> createState() => _TestVidoPlyerState();
}

class _TestVidoPlyerState extends State<TestVidoPlyer> {
  late VideoPlayerController _videoPlayerController,
      _videoPlayerController2,
      _videoPlayerController3,
      _videoPlayerController4,
      _videoPlayerController5,
      _videoPlayerController6,
      _videoPlayerController7,
      _videoPlayerController8;
  late CustomVideoPlayerController _customVideoPlayerController;
  bool _isDisposed = false;
  Completer<void>? _creatingCompleter;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
    //TODO: play around with these parameters
    // autoFadeOutControls: true,
    // controlBarAvailable: true,
    // playbackSpeedButtonAvailable: false,
    // // controlBarMargin: const EdgeInsets.all(10),
    // controlBarPadding: const EdgeInsets.all(0),
    // showPlayButton: true,
    // playButton: const Icon(
    //   Icons.play_circle,
    //   color: Colors.white,
    // ),
    // pauseButton: const Icon(
    //   Icons.pause_circle,
    //   color: Colors.white,
    // ),
    // enterFullscreenButton: const Icon(
    //   Icons.fullscreen,
    //   color: Colors.white,
    // ),
    // exitFullscreenButton: const Icon(
    //   Icons.fullscreen_exit,
    //   color: Colors.white,
    // ),
    controlBarDecoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20)),
      color: ColorTheme,
    ),
    //showFullscreenButton: false,
    // showDurationPlayed: false,
    // showDurationRemaining: false,
    //enterFullscreenOnStart: true,
    exitFullscreenOnEnd: true,
    // durationRemainingTextStyle: const TextStyle(color: Colors.black),
    // durationPlayedTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
    // systemUIModeAfterFullscreen: SystemUiMode.leanBack,
    // systemUIModeInsideFullscreen: SystemUiMode.edgeToEdge,
    // customVideoPlayerProgressBarSettings: CustomVideoPlayerProgressBarSettings(
    //   reachableProgressBarPadding: EdgeInsets.all(10),
    //   progressBarHeight: 10,
    //   progressBarBorderRadius: 30,
    //   bufferedColor: Colors.red,
    //   progressColor: Colors.green,
    //   backgroundColor: Colors.purple,
    //   allowScrubbing: true,
    //   showProgressBar: true,
    // ),
  );

  @override
  void initState() {
    playVid();
    super.initState();
  }

  void playVid() async {
    _videoPlayerController = VideoPlayerController.network(
      widget.audovid,
    )..initialize().then((value) => setState(() {}));
    _videoPlayerController2 = VideoPlayerController.network(widget.v360p);
    _videoPlayerController3 = VideoPlayerController.network(widget.v480p);

    _videoPlayerController4 = VideoPlayerController.network(widget.v720p);
    _videoPlayerController5 = VideoPlayerController.network(widget.v1080);
    _videoPlayerController6 = VideoPlayerController.network(widget.v2048p);
    _videoPlayerController7 = VideoPlayerController.network(widget.v4096p);
    _videoPlayerController8 = VideoPlayerController.network(widget.v4096p);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        if (widget.has4096p == '1') "4096p 4k": _videoPlayerController7,
        if (widget.has2048p == '1') "2048p 2K": _videoPlayerController6,
        if (widget.has1080 == '1') "1080p FHD": _videoPlayerController5,
        if (widget.has720p == '1') "720p HD": _videoPlayerController4,
        if (widget.has480p == '1') "480p": _videoPlayerController3,
        if (widget.has360p == '1') "360p": _videoPlayerController2,
        if (widget.has240p == '1') "240p": _videoPlayerController8,
        "Normal": _videoPlayerController,
      },
    );
  }

  @override
  void dispose() {
    if (_videoPlayerController.value.isPlaying) _videoPlayerController.pause();
    _videoPlayerController.removeListener(playVid);
    _videoPlayerController;
    super.dispose();
  }

  void killVidPlayer() {
    _customVideoPlayerController.dispose();
    _videoPlayerController.dispose();
    _videoPlayerController2.dispose();
    _videoPlayerController3.dispose();
    _videoPlayerController4.dispose();
    _videoPlayerController5.dispose();
    _videoPlayerController6.dispose();
    _videoPlayerController7.dispose();
    _videoPlayerController8.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController,
        ),
      ],
    );
  }
}
