import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/controllers/thems_controllers.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';

class DarkModeWidget extends StatelessWidget {
  DarkModeWidget({Key? key}) : super(key: key);

  final controller = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildIconWidget(),
          Switch(
            activeTrackColor: Get.isDarkMode ? WhiteBack : mainColor,
            activeColor: Get.isDarkMode ? WhiteBack : mainColor,
            value: controller.swithchValue.value,
            onChanged: (value) {
              ThemeController().changesTheme();

              controller.swithchValue.value = value;
            },
          ),
        ],
      ),
    );
  }

  Widget buildIconWidget() {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 5, 41, 70),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                controller.swithchValue.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.01,
          ),
          Text(
            controller.swithchValue.value ? 'Day Mode' : 'Night Mode',
            style: SafeGoogleFont(Fonts.font1,
                fontSize: 16,
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
