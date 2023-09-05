import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/AddaPersonCall.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

class CallVideoAgora extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;
  final String token;
  final String avat;
  final String name;
  final String id;
  final String myuserid;

  const CallVideoAgora({
    required this.channelName,
    required this.isBroadcaster,
    required this.token,
    required this.avat,
    required this.name,
    required this.id,
    required this.myuserid,
  });

  @override
  _CallVideoAgoraState createState() => _CallVideoAgoraState();
}

class _CallVideoAgoraState extends State<CallVideoAgora> {
  void permission() async {
    await Permission.microphone;
    await Permission.camera;
  }

  int vewFullScreen = 0;
  final _users = <int>[];
  RtcEngine? _engine;
  bool muted = false;
  int? streamId;
  bool speaker = false;
  String recordingTime = '0:0'; // to store value
  bool isRecording = false;
  bool timerStopCall = false;
  Timer? _timer;
  void recordTime() {
    var startTime = DateTime.now();
    Timer.periodic(const Duration(seconds: 0), (Timer t) {
      var diff = DateTime.now().difference(startTime);
      recordingTime =
          '${diff.inHours == 0 ? '' : diff.inHours.toString().padLeft(2, "0") + ':'}${(diff.inMinutes % 60).floor().toString().padLeft(2, "0")}:${(diff.inSeconds % 60).floor().toString().padLeft(2, '0')}';
      if (false) {
        t.cancel();
      }
      setState(() {});
    });
  }

