// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:wowondertimelineflutterapp/main.dart';

// class PostModel {
//   String postText;
//   String name;
//   String color_id;
//   String postFile;
//   final product;
//   String postType;
//   String product_id;
//   String avatar;
//   String postMap;
//   String user_id;
//   String post_time;
//   String lastseen_status;
//   String verified;
//   String postLink;
//   bool admin;
//   String postRecord;
//   int reaction;
//   bool is_group_post;
//   String post_share;
//   String postSticker;
//   final photoMulti2;
//   final shared_info;
//   final photo_album;
//   String urlsss;
//   String post_comments;

//   bool is_reacted;
//   bool is_post_reported;
//   String post_id;
//   String comments_status;

//   int reaction1;

//   int reaction2;

//   int reaction3;

//   int reaction4;

//   int reaction5;
//   bool is_post_saved;
//   int reaction6;
//   String group_name;
//   String type;
//   String p240;
//   String p360;
//   String p480;
//   String p720;
//   String p1080;
//   String p2048;
//   String p4096;
//   String postFeeling;
//   String postYoutube;
//   String page_id;
//   String group_id;
//   String group_title;
//   String avatargroupe;
//   String cover;
//   String postLinkTitle;
//   String postLinkContent;
//   final options;
//   final event;
//   String postPhoto;
//   String postText_API;
//   String adminPanel;
//   String postFileThumb;

//   ///معلومات المشاركة
//   // String nameshared;
//   // String avatarshared;

//   PostModel({
//     required this.urlsss,
//     required this.event,
//     required this.product,
//     required this.adminPanel,
//     required this.postFileThumb,
//     required this.postMap,
//     required this.postType,
//     required this.postText_API,
//     required this.shared_info,
//     required this.postPhoto,
//     required this.color_id,
//     required this.postSticker,
//     required this.postRecord,
//     required this.options,

//     // required this.nameshared,
//     required this.postLink,
//     // required this.avatarshared,
//     required this.avatargroupe,
//     required this.group_id,
//     required this.comments_status,
//     required this.cover,
//     required this.group_title,
//     required this.page_id,
//     required this.postLinkContent,
//     required this.postLinkTitle,
//     required this.lastseen_status,
//     required this.is_post_saved,
//     required this.is_group_post,
//     required this.group_name,
//     required this.admin,
//     required this.user_id,
//     required this.photoMulti2,
//     required this.postFeeling,
//     required this.type,
//     required this.postYoutube,
//     required this.reaction1,
//     required this.reaction2,
//     required this.reaction3,
//     required this.is_post_reported,
//     required this.reaction4,
//     required this.reaction5,
//     required this.reaction6,
//     required this.avatar,
//     required this.verified,
//     required this.post_id,
//     required this.post_share,
//     required this.is_reacted,
//     required this.post_comments,
//     required this.post_time,
//     required this.reaction,
//     required this.postFile,
//     required this.name,
//     required this.postText,
//     required this.p2048,
//     required this.p240,
//     required this.p360,
//     required this.p4096,
//     required this.p480,
//     required this.p720,
//     required this.product_id,
//     required this.p1080,
//     required this.photo_album,
//   });

//   factory PostModel.fromJson(Map<String, dynamic> map) => PostModel(
//         urlsss: map['url'] == null ? '' : map['url'],
//         postType: map['postType'] == null ? '' : map['postType'],
//         event: map['event'] == null ? '' : map['event'],
//         postFileThumb: map['postFileThumb'] == null ? '' : map['postFileThumb'],
//         product: map['product'] == null ? '' : map['product'],
//         photo_album: map['photo_album'] == null ? '' : map['photo_album'],
//         product_id: map['product_id'] == null ? '' : map['product_id'],
//         shared_info: map['shared_info'] == null ? '' : map['shared_info'],
//         adminPanel: map['publisher'] == null
//             ? ''
//             : map['publisher']['admin'] == null
//                 ? ''
//                 : map['publisher']['admin'],
//         postMap: map['postMap'] == null ? '' : map['postMap'],
//         postText_API: map['postText'] == null ? '' : map['postText'],
//         postPhoto: map['postPhoto'] == null ? '' : map['postPhoto'],
//         color_id: map['color_id'] == null ? '' : map['color_id'],
//         postSticker: map['postSticker'] == null ? '' : map['postSticker'],
//         postRecord: map['postRecord'] == null ? '' : map['postRecord'],

