import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class GetMyUserDataCont extends GetxController {
  RxBool isloding = false.obs;
  RxString userid = ''.obs;
  RxList<GetUserDataModel> data = <GetUserDataModel>[].obs;
  String web = accounts[0]['sm0'];
  void onof() {
    isloding.value = !isloding.value;
  }

  @override
  void onInit() {
    getUserdata();

    super.onInit();
  }

  // print(Get.arguments['user_id']);

  void getUserdata() async {
    final prefs = await SharedPreferences.getInstance();

    final String? myuserid = prefs.getString('user_id');
    GetUserDataApi.getUserData(await myuserid.toString()).then((ameen) {
      data.value = ameen.toList();
    });

    update();
  }

  void updi() async {
    final prefs = await SharedPreferences.getInstance();

    final String? myuserid = prefs.getString('user_id');
    GetUserDataApi.getUserData(await myuserid.toString()).then((ameen) {
      data.value = ameen.toList();
    });

    update();
  }

  /////////////////////
  ///
  ///
  ///
}

// void GetPosts() async {
//   ApiPosts.Getposts('0').then((value) {
//     data = value.toList();
//   });
//   var list = await ApiPosts.Getposts('0');
//   lastId = list[list.length - 1].post_id;

//   update();
// }

class ControllerViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2500,
      ),
    );
  }
}
