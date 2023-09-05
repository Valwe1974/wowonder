
class SearchModel {
  String user_id;
  String name;
  String avatar;
  final is_following;
  final confirm_followers;
  String username;
  String verified;

  String cover;

  SearchModel({
    required this.cover,
    required this.verified,
    required this.name,
    required this.confirm_followers,
    required this.user_id,
    required this.username,
    required this.avatar,
    required this.is_following,
  });

  factory SearchModel.fromJson(Map<String, dynamic> map) => SearchModel(
        cover: map['cover'] == null ? '' : map['cover'],
        verified: map['verified'] == null ? '' : map['verified'],
        username: map['username'] == null ? '' : map['username'],
        confirm_followers:
            map['confirm_followers'] == null ? '' : map['confirm_followers'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        name: map['name'] == null ? '' : map['name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        is_following: map['is_following'] == null ? '' : map['is_following'],
      );
}