//         comments_status:
//             map['comments_status'] == null ? '' : map['comments_status'],
//         postLinkContent:
//             map['postLinkContent'] == null ? '' : map['postLinkContent'],
//         postLinkTitle: map['postLinkTitle'] == null ? '' : map['postLinkTitle'],
//         postLink: map['postLink'] == null ? '' : map['postLink'],
//         avatargroupe: map['group_recipient'] == null
//             ? ''
//             : map['group_recipient']['avatar'] ==
//                     '${accounts[0]['sm0']}/upload/photos/d-group.jpg '
//                 ? '${accounts[0]['sm0']}/upload/photos/d-group.jpg'
//                 : map['group_recipient']['avatar'],
//         group_title: map['group_recipient'] == null
//             ? ''
//             : map['group_recipient']['group_title'],
//         page_id: map['page_id'] == null
//             ? ''
//             : map['page_id'] == null
//                 ? ''
//                 : map['page_id'],
//         group_id: map['group_id'] == null
//             ? ''
//             : map['group_id'] == '0'
//                 ? ''
//                 : map['group_id'],
//         is_post_reported:
//             map['is_post_reported'] == null ? false : map['is_post_reported'],
//         is_post_saved:
//             map['is_post_saved'] == null ? false : map['is_post_saved'],
//         photoMulti2: map['photo_multi'] == null ? '' : map['photo_multi'],

//         postFeeling: map['postFeeling'] == null ? '' : map['postFeeling'],
//         postYoutube: map['postYoutube'] == null ? '' : map['postYoutube'],
//         admin: map['admin'] == null ? false : map['admin'],
//         verified: map['publisher'] == null
//             ? ''
//             : map['publisher']['verified'] == null
//                 ? ''
//                 : map['publisher']['verified'],
//         post_id: map['post_id'] == null ? '' : map['post_id'],
//         is_reacted:
//             map['is_reacted'] == null ? false : map['reaction']['is_reacted'],
//         post_share: map['post_share'] == null ? '' : map['post_share'],
//         post_comments: map['post_comments'] == null ? '' : map['post_comments'],
//         reaction: map['reaction'] == null
//             ? 0
//             : map['reaction']['count'] == null
//                 ? '0'
//                 : map['reaction']['count'],
//         post_time: map['post_time'] == null ? '' : map['post_time'],
//         postFile: map['postFile'] == null ? '' : map['postFile'],
//         avatar: map['publisher'] == null
//             ? ''
//             : map['publisher']['avatar'] == null
//                 ? ''
//                 : map['publisher']['avatar'],
//         cover: map['publisher'] == null
//             ? ''
//             : map['publisher']['cover'] == null
//                 ? ''
//                 : map['publisher']['cover'],
//         postText: map['Orginaltext'] == null ? '' : map['Orginaltext'],
//         name: map['publisher'] == null ? '' : map['publisher']['name'],
//         ////////Reation
//         ////58769
//         ///96b8a054f6d6c370f8f521026abfbadaaf037d516d7c7e5281c04576bd0a361c2ac6b5b6916661119873eaad153c6c960616c89e54fe155a
//         reaction1: map['reaction'] == null
//             ? 0
//             : map['reaction']['1'] == null
//                 ? 0
//                 : map['reaction']['1'],
//         reaction2: map['reaction'] == null
//             ? 0
//             : map['reaction']['2'] == null
//                 ? 0
//                 : map['reaction']['2'],
//         reaction3: map['reaction'] == null
//             ? 0
//             : map['reaction']['3'] == null
//                 ? 0
//                 : map['reaction']['3'],
//         reaction4: map['reaction'] == null
//             ? 0
//             : map['reaction']['4'] == null
//                 ? 0
//                 : map['reaction']['4'],
//         reaction5: map['reaction'] == null
//             ? 0
//             : map['reaction']['5'] == null
//                 ? 0
//                 : map['reaction']['5'],
//         reaction6: map['reaction'] == null
//             ? 0
//             : map['reaction']['6'] == null
//                 ? 0
//                 : map['reaction']['6'],
//         user_id: map['user_id'] == null ? '' : map['user_id'],
//         /////رقم ريأشكن
//         ///

