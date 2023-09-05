import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSendRecordAudio.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserMessgesApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMesageModel.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class ContChat extends GetxController {
  RxBool openEmoj = false.obs;
  RxBool emojiShowing = false.obs;
  Rx<KeyboardVisibilityController> keyboardVisibilityController =
      KeyboardVisibilityController().obs;
  TextEditingController textfiled = TextEditingController();
  final getimydata = Get.put(GetMyUserDataCont());
  TextEditingController textSher = TextEditingController();
  ScrollController scrollController = ScrollController();
  TextEditingController _controller = TextEditingController();
  RxBool isLoding = false.obs;
  RxString stickersGif = ''.obs;
  RxList<GetAllMesageModel> data = <GetAllMesageModel>[].obs;

  RxBool post = false.obs;
  RxBool witter = false.obs;
  late StreamSubscription<bool> keyboardSubscription;
  RxString text = ''.obs;
  int recordDuration = 0;
  RxBool openKey = false.obs;
  final ImagePicker picker = ImagePicker();
  Timer? _timer;
  final audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  Rx<RecordState> recordState = RecordState.stop.obs;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;
  RxString _filename = ''.obs;
  RxBool showPlayer = false.obs;
  String? audioPath;
  XFile? mediapath;
  XFile? videoUp;
  String? filename;
  XFile? ImagePost;

  String formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
      update();
    }

    return numberStr;
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await audioRecorder.resume();
  }

  Future<void> _start() async {
    await Permission.microphone.request();
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await audioRecorder.isEncoderSupported(
          AudioEncoder.wav,
        );
        if (kDebugMode) {
          print('${AudioEncoder.wav.name} supported: $isSupported');
        }

        // final devs = await audioRecorder.listInputDevices();
        // final isRecording = await audioRecorder.isRecording();

        await audioRecorder.start();
        recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

////imagesUppld
  ///

  List<XFile> imageFileList = [];
  void selectimges() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      update();
    }
    print('images List Lenth' + imageFileList.length.toString());
  }

  ///
  ///
  ///
  ///
////
//رؤوية الرسالة
  void TestSocooo() {
    SocketNew.socket.on('private_message', (data) async {
      print(data);
      get();
    });
  }

  @override
  void onInit() {
    socketGet();

    witters();

    ///
    openKeypord();
    showPlayer.value = false;

    ///
    ///
    _recordSub = audioRecorder.onStateChanged().listen((recordState) {
      recordState = recordState;
    });

    _amplitudeSub = audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => (() => _amplitude = amp));
    update();
    super.onInit();
  }

  void get() async {
    // void sokertetet() {
    //   socket.on(
    //       "private_message",
    //       (data) => {
    //             get(),
    //             // Get.snackbar('title', 'message'),
    //           });
    // }
    final ameen =
        GetUserMessgesApi.chat(Get.arguments['usd'].toString()).then((value) {
      // value.toList().isNotEmpty ? post = false : post = true;
      data.value = value.reversed.toList();

      SocketNew.socket.emit('seen_messages', {
        "recipient_id": Get.arguments['usd'].toString(),
        "usd": getimydata.data[0].user_id.toString(),
        'message_id': data[data.length - 1].id.toString(),
        "current_usd": Get.arguments['usd'].toString(),
      });
    });
  }

  void _sendMessg(text1, avatar, position) async {
    for (var i = 0; i < getimydata.data.length; i++)
      data.add(GetAllMesageModel(
          id: '',
          reaction: {"is_reacted": false, "type": "", "count": 0},
          reply_id: '',
          replyText: '',
          time_text: '',
          seen: '0',
          media: '',
          text: textfiled.text,
          avatar: getimydata.data[i].avatar,
          position: 'right',
          user_id: '',
          stickers: ''));

    print('text $text');

    post.value = false;

    textfiled.text = '';
  }

  Widget buildRecordStopControl(context) {
    late Icon icon;
    late Color color;

    if (recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Get.isDarkMode ? Colors.white : Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(
        Icons.mic,
        color: Get.isDarkMode ? Colors.white : Colors.blue,
      );
      color = Get.isDarkMode ? Colors.blue : Colors.red.withOpacity(0.1);
      ;
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: icon,
          ),
          onTap: () {
            (recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  sendMessgaSoketMedia(userid, sours) async {
    var senmess = await ApiSendRecordAudio.send(
        userid, ImagePost!.path, filename!, sours);
    print(senmess);
    var token = await SharedP.Get('tok');
    SocketNew.socket.emit('private_message', {
      'to_id': userid,
      'from_id': token,
      'mediaId': senmess['message_data'][0]['id'],
      // 'time_api': TimeOfDay
    });
  }

  void sendMessgAudio() async {
    for (var i = 0; i < getimydata.data.length; i++)
      data.add(GetAllMesageModel(
          reaction: '',
          id: '',
          seen: '0',
          reply_id: '',
          replyText: '',
          time_text: TimeOfDay.now().toString(),
          media: audioPath!,
          text: '',
          avatar: getimydata.data[i].avatar,
          position: 'right',
          user_id: '',
          stickers: ''));

    print('text $text');

    post.value = false;

    textfiled.text = '';
  }

  void sendComments() async {
    _sendMessg(textfiled.text, '', '');
  }

  Future<void> vedioupolde(send) async {
    await Permission.storage.request();
    await Permission.photos.request();

    final XFile? video = await picker.pickVideo(source: send);

    videoUp = video;
    filename = videoUp!.path.split('/').last;
    update();

    sendMessgAudio();
    sendMessgaSoketMedia(Get.arguments['usd'].toString(), 'video');

    Get.back();
  }

  void openKeypord() {
    keyboardSubscription =
        keyboardVisibilityController.value.onChange.listen((bool visible) {
      openKey.value = visible;
      print(openKey);
    });
  }

  scrollToCursor(String textFieldValue) async {
    final isLonger = textFieldValue.length > text.value.length;

    text.value = textFieldValue;

    print('ameen');

    if (isLonger)
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void witters() {
    SocketNew.socket.on(
        'typing',
        (data) => {
              if (data['is_typing'] == 200)
                {
                  witter.value = true,
                }
              else
                {witter.value = false}
            });
  }

  Future<void> _stop() async {
    _timer?.cancel();

    recordDuration = 0;

    final path = await audioRecorder.stop();

    if (kDebugMode) audioPath = path;
    mediapath != audioPath;
    File file = new File(path!);
    _filename.value = path.split('/').last;
    print(_filename.value);
    showPlayer.value = true;
    update();
  }

  socketGet() {
    get();

    SocketNew.socket.on('lastseen', (ww) {
      print(data);
      get();
      print(data[data.length - 1].id.toString());
    });
    SocketNew.socket.on('register_reaction', (ww) {
      get();
    });
  }

  void UplodeImage(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);
    print(picker);

    Get.back();

    ImagePost = image;
    update();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      update();
    });
  }

  void dispose() {
    _controller.dispose();
    scrollController.dispose();
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    audioRecorder.dispose();
    super.dispose();
  }
}
