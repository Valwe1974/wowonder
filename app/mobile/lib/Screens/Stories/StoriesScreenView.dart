import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_video_player/native_video_player.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/NewStorey/examples/trays/adv_story_tray_customization.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserStoriesModel.dart';

int _timer = 5;

class StoriesScreenView extends StatefulWidget {
  const StoriesScreenView({
    required this.user_id,
    required this.stior,
    required this.i,
    Key? key,
  }) : super(key: key);
  final List<GetUserStoriesModel> stior;
  final int i;
  final user_id;
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoriesScreenView> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    // GetStories();
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();

    super.dispose();
  }

  bool isAutoplayEnabled = false;
  NativeVideoPlayerController? _controller;

  int onPlay = 0;
  String ameen = '0';
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: StoryPageView(
            onPageChanged: (va) async {
              _controller!.stop();
              if (va == widget.i) _controller!.play();
              print(_controller?.videoInfo?.duration.toString());
              // if (isAutoplayEnabled) {

              //   setState(() {
              //     isAutoplayEnabled = false;
              //     onPlay = va;
              //   });
              // }
              // ;
              // if (va > onPlay) {
              //   _controller!.play();
              //   setState(() {
              //     isAutoplayEnabled = true;
              //   });
              // }
            },
            initialPage: widget.i,
            showShadow: false,
            indicatorDuration: Duration(
                seconds: _controller?.videoInfo?.duration ?? Story_Max_Upload),
            itemBuilder: (
              context,
              pageIndex,
              storyIndex,
            ) {
              return Stack(
                children: [
                  Container(color: Colors.black),
                  if (widget
                      .stior[pageIndex].storiess[storyIndex].videos.isNotEmpty)
                    for (var i = 0;
                        i <
                            widget.stior[pageIndex].storiess[storyIndex].videos
                                .length;
                        i++)
                      Container(
                        height: Get.height,
                        child: Center(
                          child: NativeVideoPlayerView(
                            key: ValueKey(widget.stior[pageIndex]
                                .storiess[storyIndex].videos[i].filename),
                            onViewReady: (controller) async {
                              _controller = controller;
                              isAutoplayEnabled = true;
                              final videoSource = await VideoSource.init(
                                path: widget.stior[pageIndex]
                                    .storiess[storyIndex].videos[i].filename,
                                type: VideoSourceType.network,
                              );

                              await controller.loadVideoSource(videoSource);

                              await controller.play();
                              await controller.setVolume(1);
                            },
                          ),
                        ),
                      ),
                  if (widget.stior[pageIndex].storiess[storyIndex].videos.length
                          .toString() ==
                      '0')
                    Positioned.fill(
                        child: StoryImage(
                      /// key is required
                      key: ValueKey(
                        widget.stior[pageIndex].storiess[storyIndex].thumbnail,
                      ),
                      imageProvider: CachedNetworkImageProvider(
                        widget.stior[pageIndex].storiess[storyIndex].thumbnail,
                      ),
                      fit: BoxFit.fitWidth,
                    )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(),
                      Center(
                        child: Container(
                          width: Get.width * 0.80,
                          child: Center(
                              child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(57, 0, 0, 0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                widget.stior[pageIndex].storiess[storyIndex]
                                    .description,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 44, left: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(widget.stior[pageIndex].avatar),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(45, 0, 0, 0),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              widget.stior[pageIndex].name,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            gestureItemBuilder: (context, pageIndex, storyIndex) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  if (widget.user_id != widget.stior[pageIndex].user_id)
                    Positioned(bottom: Get.height * 0.01, child: MessageBox()),
                  if (widget.user_id == widget.stior[pageIndex].user_id)
                    Positioned(
                      bottom: Get.height * 0.01,
                      child: InkWell(
                        onTap: () {
                          print('object');
                          Get.bottomSheet(Container(
                            height: Get.height * 0.80,
                            width: Get.width,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ));
                        },
                        child: Container(
                          width: Get.width,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Text(widget.stior[pageIndex]
                                    .storiess[storyIndex].view_count
                                    .toString()),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Text('viewers'.tr,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700)),
                                Icon(Icons.arrow_drop_up_sharp)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
            pageLength: widget.stior.length,
            storyLength: (int pageIndex) {
              return widget.stior[pageIndex].storiess.length;
            },
            onPageLimitReached: () {
              
              Navigator.pop(context);
            },
          ),
        ));
  }
}