//         type: map['reaction'] == null
//             ? ''
//             : map['reaction']['type'] == null
//                 ? ''
//                 : map['reaction']['type'],

//         ////ffmpeg
//         p2048: map['2048p'] == null ? '' : map['2048p'],
//         p240: map['240p'] == null ? '' : map['240p'],
//         p360: map['360p'] == null ? '' : map['360p'],
//         p4096: map['4096p'] == null ? '' : map['4096p'],
//         p480: map['480p'] == null ? '' : map['480p'],
//         p720: map['720p'] == null ? '' : map['720p'],
//         p1080: map['1080p'] == null ? '' : map['1080p'],

//         ////image alb
//         ///

//         /////////group
//         ///
//         is_group_post:
//             map['is_group_post'] == null ? false : map['is_group_post'],
//         group_name: map['group_recipient'] == null
//             ? ''
//             : map['group_recipient'] == null
//                 ? ''
//                 : map['group_recipient']['group_name'],
//         ////onlineAndOfline
//         lastseen_status: map['publisher'] == null
//             ? ''
//             : map['publisher']['lastseen_status'] == null
//                 ? ''
//                 : map['publisher']['lastseen_status'],

//         ///sherPostsStutes معلومات المشاركة
//         // nameshared: map['shared_info'] == null
//         //     ? ''
//         //     : map['shared_info'] == null
//         //         ? ''
//         //         : map['shared_info']['publisher']['name'],
//         // avatarshared: map['shared_info'] == null
//         //     ? ''
//         //     : map['shared_info']['publisher']['avatar'],

//         ///polls
//         ///
//         options: map['options'] == [] ? null : map['options'],
//       );
// }

// //////////////////////////////
// ///
// ///
// ///

// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromMap(jsonString);

import 'package:wowondertimelineflutterapp/main.dart';

class PostModel {
  String postText;
  String stream_name;
  String name;
  String color_id;
  String postFile;
  final product;
  String blur;
  String postType;
  String product_id;
  String avatar;
  String postMap;
  String user_id;
  String post_time;
  String lastseen_status;
  String verified;
  String postLink;
  bool admin;
  String postRecord;
  int reaction;
  bool is_group_post;
  String post_share;
  String postSticker;
  final photoMulti2;
  final shared_info;
  final photo_album;
  String urlsss;
  String post_comments;
  String headline;
  final user_dataAds;
  String nameAds;
  String ad_media;
  String biddingAds;
  String descriptionAds;
  bool is_reacted;
  bool is_post_reported;
  String post_id;
  String comments_status;
  String pro_type;

  int reaction1;

  int reaction2;

  int reaction3;

  int reaction4;

  int reaction5;
  bool is_post_saved;
  int reaction6;
  String group_name;
  String type;
  String p240;
  String p360;
  String p480;
  String p720;
  String p1080;
  String p2048;
  String p4096;
  String postFeeling;
  String postYoutube;
  String page_id;
  String group_id;
  String group_title;
  String avatargroupe;
  String cover;
  String postLinkTitle;
  String postLinkContent;
  final options;
  final event;
  String postPhoto;
  String postText_API;
  String adminPanel;
  String postFileThumb;
  String is_pro;

