import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAgorChekComLive.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAgorLive.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCommentLive.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiDelteLive.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CommentLiveModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;
  final token;
  final username;
  final avat;
  final id;
  final postid;

  const BroadcastPage(
      {required this.channelName,
      required this.isBroadcaster,
      this.username,
      this.token,
      this.id,
      this.avat,
      this.postid});

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  final _users = <int>[];
  TextEditingController myController = TextEditingController();

  void permission() async {
    if (widget.isBroadcaster) {
      await Permission.microphone;
      await Permission.camera;
    }
  }

  RtcEngine? _engine;
  bool muted = false;
  int? streamId;

  @override
  void dispose() {
    // clear users
    _users.clear();
    _timer!.cancel();
    // destroy sdk and leave channel
    _engine!.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    permission();
    // initialize agora sdk
    initializeAgora();
    CreateLive();
  }

/////
  ///
  List<CommentLiveModel> posts = <CommentLiveModel>[];
  List lives = [];
  Timer? _timer;

  var coountlive = 0;
  String commid = '0';

//////
  ///
  ///
  String commenid = '0';

  void CreateLive() async {
    if (widget.isBroadcaster == true) {
      var ameen = await ApiAgorLive.Cre(widget.channelName);
      await ApiAgorChekComLive.Chek(
          ameen[accounts[0]['dapo']][accounts[0]['pos']], commenid);
      setState(() {
        commid = ameen[accounts[0]['dapo']][accounts[0]['pos']];
      });
      print(coountlive.toString());
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        var newLive = await ApiAgorChekComLive.Chek(
            ameen[accounts[0]['dapo']][accounts[0]['pos']], commenid);
        print(
            'ameenjawad hamed ${ameen[accounts[0]['dapo']][accounts[0]['pos']]}');

        setState(() {
          coountlive = newLive['count'];
          var data = newLive['comments'];
          for (var item in data) {
            posts.add(CommentLiveModel.fromJson(item));
          }
          if (posts.isNotEmpty) commenid = posts[posts.length - 1].id;
        });
        print('ameenjawad coom id ${commid}');
        print('ameenjawad id $commenid');
        print('ameenjawad count' + coountlive.toString());
      });
    } else {
      await ApiAgorChekComLive.Chek(widget.postid!, commenid);
      setState(() {
        commid = widget.postid!;
      });
      print(coountlive.toString());
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        var newLive = await ApiAgorChekComLive.Chek(widget.postid!, commenid);
        print('ameenjawad hamed ${widget.postid!}');

        setState(() {
          coountlive = newLive['count'];
          var data = newLive['comments'];
          for (var item in data) {
            posts.add(CommentLiveModel.fromJson(item));
          }
          if (posts.isNotEmpty) commenid = posts[posts.length - 1].id;
        });
        print('ameenjawad coom id ${commid}');
        print('ameenjawad id $commenid');
        print('ameenjawad count' + coountlive.toString());
      });
    }
  }

  ///
  ///
  ///
  ///
  ///
  ///
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
        setState(() {
          _users.add(uid);
          print('userJoined: $uid');
        });
        print(_users.length);
      },
      userOffline: (uid, elapsed) {
        setState(() {
          print('userOffline: $uid');
          Get.back();

          _users.remove(uid);
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
    // ignore: deprecated_member_use
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(Agora_App_ID));
    await _engine!.enableVideo();

    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine!.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine!.setClientRole(ClientRole.Audience);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              _broadcastView(),
              //live yey
              Positioned(
                top: 0,
                child: Container(
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.isBroadcaster == false)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 94, 92, 92)
                                    .withOpacity(0.5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 1),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(widget.avat),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.username,
                                        style: SafeGoogleFont(Fonts.font1,
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      // Text(
                                      //   '159K Followers  ',
                                      //   style: SafeGoogleFont(Fonts.font1,
                                      //       fontSize: 15,
                                      //       color: Colors.grey.shade200),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff004EC4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Follow',
                                        style: SafeGoogleFont(Fonts.font1,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        //live/eye
                        Row(
                          children: [
                            Container(
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color:
                                        Colors.grey.shade700.withOpacity(0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 6),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye_sharp,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.002,
                                          ),
                                          Text(
                                            coountlive == null
                                                ? '0'
                                                : coountlive.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xffF60E3A)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          child: Text('Live',
                                              style: SafeGoogleFont(Fonts.font1,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        if (widget.isBroadcaster)
                          IconButton(
                              onPressed: () {
                                Get.dialog(Center(
                                  child: Container(
                                    width: Get.width * 0.90,
                                    height: Get.height * 0.30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Scaffold(
                                        backgroundColor:
                                            Color.fromARGB(0, 0, 0, 0),
                                        body: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color.fromARGB(
                                                  157, 139, 139, 139)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'End Live Stream',
                                                      style: SafeGoogleFont(
                                                          Fonts.font3,
                                                          color:
                                                              Color(0xff696868),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: Get.width * 0.60,
                                                    child: Text(
                                                      'Are you sure you want to end your live stream',
                                                      style: SafeGoogleFont(
                                                          Fonts.font3,
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.04,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff686868),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        child: Text(
                                                          'Cancel',
                                                          style: SafeGoogleFont(
                                                              Fonts.font3,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.04,
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          _onCallEnd(context),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffDE0000),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          child: Text(
                                                            'End Live',
                                                            style: SafeGoogleFont(
                                                                Fonts.font3,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 17,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                              },
                              icon: Icon(
                                Icons.cancel_sharp,
                                color: Colors.blueAccent,
                              )),
                      ],
                    ),
                  ),
                ),
              ),

              ///comments
              Positioned(
                  bottom: Get.height * 0.08,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: Get.height * 0.40,
                      width: Get.width,
                      child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            children: [
                              for (var i = 0; i < posts.length; i++)
                                _CommentLive(
                                  comment: posts[i].text,
                                  name: posts[i].name,
                                  imagess: posts[i].avatar,
                                ),
                            ],
                          )),
                    ),
                  )),

              _toolbar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(107, 0, 0, 0),
              borderRadius: BorderRadius.circular(50),
            ),
            width: widget.isBroadcaster ? Get.width * 0.60 : Get.width * 0.60,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/ImageNew/Icon ionic-ios-chatbubbles.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                Container(
                  width: Get.width * 0.35,
                  child: TextField(
                    controller: myController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        hintText: 'Type Something...',
                        hintStyle: SafeGoogleFont(Fonts.font3,
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      ApiCommentLive.CreateComments(
                          commid, myController.text, null, 'create');
                      myController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Container(
            width: widget.isBroadcaster ? Get.width * 0.30 : Get.width * 0.30,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (widget.isBroadcaster)
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                  if (widget.isBroadcaster)
                    InkWell(
                      onTap: () {
                        _onSwitchCamera();
                      },
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(20, 0, 0, 0)
                          ..withOpacity(0.5),
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 175, 175, 175)
                                  .withOpacity(0.5),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/ImageNew/Icon awesome-exchange-alt.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (widget.isBroadcaster)
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                  if (widget.isBroadcaster)
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(20, 0, 0, 0)
                        ..withOpacity(0.5),
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 175, 175, 175)
                                .withOpacity(0.5),
                        child: RawMaterialButton(
                          onPressed: _onToggleMute,
                          child: Icon(
                            muted ? Icons.mic_off : Icons.mic,
                            color: muted ? Colors.white : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(20, 0, 0, 0)
                      ..withOpacity(0.5),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 175, 175, 175)
                          .withOpacity(0.5),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/ImageNew/Icon ionic-ios-share-alt.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(20, 0, 0, 0)
                      ..withOpacity(0.5),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 175, 175, 175)
                          .withOpacity(0.5),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/ImageNew/Icon ionic-ios-heart-empty.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // RawMaterialButton(
          //   onPressed: _onToggleMute,
          //   child: Icon(
          //     muted ? Icons.mic_off : Icons.mic,
          //     color: muted ? Colors.white : Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: muted ? Colors.blueAccent : Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // ),
          // RawMaterialButton(
          //   onPressed: () => _onCallEnd(context),
          //   child: Icon(
          //     Icons.call_end,
          //     color: Colors.white,
          //     size: 35.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: Colors.redAccent,
          //   padding: const EdgeInsets.all(15.0),
          // ),
          // RawMaterialButton(
          //   onPressed: _onSwitchCamera,
          //   child: Icon(
          //     Icons.switch_camera,
          //     color: Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // ),
        ],
      ),
    );
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
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views
        .map<Widget>((view) => Expanded(child: Container(child: view)))
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]])
          ],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]]),
            _expandedVideoView([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(views.sublist(0, 2)),
            _expandedVideoView(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    print('aklsjdklsajdklasjdklsdj ${commid}');
    ApiDelteLive.dele(pos: commid.toString());
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine!.muteLocalAudioStream(muted);
  }

  Future<void> _onSwitchCamera() async {
    if (streamId != null) _engine!.switchCamera();
  }
}

class _CommentLive extends StatelessWidget {
  const _CommentLive({
    super.key,
    required this.imagess,
    required this.name,
    required this.comment,
  });

  final String imagess;
  final String name;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(107, 0, 0, 0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: [
                  CircleAvatar(
                    maxRadius: 15,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imagess),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: SafeGoogleFont(Fonts.font1,
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        SizedBox(
                          height: Get.height * 0.001,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                comment,
                                style: SafeGoogleFont(Fonts.font1,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
      ],
    );
  }
}
