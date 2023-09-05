import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/Screens/AddPost/CreatePostScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/MembersGroupScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/ReportScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/ScreenUpdateGroupData.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetGroupData.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiJoinGroup.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPostGroups.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetGroupDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';

class GroupsScreen extends StatefulWidget {
  String group_id;
  GroupsScreen({required this.group_id, super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  String? lastId;
  List<GetGroupDataModel> dataGroup = [];
  List<PostModel> data = [];
  void initState() {
    dataGroups();
    ;
    GetPostsAll();
    super.initState();
  }

  bool join = true;
  GetPostsAll() async {
    await ApiPostGruops.Getposts(widget.group_id, '0').then((val) => {
          setState(() {
            data = val.toList();
            lastId = val[val.length - 1].post_id;
          }),
        });
  }

  dataGroups() async {
    await ApiGetGroupData.getdata(widget.group_id).then((value) => {
          setState(() {
            dataGroup = value.toList();
          }),
        });
    print('test updite');
  }

  ////images Uplode
  XFile? ImagePost;
  String? filename;
  XFile? ImagePost2;
  String? filename2;
  final ImagePicker _picker = ImagePicker();
  void ImageUplode() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    image = await _cropImage(image!);
    image;

    setState(() {
      filename = image!.path.split('/').last;
      ImagePost = image;
      print(image.path);

      ;
    });
  }

  Future<XFile?> _cropImage(XFile filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper'.tr,
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper'.tr,
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return XFile(croppedFile!.path);
  }

  final ImagePicker _picker2 = ImagePicker();
  void ImageUplode2() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    image = await _cropImage2(image!);
    image;

    setState(() {
      filename2 = image!.path.split('/').last;
      ImagePost2 = image;
      print(image.path);

      ;
    });
  }

  Future<XFile?> _cropImage2(XFile filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'test',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper'.tr,
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return XFile(croppedFile!.path);
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ///Image uplode

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await ApiPostGruops.Getposts(widget.group_id, lastId!);

    // print('onLoding');
    // print(lastId);
    // print(list.length - 1);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].post_id;

    // if (list.length - 1 == -1) {
    //   post = true;
    // } else {
    //   post = false;
    // }
    setState(() {
      refreshController.loadComplete();
      lastId == null ? dispose() : data.addAll(list);
    });
  }

