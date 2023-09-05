import 'package:cached_network_image/cached_network_image.dart';
import 'package:detectable_text_field/detector/detector.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:flutter_social_textfield/flutter_social_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/broadcast_page.dart';
import 'package:wowondertimelineflutterapp/Screens/Comment/CommentScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Events/EventsFetchScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/GroupsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/HashtagPosts/HashtagPostsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/AdsBoostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/GetAllRectionScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/ImageZoomWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/PhotoView.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/ProductWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/postYoutubeScree.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/ReactionButton.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/WidgetShare.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetColorPost.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetColorPostModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/ColorPost.dart';
import 'package:wowondertimelineflutterapp/Widget/VideoFmmpeg.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetAudio.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetFellingIcons.dart';

class WidgetPosts extends StatefulWidget {
  WidgetPosts({
    required this.url_post,
    required this.trueflasecommet,
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
    required this.shared_info,
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
    required this.stream_name,
    required this.product_id,
    required this.product,
    required this.event,
    required this.yout,
    required this.Boosted,
    required this.headline,
    required this.nameAds,
    required this.descriptionAds,
    required this.ad_media,
    required this.biddingAds,
    required this.user_dataAds,
    required this.is_pro,
    required this.pro_type,
    required this.blur,
    super.key,
    required this.color_id,
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
  final user_dataAds;
  String nameAds;
  String ad_media;
  String biddingAds;
  String descriptionAds;
  String headline;
  final reaction;
  String post_id;
  final shared_info;
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
  int contcoment;
  final postimage;
  String page_id;
  String group_id;
  String avatar_group;
  String name_group;
  String cover;
  String yout;
  String blur;
  final comment_cont;
  final product_id;
  final product;
  final event;
  final trueflasecommet;
  String url_post;

  String pro_type;
  String is_pro;
  bool Boosted;
  String stream_name;
  final String color_id;

  @override
  State<WidgetPosts> createState() => _WidgetPostsState();
}

class _WidgetPostsState extends State<WidgetPosts> {
  bool hasHashTags(String value) {
    final decoratedTextColor = Colors.blue;
    final detector = Detector(
        textStyle: TextStyle(),
        detectedStyle: TextStyle(color: decoratedTextColor),
        detectionRegExp: RegExp(''));
    final result = detector.getDetections(value);
    final detections = result
        .where((detection) => detection.style!.color == decoratedTextColor)
        .toList();
    return detections.isNotEmpty;
  }

  var uid = Uuid();
  int color1 = 0xff8080c0;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: widget.postType == 'ad'
              ? AdsWbeSite(
                  ad_media: widget.ad_media,
                  biddingAds: widget.biddingAds,
                  descriptionAds: widget.descriptionAds,
                  headline: widget.headline,
                  nameAds: widget.nameAds,
                  urlss: widget.url_post,
                  user_dataAds: widget.user_dataAds,
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  ),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode ? ColorDarkComponents : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.Boosted)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: ColorTheme,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Boosted',
                                          style: SafeGoogleFont(Fonts.font2,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (widget.adminPost) {
                                          if (widget.page_id.isNotEmpty)
                                            Get.to(HomePagesScreen(
                                              page_id: widget.page_id,
                                            ));
                                        } else if (widget.group_id.isNotEmpty) {
                                        } else if (widget.page_id.isNotEmpty) {
                                          Get.to(HomePagesScreen(
                                            page_id: widget.page_id,
                                          ));
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
                                          ? InkWell(
                                              onTap: () {
                                                Get.to(GroupsScreen(
                                                    group_id: widget.group_id));
                                              },
                                              child: Container(
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
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: CachedNetworkImageProvider(
                                                                      widget
                                                                          .avatar_group)),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      child: CircleAvatar(
                                                        maxRadius: 15,
                                                        backgroundColor:
                                                            Colors.black,
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
                                              ),
                                            )
                                          : CircleAvatar(
                                              maxRadius: 25,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            child: Row(children: [
                                              Container(
                                                child: Text(
                                                  Stringlength(
                                                    text: widget.name,
                                                    length: 18,
                                                  ),
                                                  style: GoogleFonts.cairo(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              if (widget.verified == '1')
                                                Icon(Icons.verified,
                                                    size: 14,
                                                    color: ColorTheme),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),

                                              //Membership
                                              if (widget.is_pro == '1')
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              2, 2, 2, 2),
                                                      decoration: BoxDecoration(
                                                        color: widget
                                                                    .pro_type ==
                                                                '1'
                                                            ? Change_Color_Icons
                                                                ? null
                                                                : Color(
                                                                    0xFFE57373) // Star - Red
                                                            : widget.pro_type ==
                                                                    '2'
                                                                ? Change_Color_Icons
                                                                    ? null
                                                                    : Color(
                                                                        0xFFFFB74D) // Hot - Orange
                                                                : widget.pro_type ==
                                                                        '3'
                                                                    ? Change_Color_Icons
                                                                        ? null
                                                                        : Color(
                                                                            0xFF4FC3F7) // Ultima - Blue
                                                                    : widget.pro_type ==
                                                                            '4'
                                                                        ? Change_Color_Icons
                                                                            ? null
                                                                            : Color(
                                                                                0xFF9C27B0) // V
                                                                        // IP - Purple
                                                                        : Color(
                                                                            0xFFE0E0E0),
                                                        // Unknown - Gray
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Tooltip(
                                                        message: widget
                                                                    .pro_type ==
                                                                '1'
                                                            ? 'Star'.tr
                                                            : widget.pro_type ==
                                                                    '2'
                                                                ? 'Hot'.tr
                                                                : widget.pro_type ==
                                                                        '3'
                                                                    ? 'Ultima'
                                                                        .tr
                                                                    : widget.pro_type ==
                                                                            '4'
                                                                        ? 'VIP'
                                                                            .tr
                                                                        : 'Unknown'
                                                                            .tr,
                                                        child: SvgPicture.asset(
                                                          widget.pro_type == '1'
                                                              ? Change_Color_Icons
                                                                  ? ColorSvg
                                                                      .Star
                                                                  : SvgImages
                                                                      .Star
                                                              : widget.pro_type ==
                                                                      '2'
                                                                  ? Change_Color_Icons
                                                                      ? ColorSvg
                                                                          .Hot
                                                                      : SvgImages
                                                                          .Hot
                                                                  : widget.pro_type ==
                                                                          '3'
                                                                      ? Change_Color_Icons
                                                                          ? ColorSvg
                                                                              .Ultima
                                                                          : SvgImages
                                                                              .Ultima
                                                                      : widget.pro_type ==
                                                                              '4'
                                                                          ? Change_Color_Icons
                                                                              ? ColorSvg.Vip
                                                                              : SvgImages.Vip
                                                                          : 'Unknown'.tr,
                                                          color:
                                                              Change_Color_Icons
                                                                  ? null
                                                                  : Colors
                                                                      .white,
                                                          width: 12,
                                                          height: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              if (widget.postType ==
                                                  'profile_picture')
                                                Container(
                                                  // width: Get.width * 0.44,
                                                  child: Text(
                                                    'Change his Profile Picture'
                                                        .tr,
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
                                            ]),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4),
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
                              height: Get.height * 0.01,
                            ),
                            ///////posts text
                            ///
                            if (widget.yout.isNotEmpty)
                              postYoutubeScreen(
                                yout: widget.yout,
                              ),
                            if (widget.product_id.toString().isNotEmpty)
                              if (widget.product_id != '0')
                                ProductWidget(product: widget.product),
                            if (widget.event.toString().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        width: Get.width,
                                        height: Get.height * 0.25,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                              imageUrl: widget.event['cover'],
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          color: Color.fromARGB(33, 8, 2, 2),
                                        ),
                                        width: Get.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.event['name'],
                                                style: GoogleFonts.cairo(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                widget.event['location'],
                                                style: GoogleFonts.cairo(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.grey),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    widget.event['start_date'],
                                                    style: GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    'Going People'.tr,
                                                    style: GoogleFonts.cairo(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(EventsFetchScreen(
                                                    descirp: widget
                                                        .event['description'],
                                                    end_date: widget
                                                        .event['end_date'],
                                                    going: '0',
                                                    imagee:
                                                        widget.event['cover'],
                                                    interested: '0',
                                                    is_going: false,
                                                    is_interested: false,
                                                    location: 'location'.tr,
                                                    start_date: widget.event[
                                                        'start_edit_date'],
                                                    title: widget.event['name'],
                                                  ));
                                                },
                                                child: Center(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    width: Get.width * 0.60,
                                                    decoration: BoxDecoration(
                                                        color: ColorTheme,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        'View'.tr,
                                                        style:
                                                            GoogleFonts.cairo(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            // if (postText.isNotEmpty)
                            //   SelectableText.rich(
                            //     TextSpan(
                            //       children: [
                            //         TextSpan(
                            //             text: postText,
                            //             style: TextStyle(color: Colors.red)),
                            //         TextSpan(text: " and leave me"),
                            //       ],
                            //     ),
                            //   ),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            // if (widget.shared_info.toString().isNotEmpty)
                            //   Text('Post shared'.tr,
                            //       style:
                            //           TextStyle(fontWeight: FontWeight.w700)),
                            // if (widget.shared_info.toString().isNotEmpty)
                            //   Icon(Icons.share),
                            if (widget.shared_info.toString().isNotEmpty)
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, bottom: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0x90D7D7D7), width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(ProfileUserScreen(
                                            avat:
                                                widget.shared_info['publisher']
                                                    ['avatar'],
                                            user_id:
                                                widget.shared_info['publisher']
                                                    ['user_id'],
                                            cover:
                                                widget.shared_info['publisher']
                                                    ['cover'],
                                            name:
                                                widget.shared_info['publisher']
                                                    ['name'],
                                          ));
                                        },
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  widget.shared_info[
                                                      'publisher']['avatar']),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.01,
                                            ),
                                            Text(widget.shared_info['publisher']
                                                ['name']),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Text(
                                          widget.shared_info['postText'] == null
                                              ? ''
                                              : widget.shared_info['postText']
                                                  .toString()
                                                  .replaceAll('<br>', '\n')
                                                  .replaceAll('&#039;', '\''),
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            if (widget.stream_name.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  Get.to(BroadcastPage(
                                    username: widget.name,
                                    avat: widget.avat,
                                    postid: widget.post_id,
                                    isBroadcaster: false,
                                    channelName: widget.stream_name,
                                    token: null,
                                  ));
                                },
                                child: Center(
                                    child: Container(
                                  height: Get.height * 0.60,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          widget.avat,
                                        ),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            const Color.fromARGB(108, 0, 0, 0),
                                      ),
                                      height: Get.height,
                                      width: Get.width,
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 182, 24, 13),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 8),
                                            child: Text(
                                              'Live',
                                              style: SafeGoogleFont(Fonts.font2,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: CircleAvatar(
                                          maxRadius: 30,
                                          child: Icon(
                                            Icons.play_arrow,
                                            size: 30,
                                          )),
                                    )
                                  ]),
                                )),
                              ),
                            widget.color_id == '0'
                                // true
                                ? Tooltip(
                                    preferBelow: true,
                                    message: 'Copy'.tr,
                                    onTriggered: () {
                                      Clipboard.setData(new ClipboardData(
                                          text: widget.postText));
                                    },
                                    child: DetectableText(
                                      trimCollapsedText: '\nSee More...'.tr,
                                      trimExpandedText: '\nShow less'.tr,
                                      // trimExpandedText: 'show less'.tr,
                                      // trimCollapsedText: 'read more'.tr,
                                      trimLines: 4,

                                      text: widget.postText
                                          .replaceAll('<br>', '\n')
                                          .replaceAll('&#039;', '\''),
                                      detectedStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                      ),
                                      basicStyle: GoogleFonts.cairo(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      onTap: (tappedText) async {
                                        if (hasHashTags(tappedText)) {
                                          Get.to(HashtagPostsScreen(
                                            titel: tappedText,
                                          ));
                                        }
                                        ;

                                        RegExp exp = RegExp(
                                            "([@]([$detectionContentLetters]+))|$urlRegexContent",
                                            multiLine: true);

                                        Iterable<RegExpMatch> matches =
                                            exp.allMatches(widget.postText);
                                        for (final m in matches) {
                                          if (m[0].toString().isNotEmpty) {
                                            var username =
                                                await GetUserDataUserName
                                                    .getUserData(m[0]
                                                        .toString()
                                                        .replaceAll('@', ''));
                                            if (username != null) {
                                              Get.to(ProfileUserScreen(
                                                  avat: username['avatar'],
                                                  user_id: username['user_id'],
                                                  cover: username['cover'],
                                                  name: username['name']));
                                            } else {
                                              UrlGo(m[0].toString());
                                            }
                                          }
                                        }
                                      },
                                      detectionRegExp: RegExp(
                                        "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                        multiLine: true,
                                      ),
                                    ),
                                  )
                                // :  SizedBox(),

////////////////////////////////////////////////////////////////////////////////ColorPost
                                : ColorPosts(
                                    postText: widget.postText,
                                    color_id: widget.color_id,
                                  ),
                            ///////////////////////////////////////////////ColorPost
                            if (widget.options != null)
                              if (widget.options.toString() != '[]')
                                Container(
                                  child: FlutterPolls(
                                    onVoted: (PollOption pollOption,
                                        int newTotalVotes) async {
                                      print(newTotalVotes);
                                      return true;
                                    },
                                    pollId: widget.options[0]['id'],
                                    pollOptions: [
                                      for (var i = 0;
                                          i < widget.options.length;
                                          i++)
                                        if (widget.options[i] != null)
                                          //redme.md go
                                          PollOption(
                                              id: int.parse(
                                                  widget.options[i]['id']),
                                              title: Text(
                                                  widget.options[i]['text']),
                                              votes: widget.options[i]['all']),
                                    ],
                                    pollTitle: Text(''),
                                    pollEnded: false,
                                    hasVoted: false,
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
                              widget.blur == '0'
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(ImageZoomWidget(
                                          reaction: widget.contLike.toString(),
                                          comments:
                                              widget.contcoment.toString(),
                                          imageapi: widget.postimage,
                                          contLike: widget.contLike,
                                          type: widget.type,
                                          islike: widget.islike,
                                          contcoment: widget.contcoment,
                                          post_id: widget.post_id,
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Container(
                                          height: Get.height * 0.35,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    blurRadius: 1,
                                                    spreadRadius: 0.1)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: widget.postFile,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        Get.to(ImageZoomWidget(
                                          reaction: widget.contLike.toString(),
                                          comments:
                                              widget.contcoment.toString(),
                                          imageapi: widget.postimage,
                                          contLike: widget.contLike,
                                          type: widget.type,
                                          islike: widget.islike,
                                          contcoment: widget.contcoment,
                                          post_id: widget.post_id,
                                        ));
                                      },
                                      child: Padding(
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
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: widget.postFile,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                            //posts video
                            if (VideoEx(widget.postFile))
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                            if (!widget.shared_info.toString().isNotEmpty)
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
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            images.Like,
                                            height: 15,
                                            width: 15,
                                          ),
                                          Image.asset(
                                            images.Love,
                                            height: 15,
                                            width: 15,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                          Text('${widget.contLike}')
                                        ],
                                      )),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (widget.trueflasecommet == '1')
                                      Get.to(CommentScreen(
                                        post_id: widget.post_id,
                                        fetch_comments: 'fetch_comments',
                                        contcoment: () {
                                          setState(() {
                                            widget.contcoment++;
                                          });
                                        },
                                      ));
                                  },
                                  child: Row(
                                    children: [
                                      Text(widget.contcoment.toString()),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Text('Comment'.tr),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.002,
                            ),
                            Divider(),

                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? ColorDarkBackground
                                          : ColorBackIcons,
                                      borderRadius: BorderRadius.circular(5),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Color(0xffE2E8F0),
                                      //       spreadRadius: 2),
                                      // ]
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
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
                                  )),
                                  widget.trueflasecommet == '0'
                                      ? Container(
                                          width: Get.width * 0.001,
                                        )
                                      : SizedBox(
                                          width: Get.width * 0.012,
                                        ),
                                  widget.trueflasecommet == '0'
                                      ? SizedBox(
                                          width: Get.width * 0.012,
                                        )
                                      : Expanded(
                                          child: Container(
                                          decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? ColorDarkBackground
                                                : ColorBackIcons,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //       color: Color(0xffE2E8F0),
                                            //       spreadRadius: 2),
                                            // ]
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (widget.trueflasecommet == '1')
                                                Get.to(CommentScreen(
                                                    post_id: widget.post_id,
                                                    fetch_comments:
                                                        'fetch_comments',
                                                    contcoment: () {
                                                      setState(() {
                                                        widget.contcoment++;
                                                      });
                                                    }),
                                                    );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      Change_Color_Icons
                                                          ? ColorSvg.CommentBtn
                                                          : SvgImages
                                                              .CommentBtn,
                                                      height: 20,
                                                      width: 20,
                                                      color: Change_Color_Icons
                                                          ? null
                                                          : Get.isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            Get.width * 0.01),
                                                    Text('Comments'.tr,
                                                        style: SafeGoogleFont(
                                                            Fonts.font3,
                                                            fontSize: 14,
                                                            color: Get
                                                                    .isDarkMode
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  SizedBox(
                                    width: Get.width * 0.012,
                                  ),
                                  Expanded(
                                      child: Container(
                                    width: Get.width * 0.25,
                                    decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? ColorDarkBackground
                                          : ColorBackIcons,
                                      borderRadius: BorderRadius.circular(5),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Color(0xffE2E8F0),
                                      //       spreadRadius: 2),
                                      // ]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: InkWell(
                                        onTap: () {
                                          Get.bottomSheet(WidgetShare(
                                            url_post: widget.url_post,
                                            postid: widget.post_id,
                                          ));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              Change_Color_Icons
                                                  ? ColorSvg.ShareBtn
                                                  : SvgImages.ShareBtn,
                                              height: 20,
                                              width: 20,
                                              color: Change_Color_Icons
                                                  ? null
                                                  : Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Center(
                                              child: Text('Share'.tr,
                                                  style: SafeGoogleFont(
                                                      Fonts.font2,
                                                      fontSize: 14,
                                                      color: Get.isDarkMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      );
    });
  }
}

class NewWidget extends StatelessWidget {
  NewWidget({
    super.key,
    required this.postText,
  });

  String postText;

  @override
  Widget build(BuildContext context) {
    final parse = <MatchText>[
      MatchText(
          type: ParsedType.EMAIL,
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
          ),
          onTap: (url) {
            launch("mailto:" + url);
          }),
      MatchText(
          type: ParsedType.URL,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
          onTap: (url) async {
            var a = await canLaunch(url);

            if (a) {
              launch(url);
            }
          }),
      MatchText(
          type: ParsedType.PHONE,
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
          ),
          onTap: (url) {
            launch("tel:" + url);
          }),
      MatchText(
        type: ParsedType.CUSTOM,
        pattern:
            r"^(?:http|https):\/\/[\w\-_]+(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)",
        style: TextStyle(color: Colors.lime),
        onTap: (url) => print(url),
      ),
      MatchText(
        pattern: r"\B#+([\w]+)\b",
        style: TextStyle(
          color: Colors.pink,
          fontSize: 24,
        ),
        onTap: (url) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Hashtag clicked"),
                content: new Text("$url clicked."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new ElevatedButton(
                    child: new Text("Close"),
                    onPressed: () {},
                  ),
                ],
              );
            },
          );
        },
        // onLongTap: (url) {
        //   print('long press');
        // },
      ),
      MatchText(
          pattern: r"lon",
          style: TextStyle(
            color: Colors.pink,
            fontSize: 24,
          ),
          onTap: (url) async {})
    ];
    return Column(
      children: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ParsedText(
        //     alignment: TextAlign.start,
        //     text:
        //         "[@michael:51515151] Hello  --- spoiler ---\n\n spoiler content \n--- spoiler ---\n  https://172.0.0.1 london this is https://apps.apple.com/id/app/facebook/id284882215  an example of the ParsedText, links like http://www.google.com or http://www.facebook.com are clickable and phone number 444-555-6666 can call too. But you can also do more with this package, for example Bob will change style and David too.\nAlso a US number example +1-(800)-831-1117. foo@gmail.com And the magic number is 42! #flutter #flutterdev",
        //     parse: [],
        //     style: TextStyle(
        //       fontSize: 24,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        FormattedText(postText)
      ],
    );
  }
}

// Text(
//         postText,
//         style: GoogleFonts.cairo(
//             fontWeight: FontWeight.bold, fontSize: 16),
//       );

class FormattedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;

  final parse = <MatchText>[
    MatchText(
      pattern: ParsedType.EMAIL.name,
      renderWidget: ({required pattern, required text}) => Text(
        text,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: (String username) {
        print(username.substring(1));
      },
    ),
  ];

  FormattedText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);

    return ParsedText(
      text: text,
      style: SafeGoogleFont(Fonts.font1,
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17),
      alignment: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
      textDirection: textDirection ?? Directionality.of(context),
      overflow: TextOverflow.clip,
      maxLines: maxLines ?? defaultTextStyle.maxLines,
      parse: parse,
      regexOptions: RegexOptions(caseSensitive: false),
    );
  }
}
