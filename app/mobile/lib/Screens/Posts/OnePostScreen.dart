import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Comment/CommentScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/PhotoView.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/ReactionButton.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiOnePosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/VideoFmmpeg.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetAudio.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetFellingIcons.dart';
import 'package:wowondertimelineflutterapp/main.dart';

import 'GetAllRectionScreen.dart';

class OnePostScreenGo extends StatefulWidget {
  const OnePostScreenGo(
      {super.key, required this.title, required this.post_id});
  final String title;
  final String post_id;

  @override
  State<OnePostScreenGo> createState() => _OnePostScreenGoState();
}

class _OnePostScreenGoState extends State<OnePostScreenGo> {
  @override
  List<PostModel> data = [];
  void GetPost() async {
    ApiPostData.postsData(widget.post_id).then((value) {
      if (mounted) {
        setState(() {
          data = value.toList();

          // make your changes here
        });
      }
    });
  }

  @override
  void initState() {
    GetPost();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              Get.isDarkMode ? Color.fromARGB(255, 40, 40, 40) : ColorTheme,
          title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < data.length; i++)
              OnePostScreen(
                title: widget.title,
                more: Container(
                    child: IconButton(
                        onPressed: () {
                          Get.bottomSheet(
                            WidgetMorePosts(
                              url_post: data[i].postLink,
                              refreshPost: () {
                                GetPost();
                              },
                              postText: data[i].postText,
                              pos: data[i].post_id,
                              hidePost: () {
                                setState(() {
                                  data.removeAt(i);
                                });
                              },
                              remove: () {
                                QuickAlert.show(
                                  onConfirmBtnTap: () {
                                    PostActionsApi.reaction(
                                            data[i].post_id, 'delete')
                                        .asStream();
                                    setState(() {
                                      data.removeAt(i);
                                    });

                                    Get.back();
                                    Get.back();
                                  },
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'Do you want to delete the post'.tr,
                                  confirmBtnText: 'Yes'.tr,
                                  cancelBtnText: 'No'.tr,
                                  confirmBtnColor: Colors.red,
                                );
                              },
                              adminPost: data[i].admin,
                              avat: data[i].avatar,
                              name: data[i].name,
                              user_id: data[i].user_id,
                            ),
                          );
                        },
                        icon: Icon(Icons.more_vert))),
                user_id: data[i].user_id,
                reomvePost: () {
                  setState(() {
                    data.removeAt(i);
                  });
                },
                data: data,
                adminPost: data[i].admin,
                iint: i,
                imReaction: data[i].type,
                reaction: data[i].reaction,
                post_id: data[i].post_id,
                postType: data[i].postType,
                verified: data[i].verified,
                postFeeling: data[i].postFeeling,
                time: data[i].post_time,
                name: data[i].name,
                avat: data[i].avatar,
                postText: data[i].postText,
                postFile: data[i].postFile.isVideoFileName
                    ? accounts[0]['sm0'] + '/${data[i].postFile}'
                    : data[i].postFile,
                p1080p: data[i].p1080,
                p2048p: data[i].p2048,
                p240p: data[i].p240,
                p360p: data[i].p360,
                p4096p: data[i].p4096,
                p480p: data[i].p480,
                p720p: data[i].p720,
                options: data[i].options,
                postRecord: data[i].postRecord,
                contLike: data[i].reaction,
                contcoment: data[i].post_comments,
                islike: data[i].reaction1,
                photoMulti2: data[i].photoMulti2,
                photo_album: data[i].photo_album,
                postimage: data[i].postFile,
                type: data[i].type,
                page_id: data[i].page_id,
                group_id: data[i].group_id,
                avatar_group: data[i].avatargroupe,
                name_group: data[i].group_title,
                cover: data[i].cover,
                comment_cont: data[i].comments_status,
              ),
          ],
        ),
      ),
    );
  }
}