  void onRefresh() async {
    var list = await await ApiPostGruops.Getposts(widget.group_id, '0');

    setState(() {
      data.clear();
      data.addAll(list.toList());

      refreshController.refreshCompleted();

      lastId = data[data.length - 1].post_id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        onLoading: onLoding,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: Get.height * 0.40,
              width: Get.width,
              child: Stack(children: [
                for (var i = 0; i < dataGroup.length; i++)
                  Stack(
                    children: [
                      ImagePost2 != null
                          ? Container(
                              height: Get.height * 0.23,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          FileImage(File(ImagePost2!.path)))),
                            )
                          : Container(
                              height: Get.height * 0.23,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        dataGroup[i].cover.replaceAll(' ', ''),
                                      ))),
                            ),
                      for (var i = 0; i < dataGroup.length; i++)
                        if (ImagePost2 != null)
                          Positioned(
                              bottom: 5,
                              right: 50,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 0, 0),
                                      child: IconButton(
                                        onPressed: () async {
                                          var uplo =
                                              await ApiUplodeImageAvatirGroups
                                                  .Getposts(
                                            widget.group_id,
                                            null,
                                            ImagePost2!.path,
                                          );
                                          ImagePost2 = null;
                                          if (await uplo['message'] ==
                                              'Your group was updated') {
                                            dataGroups();
                                            GetPostsAll();
                                            Get.snackbar(
                                                'Upload'.tr,
                                                'The image has been uploaded'
                                                    .tr);
                                          }
                                        },
                                        icon: Icon(Icons.save),
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 0, 0),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            //197 id Groups
                                            ImagePost2 = null;
                                          });
                                        },
                                        icon: Icon(Icons.cancel),
                                        color: Colors.white,
                                      )),
                                ],
                              )),
                      if (dataGroup[i].is_owner)
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                child: IconButton(
                                  onPressed: ImageUplode2,
                                  icon: Icon(Icons.camera_alt),
                                  color: Colors.white,
                                ))),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: Get.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(92, 0, 0, 0),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          for (var i = 0; i < dataGroup.length; i++)
                            showAdaptiveActionSheet(
                              context: context,

                              actions: <BottomSheetAction>[
                                BottomSheetAction(
                                  title: Text('Report'.tr),
                                  onPressed: (BuildContext context) {
                                    Get.dialog(WidgetReportUser(
                                        user_id: data[i].user_id,
                                        name: data[i].name,
                                        Report: 'Report Group'.tr));
                                  },
                                ),
                              ],
                              cancelAction: CancelAction(
                                  title: Text('Cancel'
                                      .tr)), // onPressed parameter is optional by default will dismiss the ActionSheet
                            );
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(92, 0, 0, 0),
                          child: Icon(
                            Icons.more_vert_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            for (var i = 0; i < dataGroup.length; i++)
                              Stack(
                                children: [
                                  ImagePost == null
                                      ? CircleAvatar(
                                          maxRadius: 53,
                                          child: CircleAvatar(
                                            maxRadius: 50,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    dataGroup[i]
                                                        .avatar
                                                        .replaceAll(' ', '')),
                                          ),
                                        )
                                      : CircleAvatar(
                                          maxRadius: 53,
                                          child: CircleAvatar(
                                            maxRadius: 50,
                                            backgroundImage: FileImage(
                                                File(ImagePost!.path)),
                                          ),
                                        ),
                                  if (dataGroup[i].is_owner)
                                    Positioned(
                                        bottom: 1,
                                        right: 2,
                                        child: CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(255, 0, 0, 0),
                                            child: IconButton(
                                              splashRadius: 10,
                                              onPressed: ImageUplode,
                                              icon: Center(
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )))
                                ],
                              ),
                            if (ImagePost != null)
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // ImagePost
                                      var uplo =
                                          await ApiUplodeImageAvatirGroups
                                              .Getposts(
                                        widget.group_id,
                                        ImagePost!.path,
                                        null,
                                      );
                                      ImagePost = null;
                                      if (await uplo['message'] ==
                                          'Your group was updated') {
                                        dataGroups();
                                        GetPostsAll();
                                        Get.snackbar('Upload'.tr,
                                            'The image has been uploaded'.tr);
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colorTextBoardingDark1),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Save'.tr,
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ImagePost = null;
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: colorTextBoardingDark1),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Cancel'.tr,
                                            style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            for (var i = 0; i < dataGroup.length; i++)
                              Text(
                                dataGroup[i].group_title,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            for (var i = 0; i < dataGroup.length; i++)
                              Text(
                                'Members '.tr + dataGroup[i].members_count,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            for (var i = 0; i < dataGroup.length; i++)
                              if (dataGroup[i].is_owner == false)
                                _JoinWidgetGroup(
                                  is_group_joined: dataGroup[i].is_group_joined,
                                  group_id: widget.group_id,
                                ),
                            for (var i = 0; i < dataGroup.length; i++)
                              if (dataGroup[i].is_owner)
                                InkWell(
                                  onTap: () {
                                    Get.to(ScreenUpdateGroupData(
                                      group_id: widget.group_id,
                                      ontapEdit: () async {
                                        await ApiGetGroupData.getdata(
                                                widget.group_id)
                                            .then((value) => {
                                                  setState(() {
                                                    dataGroup = value.toList();
                                                  }),
                                                });

                                        await ApiPostGruops.Getposts(
                                                widget.group_id, '0')
                                            .then((val) => {
                                                  setState(() {
                                                    data = val.toList();
                                                  }),
                                                });
                                      },
                                    ));
                                    ;
                                  },
                                  child: Container(
                                    width: Get.width * 0.5,
                                    decoration: BoxDecoration(
                                        color: colorTextBoardingDark1,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                          child: Text(
                                        'Edit'.tr,
                                        style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      )),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Divider(),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: InkWell(
                      onTap: () {
                        Get.to(MembersGroupScreen(
                          group_id: widget.group_id,
                        ));
                      },
                      child: Container(
                        width: Get.width * 0.30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Members'.tr,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                              for (var i = 0; i < dataGroup.length; i++)
                                Text(
                                  dataGroup[i].members_count.toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.10,
                  ),
                  Container(
                    color: Colors.black,
                    height: Get.height * 0.05,
                    width: 0.1,
                  ),
                  SizedBox(
                    width: Get.width * 0.10,
                  ),
                  Card(
                    child: Container(
                      width: Get.width * 0.30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Post'.tr,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                            ),
                            for (var i = 0; i < dataGroup.length; i++)
                              Text(
                                dataGroup[i].post_count,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(
                      103,
                      158,
                      158,
                      158,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(CreatePostScreen(),
                            arguments: ({'group_id': widget.group_id}));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            GetBuilder<GetMyUserDataCont>(
                                init: GetMyUserDataCont(),
                                builder: ((controller) => Row(
                                      children: [
                                        for (var i = 0;
                                            i < controller.data.length;
                                            i++)
                                          CircleAvatar(
                                            maxRadius: 15,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                                    controller.data[i].avatar
                                                        .replaceAll(' ', '')),
                                          ),
                                        SizedBox(),
                                        Text(
                                          'Write your post here ?'.tr,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/smile.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            for (var i = 0; i < data.length; i++)
              Column(
                children: [
                  WidgetPosts(
                    blur: data[i].blur,
                    color_id: data[i].color_id,
                    stream_name: data[i].stream_name,
                    pro_type: data[i].pro_type,
                    is_pro: data[i].is_pro,
                    ad_media: data[i].ad_media,
                    biddingAds: data[i].biddingAds,
                    descriptionAds: data[i].descriptionAds,
                    nameAds: data[i].nameAds,
                    user_dataAds: data[i].user_dataAds,
                    headline: data[i].headline,
                    Boosted: false,
                    yout: data[i].postYoutube,
                    shared_info: data[i].shared_info,
                    url_post: data[i].urlsss,
                    trueflasecommet: data[i].comments_status,
                    event: data[i].event,
                    product_id: data[i].product_id,
                    product: data[i].product,
                    more: Container(
                        child: IconButton(
                            onPressed: () {
                              Get.bottomSheet(
                                WidgetMorePosts(
                                  url_post: data[i].urlsss,
                                  refreshPost: () {
                                    GetPostsAll();
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
                    postFile: data[i].postFile,
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
                    contcoment: int.parse(data[i].post_comments),
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
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    height: Get.height * 0.01,
                  )
                ],
              ),
          ]),
        ),
      ),
    );
  }
}

class _JoinWidgetGroup extends StatefulWidget {
  _JoinWidgetGroup({
    super.key,
    required this.group_id,
    required this.is_group_joined,
  });
  final is_group_joined;
  String group_id;

  @override
  State<_JoinWidgetGroup> createState() => _JoinWidgetGroupState();
}

class _JoinWidgetGroupState extends State<_JoinWidgetGroup> {
  @override
  bool join = true;

  _ameen() {
    setState(() {
      if (widget.is_group_joined == 0) join = true;
      if (widget.is_group_joined == 1) join = false;
    });
  }

  @override
  void initState() {
    _ameen();
    super.initState();
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (join == true) {
          var joins = await ApiJoinGroup.joinG(widget.group_id);
          Get.snackbar('', joins['join_status']);
          setState(() {
            join = !join;
          });
        } else {
          QuickAlert.show(
            onConfirmBtnTap: () async {
              await ApiJoinGroup.joinG(widget.group_id);

              setState(() {
                join = !join;
              });
              Get.back(closeOverlays: true);

              Get.snackbar(
                'left the group'.tr,
                '',
              );
            },
            context: context,
            type: QuickAlertType.confirm,
            text: 'left the group'.tr,
            confirmBtnText: 'Yes'.tr,
            cancelBtnText: 'No'.tr,
            confirmBtnColor: Colors.red,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: join ? colorTextBoardingDark1 : Colors.orange[700],
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                join ? Icons.add_box_rounded : Icons.verified_user_outlined,
                color: Colors.white,
              ),
              Text(
                join ? 'Join'.tr : 'Joined'.tr,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
