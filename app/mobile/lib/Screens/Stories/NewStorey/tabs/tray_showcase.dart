

import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/NewStorey/examples/trays/adv_story_tray_customization.dart';


/// This is not a usage example.
///
/// Look at lib/examples folder to see how to use this package.
class TrayShowcase extends StatefulWidget {
  const TrayShowcase({Key? key}) : super(key: key);

  @override
  State<TrayShowcase> createState() => _TrayShowcaseState();
}

class _TrayShowcaseState extends State<TrayShowcase> {
  bool _isHorizontal = true;

  Widget _title(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('AdvStory Demo'),
        backgroundColor: Colors.deepOrangeAccent.withOpacity(.8),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Flex(
          direction: _isHorizontal ? Axis.vertical : Axis.horizontal,
          children: [
            AdvStoryTrayCustomization(isHorizontal: _isHorizontal),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent.withOpacity(.8),
        onPressed: () {
          setState(() {
            _isHorizontal = !_isHorizontal;
          });
        },
        child: const Icon(Icons.rotate_90_degrees_cw_outlined),
      ),
    );
  }
}