class OnePostScreen extends StatefulWidget {
  OnePostScreen({
    required this.adminPost,
    required this.user_id,
    required this.name,
    required this.reomvePost,
    required this.avat,
    required this.postFeeling,
    required this.postFile,
    required this.postText,
    required this.p1080p,
    required this.p2048p,
    required this.p240p,
    required this.p360p,
    required this.p4096p,
    required this.p480p,
    required this.imReaction,
    required this.post_id,
    required this.reaction,
    required this.verified,
    required this.p720p,
    required this.options,
    required this.data,
    required this.time,
    required this.iint,
    required this.postType,
    required this.more,
    required this.postRecord,
    required this.photo_album,
    required this.photoMulti2,
    required this.contLike,
    required this.contcoment,
    required this.islike,
    required this.postimage,
    required this.type,
    required this.group_id,
    required this.page_id,
    required this.avatar_group,
    required this.name_group,
    required this.cover,
    required this.comment_cont,
    required this.title,
    super.key,
  });
  final reomvePost;
  final options;
  String postText;
  String avat;
  String name;
  String verified;
  String postFeeling;
  String postFile;
  String p720p;
  String p480p;
  String p1080p;
  String p240p;
  String p360p;
  String p4096p;
  String p2048p;
  String time;
  String postType;
  String user_id;
  final reaction;
  String post_id;
  final imReaction;
  final List<PostModel> data;
  final int iint;
  final adminPost;
  Container more;
  String postRecord;
  final photoMulti2;
  final photo_album;
  int contLike;
  final type;
  final islike;
  final contcoment;
  final postimage;
  String page_id;
  String group_id;
  String avatar_group;
  String name_group;
  String cover;
  final comment_cont;
  String title;

  @override
  State<OnePostScreen> createState() => _OnePostScreenState();
}

