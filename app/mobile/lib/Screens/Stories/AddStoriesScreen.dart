import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helpers/helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_editor/video_editor.dart';
import 'package:vs_story_designer/vs_story_designer.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCreateStores.dart';

// import 'package:vs_story_designer/vs_story_designer.dart';

class AddStoriesScreen extends StatefulWidget {
  const AddStoriesScreen({super.key});

  @override
  State<AddStoriesScreen> createState() => _AddStoriesScreenState();
}

class _AddStoriesScreenState extends State<AddStoriesScreen> {
  final ImagePicker _picker = ImagePicker();

  void _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);

    if (mounted && file != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => VideoEditor(file: File(file.path)),
        ),
      );
    }
  }

  XFile? ImagePost;
  final ImagePicker picker = ImagePicker();
  Future<void> UplodeImage(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);

    print(picker);
    setState(() {
      ImagePost = image;
    });
    if (ImagePost != null)
      Get.dialog(Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back(closeOverlays: true);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_sharp)),
                    InkWell(
                      onTap: () async {
                        await ApiCreateStores.send(ImagePost!.path, 'image');
                        Get.back(closeOverlays: true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorTextBoardingDark1,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Post'.tr,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: Get.height * 0.70,
                width: Get.width,
                child: Image.file(
                  File(ImagePost!.path),
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ));
    print(ImagePost!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.30,
      decoration: BoxDecoration(
          color:
              Get.isDarkMode ? Color.fromARGB(255, 31, 30, 30) : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 15,
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.04),
            InkWell(
              onTap: () async {
                String? mediaPath = await _prepareImage();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VSStoryDesigner(
                              galleryThumbnailQuality: 1028,
                              onDoneButtonStyle: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              centerText: "Start Creating Your Story".tr,
                              middleBottomWidget: Column(
                                children: [
                                  Icon(Icons.file_download),
                                  Text(
                                    'Swipe the screen to add a photo'.tr,
                                    style:
                                        GoogleFonts.cairo(color: Colors.white),
                                  ),
                                ],
                              ),
                              themeType: ThemeType
                                  .light, // OPTIONAL, Default ThemeType.dark
                              // galleryThumbnailQuality: 250,
                              onDone: (uri) async {
                                if (uri.isNotEmpty) {
                                  await ApiCreateStores.send(uri, 'image');
                                  Get.back(closeOverlays: true);
                                  Get.back();
                                }
                                // ignore: deprecated_member_use
                              },
                              mediaPath: mediaPath,
                            )));
              },
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/SDF.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Images / Gallery'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            InkWell(
              onTap: _pickVideo,
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.14,
                    decoration: BoxDecoration(
                        color: Color(0xffFEEEF0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Image.asset(
                          'assets/images/youtube.png',
                          color: colorTextBoardingDark1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Text(
                    'Video / Gallery'.tr,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GlobalKey _globalKey = new GlobalKey();

  Future<String?> _prepareImage() async {
    ByteData? byteData;

    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      ui.Image? image = await boundary?.toImage();
      byteData = await image?.toByteData(format: ui.ImageByteFormat.png);
      Uint8List bytes = byteData!.buffer.asUint8List();

      final directory = (await getTemporaryDirectory()).path;
      String imgPath = '$directory/${Random().nextInt(999999)}.jpg';
      File imgFile = new File(imgPath);
      await imgFile.writeAsBytes(bytes);
      return imgFile.path;
    } catch (e) {
      return null;
    }
  }
}

// //-------------------//
// //VIDEO EDITOR SCREEN//
// //-------------------//
class VideoEditor extends StatefulWidget {
  const VideoEditor({super.key, required this.file});

  final File file;

  @override
  State<VideoEditor> createState() => _VideoEditorState();
}

class _VideoEditorState extends State<VideoEditor> {
  final _exportingProgress = ValueNotifier<double>(0.0);
  final _isExporting = ValueNotifier<bool>(false);
  final double height = 60;

  late final VideoEditorController _controller = VideoEditorController.file(
    widget.file,
    minDuration: Duration(seconds: 1),
    maxDuration: Duration(seconds: Story_Max_Upload),
  );

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) => setState(() {})).catchError((error) {
      // handle minumum duration bigger than video duration error
      Navigator.pop(context);
    }, test: (e) => e is VideoMinDurationError);
  }

  @override
  void dispose() {
    _exportingProgress.dispose();
    _isExporting.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  void _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;
    await _controller.exportVideo(
      onProgress: (stats, value) => _exportingProgress.value = value,
      onError: (e, s) => _showErrorSnackBar("Error on export video :("),
      onCompleted: (file) async {
        _isExporting.value = false;
        if (!mounted) return;
        Get.back();
        await ApiCreateStores.send(file.path, 'video');
      },
    );
  }

  // void _exportCover() async {
  //   await _controller.extractCover(
  //     onError: (e, s) => _showErrorSnackBar("Error on cover exportation :("),
  //     onCompleted: (cover) {
  //       if (!mounted) return;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _controller.initialized
            ? SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _topNavBar(),
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CropGridViewer.preview(
                                              controller: _controller),
                                          AnimatedBuilder(
                                            animation: _controller.video,
                                            builder: (_, __) =>
                                                OpacityTransition(
                                              visible: !_controller.isPlaying,
                                              child: GestureDetector(
                                                onTap: _controller.video.play,
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // CoverViewer(controller: _controller)
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      TabBar(
                                        tabs: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: Icon(
                                                        Icons.content_cut)),
                                                Text('Trim')
                                              ]),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: const [
                                          //     Padding(
                                          //         padding: EdgeInsets.all(5),
                                          //         child:
                                          //             Icon(Icons.video_label)),
                                          //     Text('Cover')
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: _trimSlider(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _isExporting,
                                  builder: (_, bool export, __) =>
                                      OpacityTransition(
                                    visible: export,
                                    child: AlertDialog(
                                      title: ValueListenableBuilder(
                                        valueListenable: _exportingProgress,
                                        builder: (_, double value, __) => Text(
                                          "Exporting video ${(value * 100).ceil()}%",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _topNavBar() {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Leave editor',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.left),
                icon: const Icon(Icons.rotate_left),
                tooltip: 'Rotate unclockwise',
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    _controller.rotate90Degrees(RotateDirection.right),
                icon: const Icon(Icons.rotate_right),
                tooltip: 'Rotate clockwise',
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.crop),
                tooltip: 'Open crop screen',
              ),
            ),
            const VerticalDivider(endIndent: 22, indent: 22),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _exportVideo,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorTheme,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Post',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatter(Duration duration) => [
        duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
        duration.inSeconds.remainder(60).toString().padLeft(2, '0')
      ].join(":");

  List<Widget> _trimSlider() {
    return [
      AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _controller.video,
        ]),
        builder: (_, __) {
          final duration = _controller.videoDuration.inSeconds;
          final pos = _controller.trimPosition * duration;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: height / 4),
            child: Row(children: [
              Text(formatter(Duration(seconds: pos.toInt()))),
              const Expanded(child: SizedBox()),
              OpacityTransition(
                visible: _controller.isTrimming,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(formatter(_controller.startTrim)),
                  const SizedBox(width: 10),
                  Text(formatter(_controller.endTrim)),
                ]),
              ),
            ]),
          );
        },
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: height / 4),
        child: TrimSlider(
          controller: _controller,
          height: height,
          horizontalMargin: height / 4,
          child: TrimTimeline(
            controller: _controller,
            padding: const EdgeInsets.only(top: 10),
          ),
        ),
      )
    ];
  }
}
