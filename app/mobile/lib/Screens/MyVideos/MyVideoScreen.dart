import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetMyVideo.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';

import '../../ThemesWoWonder.dart';

class MyVideoScreen extends StatefulWidget {
  const MyVideoScreen({super.key});

  @override
  State<MyVideoScreen> createState() => _MyVideoScreenState();
}

class _MyVideoScreenState extends State<MyVideoScreen> {
  bool led = false;
  bool nodata = false;
  List<PostModel> data = [];
  void getmyvideo() async {
    setState(() {
      led = true;
    });
    ApiGetMyVideo.Getposts('0', 'video').then((value) {
      setState(() {
        data = value.toList();
        led = false;
        value.length > 0 ? '' : nodata = true;
      });
    });
  }

  @override
  void initState() {
    getmyvideo();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        centerTitle: false,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        title: Text('My Video'.tr),
      ),
      body: led
          ? Center(child: CircularProgressIndicator())
          : nodata
              ? Center(
                  child: NoChatScreen(
                    startChat: false,
                    textData: 'There are no videos'.tr,
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: data.length,
                  itemBuilder: ((context, index) => Column(
                        children: [
                          SizedBox(height: Get.height * 0.01),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.26,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(_widgetMyVideoScreen(
                                        avatar: data[index].avatar,
                                        user_id: data[index].user_id,
                                        post_id: data[index].post_id,
                                        postVideo: data[index].postFile,
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        color: Colors.grey,
                                        height: Get.height,
                                        width: Get.width,
                                        child: Stack(
                                          children: [
                                            //  fixed erorr images api
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                height: Get.height,
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    data[index].postFileThumb,
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Icon(
                                                    Icons.image,
                                                    size: 100,
                                                  );
                                                },
                                              ),
                                            ),
                                            Center(
                                              child: CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    182, 0, 0, 0),
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
    );
  }
}

class _widgetMyVideoScreen extends StatefulWidget {
  _widgetMyVideoScreen({
    required this.user_id,
    required this.post_id,
    required this.avatar,
    super.key,
    required this.postVideo,
  });
  String postVideo;
  String post_id;
  String user_id;
  String avatar;

  @override
  State<_widgetMyVideoScreen> createState() => __widgetMyVideoScreenState();
}

class __widgetMyVideoScreenState extends State<_widgetMyVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
            onPageChanged: (val) async {
              // cont.onLoding();
              // await [
              //   if (val == 0)
              //     {
              //       cont.onRefresh(),
              //       setState(() {
              //         val = 0;
              //       }),
              //     }
              // ];
            },
            controller: PageController(
              initialPage: 0,
              keepPage: false,
              viewportFraction: 1,
            ),
            itemCount: 1,
            scrollDirection: Axis.vertical,
            itemBuilder: ((context, index) {
              return Stack(
                textDirection: TextDirection.ltr,
                children: [
                  Center(
                      child: _VideoPlayTest(
                          post_id: widget.post_id, vid: widget.postVideo)),
                  Positioned(
                    bottom: Get.height * 0.1,
                    right: 20,
                    child: Column(
                      children: [
                        // LikeWidget(
                        //   like: cont.data[index].is_reacted,
                        //   count: cont.data[index].reaction,
                        //   post_id: cont.data[index].post_id,
                        // ),

                        SizedBox(
                          height: Get.height * 0.03,
                        ),

                        InkWell(
                          onTap: () {
                            // Get.dialog(GetCommentsScreen(
                            //   fetch_comments: 'fetch_comments',
                            //   create_reply: 'create',
                            //   post_id: widget.post_id,
                            // ));
                          },
                          child: Image.asset(
                            'assets/images/Iconly-Light-Chat.png',
                            color: Colors.white,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        // Text(
                        //   cont.data[index].comments_status,
                        //   style:
                        //       GoogleFonts.cabinCondensed(color: Colors.white),
                        // ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        // share-arrow-svgrepo-com.svg
                        SvgPicture.asset(
                          'assets/images/svg/share-arrow-svgrepo-com.svg',
                          color: Colors.white,
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            // Get.bottomSheet(WidgetMore(
                            //     hideid: () {
                            //       HidePostApi.hidepost(
                            //           cont.data[index].post_id);
                            //       cont.deltepost(index);
                            //     },
                            //     user_id: cont.data[index].user_id,
                            //     ontapreport: () {
                            //       cont.Rebort(cont.data[index].post_id);

                            //       Get.back(closeOverlays: true);
                            //     },
                            //     isadmin: false,
                            //     post_id: cont.data[index].post_id,
                            //     remove: () {
                            //       cont.PostDelte(
                            //           cont.data[index].post_id, index, context);
                            //     }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                                child: Icon(
                              Icons.more_horiz_outlined,
                              size: 30,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                ],
              );
            })),
      ),
    );
  }
}

class _VideoPlayTest extends StatefulWidget {
  _VideoPlayTest({required this.vid, required this.post_id, super.key});
  String vid;
  String post_id;

  @override
  State<_VideoPlayTest> createState() => __VideoPlayTestState();
}

class __VideoPlayTestState extends State<_VideoPlayTest> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.vid)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: videoPlayerController,
        customVideoPlayerSettings: _customVideoPlayerSettings);
    videoPlayerController.play();
  }

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
    //TODO: play around with these parameters
    autoFadeOutControls: false,
    controlBarAvailable: true,
    playbackSpeedButtonAvailable: false,
    // // controlBarMargin: const EdgeInsets.all(10),
    // controlBarPadding: const EdgeInsets.all(0),
    showPlayButton: false,
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
    controlBarDecoration: BoxDecoration(),
    settingsButton: SizedBox(),
    showFullscreenButton: false,
    showDurationPlayed: false,
    showDurationRemaining: true,
    //enterFullscreenOnStart: true,
    // exitFullscreenOnEnd: false,
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
    //   allowScrubbing: false,
    //   showProgressBar: false,
    // ),
  );

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              videoPlayerController.value.isPlaying
                  ? videoPlayerController.pause()
                  : videoPlayerController.play();
            });
          },
          child: CircleAvatar(
            maxRadius: videoPlayerController.value.isPlaying ? 300 : null,
            backgroundColor: videoPlayerController.value.isPlaying
                ? Color.fromARGB(0, 0, 0, 0)
                : Colors.black,
            child: videoPlayerController.value.isPlaying
                ? SizedBox()
                : Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }
}
