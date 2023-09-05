import 'package:wowondertimelineflutterapp/main.dart';

class GetGroupDataModel {
  String group_title;
  String avatar;
  String category;
  int is_group_joined;
  String members_count;
  String post_count;
  final is_owner;
  String cover;
  String id;

  GetGroupDataModel({
    required this.cover,
    required this.is_owner,
    required this.post_count,
    required this.is_group_joined,
    required this.members_count,
    required this.group_title,
    required this.avatar,
    required this.id,
    required this.category,
  });

  factory GetGroupDataModel.fromJson(Map<String, dynamic> map) =>
      GetGroupDataModel(
        id: map['id'] == null ? '' : map['id'],
        cover: map['cover'] == null
            ? ''
            : map['cover'] ==
                    '${accounts[0]['sm0']}/upload/photos/d-cover.jpg%20'
                ? '${accounts[0]['sm0']}/upload/photos/d-cover.jpg'
                : map['cover'],
        is_owner: map['is_owner'] == null ? '' : map['is_owner'],
        post_count: map['post_count'] == null ? '' : map['post_count'],
        members_count: map['members_count'] == null ? '' : map['members_count'],
        is_group_joined:
            map['is_group_joined'] == null ? '' : map['is_group_joined'],
        category: map['category'] == null ? '' : map['category'],
        avatar: map['avatar'] == null
            ? ''
            : map['avatar'] ==
                    '${accounts[0]['sm0']}/upload/photos/d-group.jpg%20'
                ? '${accounts[0]['sm0']}/upload/photos/d-group.jpg'
                : map['avatar'],
        group_title: map['group_title'] == null ? '' : map['group_title'],
        ////
      );
}
