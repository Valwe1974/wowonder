import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/TextReaction.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/reaction.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiReaction.dart';

import '../../String.dart';
import '../../ThemesWoWonder.dart';
import '../../Util/TextUtil.dart';

class ReactionBut extends StatefulWidget {
  ReactionBut({
    super.key,
    required this.post_id,
    required this.contt,
    required this.imReaction,
    required this.likeplus,
    required this.mines,
  });
  final likeplus;
  final mines;
  String post_id;
  int contt;
  final imReaction;
  @override
  State<ReactionBut> createState() => _ReactionButState();
}

final player = AudioPlayer(); // Create a player
void like(like) async {
  if (like == 1)
    final duration = await player.setAsset('assets/sounds/Pop_B.wav');
  if (like == 2)
    final duration = await player.setAsset('assets/sounds/Pop_E.wav');
  if (like == 3)
    final duration = await player.setAsset('assets/sounds/Pop_F.wav');
  await player.play();
  print(player.playing.toString());
}

@override
class _ReactionButState extends State<ReactionBut> {
  String likeText = 'like2';
  @override
  void initState() {
    react();
    super.initState();
  }

  void react() {
    if (widget.imReaction == '1') likeText = 'Like';
    if (widget.imReaction == '2') likeText = 'Love';
    if (widget.imReaction == '3') likeText = 'haha';
    if (widget.imReaction == '4') likeText == 'WoW';
    if (widget.imReaction == '5') likeText == 'sad';
    if (widget.imReaction == '6') likeText == 'angry';
    setState(() {});
  }

  void mainnn() {
    if (likeText == 'Like') widget.mines();

    if (likeText == 'Love') widget.mines();

    if (likeText == 'haha') widget.mines();

    if (likeText == 'WoW') widget.mines();

    if (likeText == 'sad') widget.mines();

    if (likeText == 'angry') widget.mines();
    widget.likeplus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlutterFeedReaction(
            suffix: Text(
              likeText == 'like2' ? 'Like'.tr : likeText.tr,
                style: SafeGoogleFont(
                    Fonts.font3,
                    fontSize: 15,color: Get.isDarkMode
                    ? Colors.white
                    : Colors.black,
                    fontWeight:
                    FontWeight.w600)
            ),
            reactions: reactions,
            dragSpace: 40,
            onReactionSelected: (val) {
              setState(() {
                like(3);
                likeText = val.name;
                if (likeText == 'Like')
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '1');

                if (likeText == 'Love')
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '2');

                if (likeText == 'haha')
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '3');

                if (likeText == 'WoW')
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '4');

                if (likeText == 'sad')
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '5');

                if (likeText == 'angry')
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '6');
              });
            },
            onPressed: () {
              like(1);
              setState(() {
                if (likeText == 'like2') {
                  ApiPostReaction.postReaction(widget.post_id, 'reaction', '1');
                  likeText = 'Like';
                  widget.likeplus();
                } else {
                  if (likeText == 'Like') {
                    widget.mines();
                    ApiPostReaction.postReaction(
                        widget.post_id, 'reaction', '0');
                    likeText = 'like2';
                  }
                  ;

                  if (likeText == 'Love') {
                    ApiPostReaction.postReaction(
                        widget.post_id, 'reaction', '0');
                    likeText = 'like2';
                    mainnn();
                  }
                  ;

                  if (likeText == 'haha') {
                    ApiPostReaction.postReaction(
                        widget.post_id, 'reaction', '0');
                    likeText = 'like2';
                    mainnn();
                  }
                  ;

                  if (likeText == 'WoW') {
                    ApiPostReaction.postReaction(
                        widget.post_id, 'reaction', '0');
                    likeText = 'like2';
                    widget.mines();
                  }
                  ;

                  if (likeText == 'sad') {
                    ApiPostReaction.postReaction(
                        widget.post_id, 'reaction', '0');
                    likeText = 'like2';
                    if (likeText == 'Like') widget.mines();
                  }
                  ;

                  if (likeText == 'angry') {
                    ApiPostReaction.postReaction(
                        widget.post_id, 'reaction', '0');
                    likeText = 'like2';
                    widget.mines();
                  }
                  ;
                }
              });
            },
            prefix: Row(
              children: [
                if (likeText == 'like2')
                  SvgPicture.asset(
                    Change_Color_Icons ? ColorSvg.LikeBtn :  SvgImages.LikeBtn,
                    color:Change_Color_Icons ? null : Get.isDarkMode
                        ? Colors.white
                        : Colors.black,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'Like')
                  Change_Color_Icons ?
                  SvgPicture.asset(
                    SvgImages.Like,

                    height: 20,
                    width: 20,
                  ):
                  Center(
                    child: Image.asset(
                      images.Like,
                      height: 20,
                      width: 20,
                    ),
                  ),
                if (likeText == 'Love')
                  Change_Color_Icons ?
                  SvgPicture.asset(
                    SvgImages.Love,
                    height: 20,
                    width: 20,
                  ):
                  Image.asset(
                    images.Love,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'HaHa')
                  Change_Color_Icons ?
                  SvgPicture.asset(
                    SvgImages.Haha,
                    height: 20,
                    width: 20,
                  ):
                  Image.asset(
                    images.Haha,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'WoW')
                  Change_Color_Icons ?
                  SvgPicture.asset(
                    SvgImages.Wow,
                    height: 20,
                    width: 20,
                  ):
                  Image.asset(
                    images.Wow,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'sad')
                  Change_Color_Icons ?
                  SvgPicture.asset(
                    SvgImages.Sad,
                    height: 20,
                    width: 20,
                  ):
                  Image.asset(
                    images.Sad,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'angry')
                  Change_Color_Icons ?
                  SvgPicture.asset(
                    SvgImages.Angry,
                    height: 20,
                    width: 20,
                  ):
                  Image.asset(
                    images.Angry,
                    height: 20,
                    width: 20,
                  ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
