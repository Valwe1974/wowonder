import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/VideoCallScreen.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCallsAgora.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFollowUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGroupsReactionChat.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/FriendsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';

class AddMempresGroups extends StatefulWidget {
  const AddMempresGroups({
    super.key,
    required this.id,
  });

  final String id;
  @override
  State<AddMempresGroups> createState() => _AddMempresGroupsState();
}

class _AddMempresGroupsState extends State<AddMempresGroups> {
  bool led = true;
  List<GetAllFrindsModel> data = [];
  TextEditingController controller = new TextEditingController();
  String userid = '0';
  GetAllFrind() async {
    FriendsApi.allFrinds('', '', userid).then((ameen) {
      setState(() {
        data = ameen.toList();
        led = false;
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
      appBar: AppBar(
        title: Text('Add a member'),
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: led
          ? Center(child: CircularProgressIndicator())
          : SmartRefresher(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  maxRadius: 25,
                                  backgroundImage: CachedNetworkImageProvider(
                                      data[i].avatar),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              ],
                            ),
                            NewWidget(
                                trueflase: trueflase,
                                widget: widget,
                                data: data,
                                i: i,
                                id: widget.id),
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
    required this.trueflase,
    required this.id,
  });

  final AddMempresGroups widget;
  final List<GetAllFrindsModel> data;
  final int i;
  final String id;

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
                  await ApiGroupsReactionChat.chat(
                      id: widget.id,
                      userid: widget.data[widget.i].user_id,
                      type: 'add_user');
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