  ///معلومات المشاركة
  // String nameshared;
  // String avatarshared;
  // final user_dataAds;
  // String nameAds;
  // String ad_media;
  // String biddingAds;
  // String descriptionAds;
  PostModel({
    required this.user_dataAds,
    required this.descriptionAds,
    required this.blur,
    required this.nameAds,
    required this.biddingAds,
    required this.ad_media,
    required this.pro_type,
    required this.urlsss,
    required this.event,
    required this.is_pro,
    required this.product,
    required this.adminPanel,
    required this.postFileThumb,
    required this.postMap,
    required this.postType,
    required this.postText_API,
    required this.shared_info,
    required this.postPhoto,
    required this.color_id,
    required this.postSticker,
    required this.postRecord,
    required this.options,

    // required this.nameshared,
    required this.postLink,
    // required this.avatarshared,
    required this.avatargroupe,
    required this.group_id,
    required this.comments_status,
    required this.cover,
    required this.group_title,
    required this.page_id,
    required this.postLinkContent,
    required this.postLinkTitle,
    required this.lastseen_status,
    required this.is_post_saved,
    required this.is_group_post,
    required this.group_name,
    required this.admin,
    required this.user_id,
    required this.photoMulti2,
    required this.postFeeling,
    required this.type,
    required this.postYoutube,
    required this.reaction1,
    required this.reaction2,
    required this.reaction3,
    required this.is_post_reported,
    required this.reaction4,
    required this.reaction5,
    required this.reaction6,
    required this.avatar,
    required this.verified,
    required this.post_id,
    required this.post_share,
    required this.is_reacted,
    required this.post_comments,
    required this.headline,
    required this.post_time,
    required this.reaction,
    required this.postFile,
    required this.name,
    required this.postText,
    required this.p2048,
    required this.p240,
    required this.p360,
    required this.p4096,
    required this.p480,
    required this.p720,
    required this.product_id,
    required this.p1080,
    required this.photo_album,
    required this.stream_name,
  });

