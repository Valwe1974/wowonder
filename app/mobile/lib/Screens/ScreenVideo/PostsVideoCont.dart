import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPostsVideo.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';

class PostsVideoCont extends GetxController {
  var isLoding = true;
  RxBool like = false.obs;
  String? lastId;
  bool post = false;
  RxInt commentsCount = 0.obs;
  RxBool savebost = false.obs;
  RxBool reboort = false.obs;
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  RxList<PostModel> data = <PostModel>[].obs;

  void LikeIndex(index) {
    data[index].is_reacted = !data[index].is_reacted;
    update();
  }

  @override
  void onInit() {
    GetPosts();
    // Platform.isAndroid ? notf() : null;
    // Platform.isIOS ? notfIos() : null;

    super.onInit();
  }

  void deltepost(i) {
    data.removeAt(i);
    update();
  }

  void GetPosts() async {
    ApiPostsVideo.Getposts('0').then((value) {
      data.value = value.toList();
    });
    var list = await ApiPostsVideo.Getposts('0');
    lastId = list[list.length - 1].post_id;

    update();
  }

  // void ScvePost(post_id, save) {
  //   savebost.value = save;
  //   PostActionsApi.reaction(post_id, 'save');
  // }

  // void Rebort(
  //   post_id,
  // ) {
  //   PostActionsApi.reaction(post_id, 'report');

  //   GetPosts();
  //   update();
  // }

  void onRefresh() async {
    data.clear();
    print('onRefresh');
    var list = await ApiPostsVideo.Getposts(lastId!.isNotEmpty ? '0' : lastId!);

    data.addAll(list.toList());

    refreshController.refreshCompleted();
    post = false;
    update();

    var list2 = await ApiPostsVideo.Getposts('0');
    lastId = list2[list2.length - 1].post_id;
  }

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await ApiPostsVideo.Getposts(lastId!);

    print('onLoding');
    print(lastId);
    print(list.length - 1);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].post_id;
    lastId == null ? onClose() : data.addAll(list);
    if (list.length - 1 == -1) {
      post = true;
    } else {
      post = false;
    }
    refreshController.loadComplete();

    update();
  }

  void ComeentUpdate(index) {
    commentsCount.value = int.parse(data[index].post_comments);
    update();
  }

  bool ameen = false;
  void PostDelte(postid, i, context) {
    Get.defaultDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        textCancel: 'No'.tr,
        textConfirm: 'Yes'.tr,
        middleText: 'Do you want to delete the post!'.tr,
        onCancel: () {},
        onConfirm: () {
          // ApiPostReaction.postReaction(postid, 'delete').asStream();
          data.removeAt(i);
          Get.back(closeOverlays: true);
          update();
        });
  }

  commentPlus(index) {
    commentsCount++;
  }
  // void notf() async {
  //   final status = await OneSignal.shared.getDeviceState();

  //   final String? osUserID = status?.userId;
  //   UpditeNot.not(osUserID.toString(), 'android_n_device_id', '',
  //       osUserID.toString(), 'android_m_device_id', '');
  //   OSNotificationPermission? test = status?.notificationPermissionStatus;

  //   print('ameenjawad ${osUserID}');
  //   // Get.defaultDialog(
  //   //     onCancel: () {},
  //   //     onConfirm: () {
  //   //       print('ameenjawad  ${osUserID}');

  //   //
  //   //       Get.back();
  //   //     });
}

  // void notfIos() async {
  //   final status = await OneSignal.shared.getDeviceState();

  //   final String? osUserID = status?.userId;
  //   UpditeNot.not(
  //     osUserID.toString(),
  //     'ios_n_device_id',
  //     '',
  //     osUserID.toString(),
  //     'ios_m_device_id',
  //     '',
  //   );
  //   OSNotificationPermission? test = status?.notificationPermissionStatus;

  //   print('ameenjawad ${osUserID}');
  //   // Get.defaultDialog(
  //   //     onCancel: () {},
  //   //     onConfirm: () {
  //   //       print('ameenjawad  ${osUserID}');

  //   //
  //   //       Get.back();
  //   //     });
  // }

  // UpditePosts(i) {
  //   // savebost.value = i;
  //   update();
  //   print(savebost.value);
  // }

