import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/TextReaction.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/reaction.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPostReactionComments.dart';

class ReqctionComment extends StatefulWidget {
  ReqctionComment({
    super.key,
    required this.comments_id,
    required this.contt,
    required this.imReaction,
  });
  String comments_id;
  int contt;
  final imReaction;
  @override
  State<ReqctionComment> createState() => _ReqctionCommentState();
}

class _ReqctionCommentState extends State<ReqctionComment> {
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

  ReactionB(nupm) async {
    await ApiPostReactionComments.postReaction(
        'reaction_comment', widget.comments_id, nupm);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlutterFeedReaction(
            suffix: Text(
              likeText == 'like2' ? 'like'.tr : likeText.tr,
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
            ),
            reactions: reactions,
            dragSpace: 40,
            onReactionSelected: (val) {
              
              setState(() {
                likeText = val.name;
                if (likeText == 'Like') ReactionB('1');

                if (likeText == 'Love') ReactionB('2');

                if (likeText == 'haha') ReactionB('3');

                if (likeText == 'WoW') ReactionB('4');

                if (likeText == 'sad') ReactionB('5');

                if (likeText == 'angry') ReactionB('6');
              });
            },
            onPressed: () {
              setState(() {
                if (likeText == 'like2') {
                  ReactionB('1');
                  likeText = 'Like';
                  widget.contt++;
                } else {
                  if (likeText == 'Like') {
                    likeText = 'like2';
                    widget.contt--;
                    ReactionB('0');
                  }
                  ;

                  if (likeText == 'Love') {
                    ReactionB('0');
                    likeText = 'like2';
                    widget.contt--;
                  }
                  ;

                  if (likeText == 'haha') {
                    ReactionB('0');
                    likeText = 'like2';
                    widget.contt--;
                  }
                  ;

                  if (likeText == 'WoW') {
                    ReactionB('0');
                    likeText = 'like2';
                    widget.contt--;
                  }
                  ;

                  if (likeText == 'sad') {
                    ReactionB('0');
                    likeText = 'like2';
                    widget.contt--;
                  }
                  ;

                  if (likeText == 'angry') {
                    ReactionB('0');
                    likeText = 'like2';
                    widget.contt--;
                  }
                  ;
                }
              });
            },
            prefix: Row(
              children: [
                SizedBox(width: Get.width * 0.02,),
                if (likeText == 'like2')
                    SvgPicture.asset(
                      SvgImages.LikeBtn,
                      height: 20,
                      width: 20,
                      color: Colors.grey,
                    ),
                if (likeText == 'Like')
                  Center(
                    child: Image.asset(
                      images.Like,
                      height: 20,
                      width: 20,
                    ),
                  ),
                if (likeText == 'Love')
                  Image.asset(
                    images.Love,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'HaHa')
                  Image.asset(
                    images.Haha,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'WoW')
                  Image.asset(
                    images.Wow,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'sad')
                  Image.asset(
                    images.Sad,
                    height: 20,
                    width: 20,
                  ),
                if (likeText == 'angry')
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
          SizedBox(
            width: Get.width * 0.01,
          ),
          Text(widget.contt.toString()),
        ],
      ),
    );
  }
}