  factory PostModel.fromJson(Map<String, dynamic> map) => PostModel(
        blur: map['blur'] == null ? '' : map['blur'],
        stream_name: map['stream_name'] == null ? '' : map['stream_name'],
        headline: map['headline'] == null ? '' : map['headline'],
        urlsss: map['url'] == null ? '' : map['url'],
        postType: map['postType'] == null ? '' : map['postType'],
        event: map['event'] == null ? '' : map['event'],
        postFileThumb: map['postFileThumb'] == null ? '' : map['postFileThumb'],
        product: map['product'] == null ? '' : map['product'],
        photo_album: map['photo_album'] == null ? '' : map['photo_album'],
        product_id: map['product_id'] == null ? '' : map['product_id'],
        shared_info: map['shared_info'] == null ? '' : map['shared_info'],
        adminPanel: map['publisher'] == null
            ? ''
            : map['publisher']['admin'] == null
                ? ''
                : map['publisher']['admin'],
        postMap: map['postMap'] == null ? '' : map['postMap'],
        postText_API: map['postText'] == null ? '' : map['postText'],
        postPhoto: map['postPhoto'] == null ? '' : map['postPhoto'],
        color_id: map['color_id'] == null ? '' : map['color_id'],
        postSticker: map['postSticker'] == null ? '' : map['postSticker'],
        postRecord: map['postRecord'] == null ? '' : map['postRecord'],

        comments_status:
            map['comments_status'] == null ? '' : map['comments_status'],
        postLinkContent:
            map['postLinkContent'] == null ? '' : map['postLinkContent'],
        postLinkTitle: map['postLinkTitle'] == null ? '' : map['postLinkTitle'],
        postLink: map['postLink'] == null ? '' : map['postLink'],
        avatargroupe: map['group_recipient'] == null
            ? ''
            : map['group_recipient']['avatar'] ==
                    '${accounts[0]['sm0']}/upload/photos/d-group.jpg '
                ? '${accounts[0]['sm0']}/upload/photos/d-group.jpg'
                : map['group_recipient']['avatar'],
        group_title: map['group_recipient'] == null
            ? ''
            : map['group_recipient']['group_title'],
        page_id: map['page_id'] == null
            ? ''
            : map['page_id'] == '0'
                ? ''
                : map['page_id'],
        group_id: map['group_id'] == null
            ? ''
            : map['group_id'] == '0'
                ? ''
                : map['group_id'],
        is_post_reported:
            map['is_post_reported'] == null ? false : map['is_post_reported'],
        is_post_saved:
            map['is_post_saved'] == null ? false : map['is_post_saved'],
        photoMulti2: map['photo_multi'] == null ? '' : map['photo_multi'],

        postFeeling: map['postFeeling'] == null ? '' : map['postFeeling'],
        postYoutube: map['postYoutube'] == null ? '' : map['postYoutube'],
        admin: map['admin'] == null ? false : map['admin'],
        verified: map['publisher'] == null
            ? ''
            : map['publisher']['verified'] == null
                ? ''
                : map['publisher']['verified'],
        post_id: map['post_id'] == null ? '' : map['post_id'],
        is_reacted: map['reaction'] == null
            ? false
            : map['reaction']['is_reacted'] == null
                ? ''
                : map['reaction']['is_reacted'],
        post_share: map['post_share'] == null ? '' : map['post_share'],
        post_comments: map['post_comments'] == null ? '' : map['post_comments'],
        reaction: map['reaction'] == null
            ? 0
            : map['reaction']['count'] == null
                ? '0'
                : map['reaction']['count'],
        post_time: map['post_time'] == null ? '' : map['post_time'],
        postFile: map['postFile'] == null ? '' : map['postFile'],
        avatar: map['publisher'] == null
            ? ''
            : map['publisher']['avatar'] == null
                ? ''
                : map['publisher']['avatar'],
        cover: map['publisher'] == null
            ? ''
            : map['publisher']['cover'] == null
                ? ''
                : map['publisher']['cover'],
        postText: map['Orginaltext'] == null ? '' : map['Orginaltext'],
        name: map['publisher'] == null ? '' : map['publisher']['name'],
        ////////Reation
        ////58769
        ///96b8a054f6d6c370f8f521026abfbadaaf037d516d7c7e5281c04576bd0a361c2ac6b5b6916661119873eaad153c6c960616c89e54fe155a
        reaction1: map['reaction'] == null
            ? 0
            : map['reaction']['1'] == null
                ? 0
                : map['reaction']['1'],
        reaction2: map['reaction'] == null
            ? 0
            : map['reaction']['2'] == null
                ? 0
                : map['reaction']['2'],
        reaction3: map['reaction'] == null
            ? 0
            : map['reaction']['3'] == null
                ? 0
                : map['reaction']['3'],
        reaction4: map['reaction'] == null
            ? 0
            : map['reaction']['4'] == null
                ? 0
                : map['reaction']['4'],
        reaction5: map['reaction'] == null
            ? 0
            : map['reaction']['5'] == null
                ? 0
                : map['reaction']['5'],
        reaction6: map['reaction'] == null
            ? 0
            : map['reaction']['6'] == null
                ? 0
                : map['reaction']['6'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        /////رقم ريأشكن
        ///

        type: map['reaction'] == null
            ? ''
            : map['reaction']['type'] == null
                ? ''
                : map['reaction']['type'],

        ////ffmpeg
        p2048: map['2048p'] == null ? '' : map['2048p'],
        p240: map['240p'] == null ? '' : map['240p'],
        p360: map['360p'] == null ? '' : map['360p'],
        p4096: map['4096p'] == null ? '' : map['4096p'],
        p480: map['480p'] == null ? '' : map['480p'],
        p720: map['720p'] == null ? '' : map['720p'],
        p1080: map['1080p'] == null ? '' : map['1080p'],

        ////image alb
        ///

        /////////group
        ///
        is_group_post:
            map['is_group_post'] == null ? false : map['is_group_post'],
        group_name: map['group_recipient'] == null
            ? ''
            : map['group_recipient']['group_name'],
        ////onlineAndOfline
        lastseen_status: map['publisher'] == null
            ? ''
            : map['publisher']['lastseen_status'] == null
                ? ''
                : map['publisher']['lastseen_status'],

        ///sherPostsStutes معلومات المشاركة
        // nameshared: map['shared_info'] == null
        //     ? ''
        //     : map['shared_info'] == null
        //         ? ''
        //         : map['shared_info']['publisher']['name'],
        // avatarshared: map['shared_info'] == null
        //     ? ''
        //     : map['shared_info']['publisher']['avatar'],

        ///polls
        ///
        options: map['options'] == [] ? null : map['options'],
        ad_media: map['ad_media'] == null ? '' : map['ad_media'],
        biddingAds: map['bidding'] == null ? '' : map['bidding'],
        descriptionAds: map['description'] == null ? '' : map['description'],
        nameAds: map['name'] == null ? '' : map['name'],
        user_dataAds: map['user_data'] == null ? '' : map['user_data'],
        is_pro: map['publisher'] == null
            ? ''
            : map['publisher']['is_pro'] == null
                ? ''
                : map['publisher']['is_pro'],

        pro_type: map['publisher'] == null
            ? ''
            : map['publisher']['pro_type'] == null
                ? ''
                : map['publisher']['pro_type'],
      );
}

//////////////////////////////
///
///
///


// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

