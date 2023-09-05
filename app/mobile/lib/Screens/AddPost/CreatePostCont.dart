import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/flutter_social_textfield.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/CreaePostImageApi.dart';

class CreatePostCont extends GetxController {
  bool records = false;
  // final record = FlutterSoundRecorder();
  StreamSubscription<SocialContentDetection>? _streamSubscription;
  SocialTextEditingController textEditingController =
      SocialTextEditingController();
  final TextEditingController poll1 = TextEditingController();
  final TextEditingController poll2 = TextEditingController();
  final TextEditingController poll3 = TextEditingController();
  final TextEditingController poll4 = TextEditingController();
  final TextEditingController poll5 = TextEditingController();
  final TextEditingController poll6 = TextEditingController();
  final TextEditingController poll7 = TextEditingController();
  final TextEditingController poll8 = TextEditingController();
  final TextEditingController smaileicon = TextEditingController();
  final TextEditingController smailetext = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? ImagePost;
  List<XFile> imageFileList = [];
  XFile? videoUp;
  String? filename;
  bool isLoding = false;
  RxBool truefalsecolor = false.obs;
  RxString colorId = '0'.obs;
  bool true2 = true;
  void cleare() {
    textEditingController.clear();
    poll1.clear();
  }

  // final TextEditingController newposts = SocialTextEditingController()
  //   ..text = ""
  //   ..setTextStyle(
  //       DetectedType.mention,
  //       TextStyle(
  //           color: Colors.purple, backgroundColor: Colors.purple.withAlpha(50)))
  //   ..setTextStyle(DetectedType.url,
  //       TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
  //   ..setTextStyle(DetectedType.hashtag,
  //       TextStyle(color: Colors.blue, fontWeight: FontWeight.w600));
  @override
  void onInit() {
    ameen();
    super.onInit();
  }

  Future<void> truefalseopen(bool trueflase) async {
    truefalsecolor.value = await false;
    truefalsecolor.value = await trueflase;
    update();
  }

  voidColorId(String id) {
    colorId.value = id;
    update();
  }

  void ameen() {
    textEditingController = SocialTextEditingController()
      ..text = textEditingController.text
      ..setTextStyle(
          DetectedType.mention,
          TextStyle(
              color: Colors.purple,
              backgroundColor: Colors.purple.withAlpha(50)))
      ..setTextStyle(DetectedType.url,
          TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
      ..setTextStyle(DetectedType.hashtag,
          TextStyle(color: Colors.blue, fontWeight: FontWeight.w600));

    textEditingController.subscribeToDetection(onDetectContent);
  }

  int cont = 0;
  void onDetectContent(SocialContentDetection detection) {
    if (detection.text ==
        '@') {} // if (detection.type.toString() == 'DetectedType.mention') {
    //   cont++;
    //   print(cont++);
    //   update();
    // }
    detection.type.toString();
  }

  void IsLoding() {
    isLoding = !isLoding;
    update();
  }

  // Future recored() async {
  //   await record.startRecorder(toFile: 'audio');
  //   records = true;
  //   update();
  // }

  // Future stoprecord() async {
  //   await record.stopRecorder();
  //   records = false;
  //   update();
  //   onClose() {
  //     record.closeAudioSession();
  //     super.onClose();
  //   }
  // }

  void selectimges() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      update();
    }
  }

  void reomveSelected(index) {
    imageFileList.removeAt(index);
    update();
  }

  Future<void> vedioupolde(send) async {
    await Permission.storage.request();
    await Permission.photos.request();

    final XFile? video = await picker.pickVideo(source: send);

    videoUp = video;
    filename = videoUp!.path.split('/').last;
    Get.back();
    update();
  }

  Future<void> UplodeImage(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);
    print(picker);
    ImagePost = image;
    print(ImagePost!.path);
    Get.back();
    update();
  }

  void CreatPost(
    postPrivacy,
  ) async {
    var ameen = CreatePostImageApi.cratepost(
        ImagePost != null ? ImagePost!.path : null,
        videoUp != null ? videoUp!.path : null,
        textEditingController.text,
        filename,
        postPrivacy,
        poll1.text,
        poll2.text,
        poll3.text,
        poll4.text,
        poll5.text,
        poll6.text,
        poll7.text,
        poll8.text,
        smailetext.text,
        imageFileList,
        Get.arguments == null ? '' : Get.arguments['group_id'].toString(),
        Get.arguments == null ? '' : Get.arguments['page_id'].toString());

    update();
  }
}
