import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiHashtagPosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/SearchApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/SearchModel.dart';

class ContSearchHashTag extends GetxController {
  final TextEditingController SerchName = TextEditingController();
  RxInt initialIndex = 0.obs;
  RxBool isLoding = false.obs;
  RxList<PostModel> data = <PostModel>[].obs;
  RxInt contSer = 20.obs;
  String? lastId;
  RxString text = ''.obs;
  RxBool down = false.obs;
  bool post = false;
  RxBool noAcoent = false.obs;
  ScrollController _scrollController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxBool colose = false.obs;
  RxBool catog = true.obs;
  RxBool catog1 = false.obs;
  RxBool catog2 = false.obs;
  RxBool catog4 = false.obs;
  void GerSerch() async {
    isLoding.value = true;
    ApiHashtagPosts.Getposts(SerchName.text).then((val) {
      data.value = val.toList();
      data.value.isEmpty
          ? ''
          : lastId = data.value[data.value.length - 1].user_id;
      down.value = true;
    });

    data.length - 1 == -1 ? '' : lastId = data[data.length - 1].user_id;
    if (data.length - 1 == -1) {
      noAcoent.value = false;

      isLoding.value = false;
      update();
    } else {
      noAcoent.value = true;
      isLoding.value = false;
    }
  }

  scrollToCursor(String textFieldValue) {
    final isLonger = textFieldValue.length > text.value.length;

    GerSerch();
    update();

    if (_scrollController.hasClients)
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void deleteData() {
    data.clear();
    SerchName.clear();
  }

  void moreFrind() async {
    var list = await ApiHashtagPosts.Getposts(SerchName.text);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].user_id;
    if (list.length - 1 == -1) {
      post = true;
    } else {
      post = false;
    }
    data.addAll(list);
    refreshController.loadComplete();
    update();
  }
}
