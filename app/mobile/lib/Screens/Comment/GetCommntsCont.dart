import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetCommetsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/CommentsModel.dart';

class GetCommntsCont extends GetxController {
  late RxString fetch_comments;
  RxList<GetCommentsModel> data = <GetCommentsModel>[].obs;
  @override
  void onInit() {
    getUserdata();

    // Timer.periodic(Duration(seconds: 1), (timer) {
    // getUserdata();
    // });

    super.onInit();
  }

  // print(Get.arguments['user_id']);
  void getUserdata() async {
    GetCommentsApi.FetchComments(
            Get.arguments['post_id'], fetch_comments.toString(), '0')
        .then((ameen) {
      data.value = ameen.toList();
    });
  }
}
