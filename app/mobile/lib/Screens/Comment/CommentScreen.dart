import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Comment/ReplayCommentScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/ReactionComment.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/CreateCommentsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetCommetsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CommentsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/NotFoundWidget.dart';

// ignore: must_be_immutable
class CommentScreen extends StatefulWidget {
  CommentScreen(
      {super.key,
      required this.post_id,
      required this.fetch_comments,
      required this.contcoment});
  String post_id;
  String fetch_comments;
  final contcoment;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool post = false;
  String lastId = '0';
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool loding = true;
  bool noData = true;
  String text = '';
  TextEditingController textfiled = TextEditingController();
  ScrollController _scrollController = ScrollController();
  scrollToCursor(String textFieldValue) {
    final isLonger = textFieldValue.length > text.length;
    setState(() {
      text = textFieldValue;
    });
    print(text.length);
    if (isLonger)
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void sendComments() async {
    _addComments(
      textfiled.text,
      ImagePost != null ? ImagePost!.path : null,
    );
    // GetCommentsApi.FetchComments(widget.post_id, widget.fetch_comments, '0');
  }

  bool noMore = false;
  List<GetCommentsModel> data = [];
  void getCommentsApi() {
    try {
      GetCommentsApi.FetchComments(widget.post_id, widget.fetch_comments, '0')
          .then((value) {
        setState(() {
          data = value.toList();
          loding = false;
          value.length > 0 ? lastId = value[value.length - 1].id : post;
          data.length > 0 ? noData = false : noData = true;
          data.length > 0 ? noMore = false : noMore = true;
          value.length > 0 ? lastId = value[value.length - 1].id : post;
        });
      });
    } catch (erorr) {
      setState(() {
        loding = false;
        noData = true;
      });
    }
  }

  @override
  void initState() {
    getCommentsApi();

    super.initState();
  }

  XFile? ImagePost;
  XFile? videoUp;
  String? filename;
  final ImagePicker _picker = ImagePicker();
  String imagefile = '';
  Future<void> UplodeImageComments(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await _picker.pickImage(source: send);
    setState(() {
      print(_picker);
      ImagePost = image;
      print(ImagePost!.path);
    });
  }

  final getimydata = Get.put(GetMyUserDataCont());
  void _addComments(
    text1,
    c_file,
  ) async {
    Get.find<GetMyUserDataCont>();

    print('text $text');

    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        data.add(GetCommentsModel(
            type: '',
            comment_id: '',
            reaction: 0,
            reaction1: 0,
            id: '',
            text: text1 == '' ? '' : text1,
            avatar: getimydata.data[i].avatar,
            name: getimydata.data[i].name,
            c_file: c_file == null ? '' : c_file,
            comments_status: '0',
            replies: '0'));

        noData = false;
      });

    var senposts = await CreateCommentsApi.CreateComments(
        widget.post_id,
        textfiled.text == '' ? null : textfiled.text,
        ImagePost != null ? ImagePost!.path : null,
        'create');
    textfiled.clear();
    setState(() {
      ImagePost = null;
    });
  }

  // addComments() {
  //   setState(() {
  //     data.add(GetCommentsModel(
  //         type: 'type',
  //         replies: '0',
  //         comment_id: '0',
  //         text: 'ameen',
  //         reaction: 0,
  //         reaction1: 0,
  //         id: '0',
  //         avatar: 'avatar',
  //         name: 'ameen Test',
  //         c_file: '',
  //         comments_status: 'comments_status'));
  //   });
  // }

  void onLoding() async {
    var list = await GetCommentsApi.FetchComments(
        widget.post_id, 'fetch_comments', lastId);

    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].id;
    // ignore: unnecessary_null_comparison
    lastId == null ? dispose() : data.addAll(list);
    if (list.length - 1 == -1) {
      post = true;
    } else {
      post = false;
    }

    _refreshController.loadComplete();

    setState(() {});
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print(widget.post_id);
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? Color.fromARGB(96, 158, 158, 158) : Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Color.fromARGB(131, 119, 119, 119),
            ),
          ],
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        width: Get.width,
        child: Row(children: [
          SizedBox(
            width: Get.width * 0.01,
          ),
          IconButton(
            onPressed: () {
              Get.dialog(Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  width: Get.width * 0.70,
                  height: Get.height * 0.20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scaffold(
                      body: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  UplodeImageComments(ImageSource.gallery);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : ColorTheme,
                                    ),
                                    Text(
                                      'Add image'.tr,
                                      style: SafeGoogleFont(Fonts.font1,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
            },
            icon: Icon(Icons.more_vert),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(96, 158, 158, 158),
                  borderRadius: BorderRadius.circular(50)),
              width: Get.width * 0.74,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: (value) {
                    scrollToCursor(value);
                  },
                  controller: textfiled,
                  scrollController: _scrollController,
                  maxLength: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                sendComments();
                widget.contcoment();
              },
              icon: Icon(Icons.send))
        ]),
      ),
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        // backgroundColor: ColorThme,
        elevation: 0,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        title: Text('Comments'.tr),
      ),
      body: loding
          ? Center(child: CircularProgressIndicator())
          : noData
              ? NotFoundWidget(text: 'No comments yet'.tr)
              : SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: false,
                  controller: _refreshController,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          for (var i = 0; i < data.length; i++)
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      data[i].avatar),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Text(
                                              data[i].name,
                                              style: SafeGoogleFont(Fonts.font3,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Get.bottomSheet(Container(
                                                child: Column(
                                                  children: [],
                                                ),
                                              ));
                                            },
                                            icon: Icon(Icons.more_horiz))
                                      ],
                                    ),

                                    ///comments all tex
                                    ///
                                    ///
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(data[i].text),
                                          if (data[i].c_file.isImageFileName)
                                            Container(
                                              width: Get.width,
                                              height: Get.height * 0.40,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: data[i].c_file,
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.file(
                                                        File(data[i].c_file));
                                                  },
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        ReqctionComment(
                                          contt: data[i].reaction,
                                          imReaction: data[i].type,
                                          comments_id: data[i].comment_id,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(ReplayCommentScreen(
                                              post_id: data[i].id,
                                              fetch_comments:
                                                  'fetch_comments_reply',
                                            ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Divider(),
                                                SvgPicture.asset(
                                                  SvgImages.CommentBtn,
                                                  height: 25,
                                                  width: 25,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.01,
                                                ),
                                                Text(
                                                  'Commentt'.tr,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(data[i].replies.toString())
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (post == false)
                            InkWell(
                              onTap: onLoding,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(40)),
                                width: Get.width * 0.5,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Ionicons.arrow_down,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'View more comments'.tr,
                                        style: SafeGoogleFont(
                                          Fonts.font1,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          ImagePost != null
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.black,
                                                child: Image.file(
                                                    File(ImagePost!.path)),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  ImagePost = null;
                                                });
                                              },
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: Color.fromARGB(
                                                      255, 114, 12, 5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                              : SizedBox(
                                  height: Get.height * 0.0,
                                ),
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
