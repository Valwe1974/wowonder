import 'dart:math';
import 'package:advstory/advstory.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/NewStorey/mock_story_data.dart';

class AdvStoryTrayCustomization extends StatefulWidget {
  const AdvStoryTrayCustomization({
    required this.isHorizontal,
    Key? key,
  }) : super(key: key);

  /// Story list direction
  final bool isHorizontal;

  @override
  State<AdvStoryTrayCustomization> createState() =>
      _AdvStoryTrayCustomizationState();
}

class _AdvStoryTrayCustomizationState extends State<AdvStoryTrayCustomization> {
  double _width = 85;
  double _height = 85;
  double _radius = 50;
  double _strokeWidth = 2;
  double _gapSize = 3;
  bool _showUserNames = true;

  final _defaultBorderColors = [
    const Color(0xaf405de6),
    const Color(0xaf5851db),
    const Color(0xaf833ab4),
    const Color(0xafc13584),
    const Color(0xafe1306c),
    const Color(0xaffd1d1d),
    const Color(0xaf405de6),
  ];
  late List<Color> _selectedColors = _defaultBorderColors;

  double _lerp = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isHorizontal ? _height + 60 : double.maxFinite,
      width: widget.isHorizontal ? double.maxFinite : _width + 60,
      child: Expanded(
        child: AdvStory(
          storyCount: userNames.length,
          storyBuilder: (index) async {
            return Story(
              contentCount: 3,
              contentBuilder: (contentIndex) => contentIndex % 2 == 0
                  ? ImageContent(url: imageUrls[contentIndex])
                  : VideoContent(url: videoUrls[contentIndex]),
              header: StoryHeader(
                url: profilePics[index],
                text: userNames[index],
              ),
              footer: const MessageBox(),
            );
          },
       
          trayBuilder: (index) {
            return AdvStoryTray(
              url: profilePics[index],
              size: Size(_width, _height),
              shape: BoxShape.rectangle,
              borderRadius: index % 2 == 0 ? _radius : _radius,
              borderGradientColors: _selectedColors,
              strokeWidth: _strokeWidth,
              gapSize: _gapSize,
              username: _showUserNames
                  ? Text(
                      userNames[index],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
                      ),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}

/// Creates a dumb textfield as a placeholder.
class MessageBox extends StatelessWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      margin: const EdgeInsets.only(bottom: 25),
      color: Colors.transparent,
      child: TextField(
        cursorRadius: const Radius.circular(20.0),
        decoration: InputDecoration(
          fillColor: Colors.white10,
          filled: true,
          suffixIcon: Icon(
            Icons.send_outlined,
            size: 20,
            color: Colors.grey.shade300,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Message',
          hintStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}
