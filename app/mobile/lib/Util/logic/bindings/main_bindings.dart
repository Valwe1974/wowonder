import 'package:get/instance_manager.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';

class MainBininding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}