class _OnePostScreenState extends State<OnePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, right: 10, left: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.adminPost) {
                                  // MyProfileHomeScreen();
                                } else if (widget.group_id.isNotEmpty) {
                                  print('gruop');
                                } else if (widget.page_id.isNotEmpty) {
                                  print('page_id');
                                } else {
                                  Get.to(ProfileUserScreen(
                                    user_id: widget.user_id,
                                    avat: widget.avat,
                                    name: widget.name,
                                    cover: widget.cover,
                                  ));
                                }
                              },
                              child: widget.group_id.isNotEmpty
                                  ? Container(
                                      height: 60,
                                      width: 60,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: ColorTheme,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: CachedNetworkImageProvider(
                                                            widget
                                                                .avatar_group)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: CircleAvatar(
                                              maxRadius: 15,
                                              backgroundColor: Colors.black,
                                              child: CircleAvatar(
                                                maxRadius: 15,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        widget.avat),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : CircleAvatar(
                                      maxRadius: 25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          maxRadius: 25,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  widget.avat),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.group_id.isNotEmpty)
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                  if (widget.group_id.isNotEmpty)
                                    Text(
                                      widget.name_group,
                                      style: SafeGoogleFont(Fonts.font2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          widget.name,
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        if (widget.verified == '1')
                                          Icon(Icons.verified,
                                              size: 14, color: ColorTheme),
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        if (widget.postType ==
                                            'profile_picture')
                                          Container(
                                            width: Get.width * 0.50,
                                            child: Text(
                                              'Change his profile picturep'.tr,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                              maxLines: 1,
                                            ),
                                          ),
                                        if (widget.postFeeling.isNotEmpty)
                                          WidgetFellingIcons(
                                            text: widget.postFeeling,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.time,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          '·', // Dot character as separator
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.public,
                                        color: Colors.grey,
                                        size: 14,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        widget.more
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    ///////posts text
                    ///
                    if (widget.postText.isNotEmpty)

                      // SelectableText.rich(

                      //   TextSpan(
                      //     children: [

                      //       TextSpan(
                      //           text: postText,
                      //           style: TextStyle(color: Colors.red)),
                      //       TextSpan(text: " and leave me"),
                      //     ],
                      //   ),
                      // ),
                      Copy_Post_Text
                          ? Tooltip(
                              preferBelow: true,
                              message: 'Copy'.tr,
                              onTriggered: () {
                                Clipboard.setData(
                                    new ClipboardData(text: widget.postText));
                              },
                              child: Text(
                                widget.postText,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )
                          : Text(
                              widget.postText,
                              style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),

                    if (widget.options.toString() != '[]')
                      Container(
                        child: FlutterPolls(
                          onVoted:
                              (PollOption pollOption, int newTotalVotes) async {
                            return true;
                          },
                          pollId: widget.options[0]['id'],
                          pollOptions: [
                            for (var i = 0; i < widget.options.length; i++)
                              if (widget.options[i] != null)
                                //redme.md go
                                PollOption(
                                    // id: options[i]['id'],
                                    title: Text(widget.options[i]['text']),
                                    votes: widget.options[i]['all']),
                          ],
                          pollTitle: Text(''),
                          pollEnded: false,
                        ),
                      ),
                    //postRecord
                    if (widget.postRecord.isNotEmpty)
                      WidgetSond(
                        postRecord: widget.postRecord,
                      ),
                    //post Audio Sond
                    if (widget.postFile.isAudioFileName)
                      WidgetSondPostFile(
                        postFile: widget.postFile,
                      ),

                    if (widget.photoMulti2.toString().isNotEmpty)
                      TestWidget(
                        photoMulti2: widget.photoMulti2,
                        contLike: widget.contLike,
                        type: widget.type,
                        islike: widget.islike,
                        contcoment: widget.contcoment,
                        post_id: widget.post_id,
                        postimage: widget.postimage,
                      ),
                    if (widget.photo_album.toString() != '[]')
                      TestWidget(
                        photoMulti2: widget.photo_album,
                        contLike: widget.contLike,
                        type: widget.type,
                        islike: widget.islike,
                        contcoment: widget.contcoment,
                        post_id: widget.post_id,
                        postimage: widget.postimage,
                      ),

                    //posts images
                    if (widget.postFile.isImageFileName)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Get.height * 0.35,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    spreadRadius: 0.1)
                              ],
                              borderRadius: BorderRadius.circular(30)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl:
                                    accounts[0]['sm0'] + '/' + widget.postFile,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    //posts video
                    if (VideoEx(widget.postFile))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: VideoFFmpeg(
                            PostFile: widget.postFile,
                            p720p: widget.p720p,
                            p480p: widget.p720p,
                            p1080p: widget.p1080p,
                            p240p: widget.p240p,
                            p360p: widget.p360p,
                            p4096p: widget.p4096p,
                            p2048p: widget.p2048p,
                          ),
                        ),
                      ),

                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.dialog(GetAllRectionScreen(
                              id: widget.post_id,
                              reply: 'fetch_comments',
                            ));
                          },
                          child: Container(
                              width: Get.width * 0.40,
                              child: Text('❤ 👍 ${widget.contLike}')),
                        ),
                        Row(
                          children: [
                            Text(widget.contcoment),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Text('Comment'.tr),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    //////widget like
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width * 0.25,
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffE2E8F0),
                                      spreadRadius: 2),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: ReactionBut(
                                      mines: () {
                                        setState(() {
                                          widget.contLike--;
                                        });
                                      },
                                      imReaction: widget.imReaction,
                                      contt: widget.reaction,
                                      post_id: widget.post_id,
                                      likeplus: () {
                                        setState(() {
                                          widget.contLike++;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffE2E8F0),
                                      spreadRadius: 2),
                                ]),
                            child: InkWell(
                              onTap: () {
                                Get.to(CommentScreen(
                                  post_id: widget.post_id,
                                  fetch_comments: 'fetch_comments', contcoment: null,
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: Get.width * 0.25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        SvgImages.CommentBtn,
                                        height: 20,
                                        width: 20,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      SizedBox(width: Get.width * 0.01),
                                      Text('Commentt'.tr,
                                          style: SafeGoogleFont(Fonts.font3,
                                              fontSize: 14,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width * 0.25,
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffE2E8F0),
                                      spreadRadius: 2),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      SvgImages.ShareBtn,
                                      height: 20,
                                      width: 20,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Center(
                                      child: Text('Share'.tr,
                                          style: SafeGoogleFont(Fonts.font2,
                                              fontSize: 14,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
