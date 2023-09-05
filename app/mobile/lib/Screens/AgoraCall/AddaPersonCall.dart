import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:wowondertimelineflutterapp/Util/Servers/Api/FriendsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';

class AddaPersonCall extends StatefulWidget {
  const AddaPersonCall(
      {super.key,
      required this.channelName,
      required this.token,
      required this.id,
      required this.myuserid});
  final String channelName;
  final String token;
  final String id;
  final String myuserid;
  @override
  State<AddaPersonCall> createState() => _AddaPersonCallState();
}

class _AddaPersonCallState extends State<AddaPersonCall> {
  List<GetAllFrindsModel> data = [];
  TextEditingController controller = new TextEditingController();

  String userid = '0';
  GetAllFrind() async {
    FriendsApi.allFrinds('', '', userid).then((ameen) {
      setState(() {
        data = ameen.toList();

        userid = data[data.length - 1].user_id;
      });
    });
  }

  @override
  void initState() {
    GetAllFrind();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void refesh() async {
    setState(() {
      data.clear();
    });

    FriendsApi.allFrinds('', '', userid).then((value) {
      setState(() {
        data = value.toList();
        value.length - 1 == -1 ? '' : userid = value[value.length - 1].user_id;

        _refreshController.refreshCompleted();
      });
    });
  }

  void onLoding() async {
    var list = await FriendsApi.allFrinds('', '', userid);
    if (list.length - 1 == -1 ? false : userid.isNotEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 1].user_id;
    if (userid.isEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 2].user_id;
    print(userid);
    // ignore: unnecessary_null_comparison
    userid == null ? dispose() : data.addAll(list);

    _refreshController.loadComplete();

    setState(() {});
  }

  bool trueflase = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SmartRefresher(
        onRefresh: refesh,
        onLoading: onLoding,
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < data.length; i++)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundImage:
                                CachedNetworkImageProvider(data[i].avatar),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width * 0.60,
                                  child: Text(
                                    data[i].name,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          NewWidget(
                              trueflase: trueflase,
                              widget: widget,
                              data: data,
                              i: i,
                              widget1: widget,
                              widget2: widget,
                              widget3: widget),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  NewWidget({
    super.key,
    required this.widget,
    required this.data,
    required this.i,
    required this.widget1,
    required this.widget2,
    required this.widget3,
    required this.trueflase,
  });

  final AddaPersonCall widget;
  final List<GetAllFrindsModel> data;
  final int i;
  final AddaPersonCall widget1;
  final AddaPersonCall widget2;
  final AddaPersonCall widget3;
  bool trueflase;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.trueflase
            ? InkWell(
                onTap: () async {
                  SocketNew.calssSokeit(
                      call_type: 'video',
                      callid: widget.widget.id,
                      id: widget.data[widget.i].user_id,
                      myuserId: widget.widget.myuserid,
                      room_name: widget.widget.channelName,
                      tokenagora: widget.widget.token);

                  Get.snackbar(
                      widget.data[widget.i].name, 'The invitation has be');
                  setState(() {
                    widget.trueflase = false;
                  });
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              )
            : Text('done'),
      ],
    );
  }
}
