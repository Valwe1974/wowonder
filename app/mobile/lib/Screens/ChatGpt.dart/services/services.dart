import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGpt.dart/widgets/drop_down.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGpt.dart/widgets/text_widget.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: scaffoldBackgroundColorChatGpt,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  child: TextWidget(
                    label: "Chosen Model:",
                    fontSize: 16,
                  ),
                ),
                Flexible(flex: 2, child: ModelsDrowDownWidget()),
              ],
            ),
          );
        });
  }
}
