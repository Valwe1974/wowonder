import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/HomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/MoreScreen/MoreScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/PostVideoRels.dart';
import 'package:wowondertimelineflutterapp/Screens/Search/SearchScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/NotificationsApi.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';

class DashBoardController extends GetxController {
  var tabIndex = 0;
  var contFrind = '0';

  var getToNamedList = [
    HomeScreen(),
    SearchScreen(),
    Container(),
    MoreScreen(),
    VideoScreen(),
  ];

  @override
  void onInit() {
    GetReqFrind();
    SocketNew.socket.on(
        'new_request',
        (data) => {
              GetReqFrind(),
              print('object'),
            });
    ameen();
    super.onInit();
  }

  void GetReqFrind() async {
    var list = await FriendrequestsCount.Notifications();
    contFrind = list;
    update();
  }

  void changePageTo(int index) {
    tabIndex = index;
    update();
  }

  void ameen() async {
    // HttpOverrides.global = MyHttpOverrides();
    // WidgetsFlutterBinding.ensureInitialized();
    // await TestSettApi.testSerintgsApi();

    // // await TestSettApi.testSerintgsApi();
    // // ByteData data = await PlatformAssetBundle().load('assets/ca/talkeyi.com.pem');
    // // SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
    // // final testtt =
    // //     await DataWebSite[DataWebSite.length - 1]['config']['post_colors'];
    // // List jojo = await [testtt];

    // final prefs = await SharedPreferences.getInstance();

    // tokens = prefs.getString('token');
    // await GetStorage.init();
    // // await GetSiteSettingsApi.Getposts();

    // // await printIps();
    // StreamSubscription? _sub;
    // print(_sub);
    // _sub = linkStream.listen((String? link) {
    //   if (link != null) {
    //     Get.offAllNamed(AppRoutes.navbar);
    //     var uri = Uri.parse(link);

    //     // var ttt = uri
    //     //     .toString()
    //     //     .replaceAll(RegExp('customscheme://talkeyi.com//'), '');
    //     // var ttt2 = ttt.replaceAll(RegExp('_.html'), '');

    //     print(link);
    //   }
    // });
    // _sub = linkStream.listen((String? link) {
    //   // Parse the link and warn the user, if it is not correct
    // }, onError: (err) {
    //   // Handle exception by warning the user their action did not succeed
    // });
  }
}
