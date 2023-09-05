import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/Screens/Reaction/TextReaction.dart';

final reactions = [
  FeedReaction(
    header: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8,bottom: 4),
        child: Text(
          'Like'.tr,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
    ),
    id: 0,
    name: "Like",
    reaction: Image.asset(
      AnimatedImages.Like,
      width: 30,
      height: 30,
    ),
  ),
  FeedReaction(
    header: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8,bottom: 4),
        child: Text(
          'Love'.tr,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
    ),
    id: 2,
    name: "Love",
    reaction: Image.asset(
      AnimatedImages.Love,
      width: 30,
      height: 30,
    ),
  ),
  FeedReaction(
    header: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8,bottom: 4),
        child: Text(
          'haha'.tr,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
    ),
    id: 3,
    name: "haha".tr,
    reaction: Image.asset(
      AnimatedImages.Haha,
      width: 30,
      height: 30,
    ),
  ),
  FeedReaction(
    header: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8,bottom: 4),
        child: Text(
          'WoW'.tr,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
    ),
    id: 4,
    name: "WoW",
    reaction: Image.asset(
      AnimatedImages.Wow,
      width: 30,
      height: 30,
    ),
  ),
  FeedReaction(
    header: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8,bottom: 4),
        child: Text(
          'sad'.tr,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
    ),
    id: 5,
    name: "sad",
    reaction: Image.asset(
      AnimatedImages.Sad,
      width: 30,
      height: 30,
    ),
  ),
  FeedReaction(
    header: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        borderRadius: BorderRadius.circular(40),
      ),

      child: Padding(
        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8,bottom: 4),
        child: Text(
          'angry'.tr,
          style: TextStyle(color: Colors.white, fontSize: 8),
        ),
      ),
    ),
    id: 6,
    name: "angry",
    reaction: Image.asset(
      AnimatedImages.Angry,
      width: 30,
      height: 30,
    ),
  ),
];
