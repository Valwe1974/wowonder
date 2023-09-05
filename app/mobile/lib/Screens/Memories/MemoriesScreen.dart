import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        AppBarTrueOrFalse: true,
        title: 'Memories'.tr,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: NoChatScreen(
                startChat: false,
                textData: 'There are no memories',
              ),
            )
          ],
        ),
        centerTitle: false,
        elevation: 0,

        loding: false);
  }
}