  void timerEnd() {
    if (widget.isBroadcaster == false) {
      Timer.periodic(const Duration(seconds: 20), (Timer t) {
        if (timerStopCall) {
          _onCallEnd(context);
          Get.back();
          t.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine!.destroy();
    super.dispose();
  }

  @override
  void initState() {
    permission();
    timerEnd();
    super.initState();
    // initialize agora sdk
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();
    if (widget.isBroadcaster)
      streamId = await _engine?.createDataStream(false, false);

    _engine!.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          print('onJoinChannel: $channel, uid: $uid');
        });
      },
      leaveChannel: (stats) {
        setState(() {
          print('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        recordTime();
        setState(() {
          vewFullScreen = uid;
          print('userJoined: $uid');

          _users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          print('userOffline: $uid');
          _users.remove(uid);
          if (_users.length < 1) {
            _onCallEnd(context);
          }
        });
      },
      streamMessage: (_, __, message) {
        final String info = "here is the message $message";
        print(info);
      },
      streamMessageError: (_, __, error, ___, ____) {
        final String info = "here is the error $error";
        print(info);
      },
    ));

    await _engine!.joinChannel(widget.token, widget.channelName, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(Agora_App_ID));

    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine!.enableVideo();
      await _engine!.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine!.disableVideo();
      await _engine!.setEnableSpeakerphone(speaker);
      await _engine!.setChannelProfile(ChannelProfile.Communication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            if (widget.isBroadcaster == false)
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.2,
                    ),
                    CircleAvatar(
                      maxRadius: 82,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundImage: NetworkImage(widget.avat),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    Container(
                      child: Text(
                        widget.name,
                        style: SafeGoogleFont(Fonts.font1,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    recordingTime != '0:0'
                        ? Container(
                            child: Text(
                              recordingTime,
                              style: SafeGoogleFont(Fonts.font1,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            child: Text(
                            'Calling...',
                            style: SafeGoogleFont(Fonts.font1,
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                  ],
                ),
              ),
            if (widget.isBroadcaster) _broadcastView(vewFullScreen),
            Positioned(bottom: 5, left: 3, right: 3, child: _toolbar()),
          ],
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: Get.width,
        child: Stack(
          children: [
            CustomPaint(
              // painter: MyPainter(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: _onToggleMute,
                              child: Icon(
                                muted ? Icons.mic_off : Icons.mic,
                                color: muted ? Colors.blue : Colors.white,
                                size: 30.0,
                              ),
                              elevation: 2.0,
                            ),
                            RawMaterialButton(
                              onPressed: _onSwitchCameraOrAudio,
                              child: Icon(
                                widget.isBroadcaster
                                    ? Icons.cameraswitch
                                    : speaker
                                        ? Icons.volume_up
                                        : Icons.volume_down_rounded,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              elevation: 2.0,
                            ),
                            if (Group_Call_for_Pro_Users)
                              RawMaterialButton(
                                onPressed: () {
                                  Get.dialog(AddaPersonCall(
                                    myuserid: widget.myuserid,
                                    channelName: widget.channelName,
                                    id: widget.id,
                                    token: widget.token,
                                  ));
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 35.0,
                                ),
                                elevation: 2.0,
                              ),
                            RawMaterialButton(
                              onPressed: () => _onCallEnd(context),
                              child: Icon(
                                Icons.call_end,
                                color: Colors.white,
                                size: 35.0,
                              ),
                              shape: CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.redAccent,
                              padding: const EdgeInsets.all(15.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.isBroadcaster)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (vewFullScreen == 1)
                            InkWell(
                                onDoubleTap: () {
                                  setState(() {
                                    vewFullScreen = 0;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    width: Get.width * 0.20,
                                    height: Get.height * 0.15,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: _broadcastView(0)),
                                  ),
                                )),
                          if (vewFullScreen == 0)
                            if (_users.length > 0)
                              InkWell(
                                onDoubleTap: () {
                                  setState(() {
                                    vewFullScreen = 1;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    width: Get.width * 0.20,
                                    height: Get.height * 0.15,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: _broadcastView(1)),
                                  ),
                                ),
                              ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.isBroadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(
          uid: uid,
          channelId: widget.channelName,
        )));
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(Widget views) {
    return Container(
      child: views,
    );
  }

  Widget _broadcastView(int videoNump) {
    final views = _getRenderViews();
    return _expandedVideoView(views[videoNump]);
  }

  /// Video layout wrapper
  // Widget _broadcastView() {
  //   final views = _getRenderViews();
  //   switch (views.length) {
  //     case 1:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoView([views[0]])
  //         ],
  //       ));
  //     case 2:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoView([views[0]]),
  //           _expandedVideoView([views[1]]),
  //         ],
  //       ));
  //     case 3:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoView(views.sublist(0, 2)),
  //           _expandedVideoView(views.sublist(2, 3))
  //         ],
  //       ));
  //     case 4:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoView(views.sublist(0, 2)),
  //           _expandedVideoView(views.sublist(2, 4))
  //         ],
  //       ));
  //     default:
  //   }
  //   return Container();
  // }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine!.muteLocalAudioStream(muted);
  }

  Future<void> _onSwitchCameraOrAudio() async {
    if (streamId != null)
      _engine?.sendStreamMessage(streamId!, Uint8List(streamId!));
    if (widget.isBroadcaster) _engine!.switchCamera();

    if (widget.isBroadcaster == false) {
      setState(() {
        speaker = !speaker;
      });

      _engine!.muteLocalAudioStream(muted);
      _engine!.setEnableSpeakerphone(speaker);
    }
    ;
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3071375, size.height * 0.3273600);
    path_1.cubicTo(
        size.width * 0.3067750,
        size.height * 0.1999400,
        size.width * 0.3815000,
        size.height * 0.1964000,
        size.width * 0.4125000,
        size.height * 0.2000000);
    path_1.cubicTo(
        size.width * 0.4514375,
        size.height * 0.3614200,
        size.width * 0.5514000,
        size.height * 0.3594200,
        size.width * 0.5875000,
        size.height * 0.2000000);
    path_1.quadraticBezierTo(size.width * 0.6656000, size.height * 0.1954200,
        size.width * 0.6943500, size.height * 0.3273600);
    path_1.quadraticBezierTo(size.width * 0.6943500, size.height * 0.6060200,
        size.width * 0.6943500, size.height * 0.6990200);
    path_1.quadraticBezierTo(size.width * 0.6943500, size.height * 0.8229400,
        size.width * 0.6169000, size.height * 0.8229400);
    path_1.quadraticBezierTo(size.width * 0.4427250, size.height * 0.8229400,
        size.width * 0.3846250, size.height * 0.8229400);
    path_1.quadraticBezierTo(size.width * 0.3049125, size.height * 0.8229600,
        size.width * 0.3071375, size.height * 0.6990200);
    path_1.quadraticBezierTo(size.width * 0.3071375, size.height * 0.6060200,
        size.width * 0.3071375, size.height * 0.3273600);
    path_1.close();

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5000002, size.height * 0.0804608);
    path_2.cubicTo(
        size.width * 0.5273750,
        size.height * 0.0804200,
        size.width * 0.5684875,
        size.height * 0.1111200,
        size.width * 0.5684620,
        size.height * 0.1899997);
    path_2.cubicTo(
        size.width * 0.5684875,
        size.height * 0.2338200,
        size.width * 0.5479250,
        size.height * 0.2995600,
        size.width * 0.5000002,
        size.height * 0.2995385);
    path_2.cubicTo(
        size.width * 0.4726125,
        size.height * 0.2995600,
        size.width * 0.4315250,
        size.height * 0.2667000,
        size.width * 0.4315384,
        size.height * 0.1899997);
    path_2.cubicTo(
        size.width * 0.4315250,
        size.height * 0.1462000,
        size.width * 0.4520625,
        size.height * 0.0804200,
        size.width * 0.5000002,
        size.height * 0.0804608);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
