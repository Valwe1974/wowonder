class FriendRequstsModel {
  String avatar;
  String cover;
  String user_id;
  String name;

  FriendRequstsModel({
    required this.user_id,
    required this.avatar,
    required this.name,
    required this.cover,
  });

  factory FriendRequstsModel.fromJson(Map<String, dynamic> map) =>
      FriendRequstsModel(
        cover: map['cover'] == null ? '' : map['cover'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        name: map['name'] == null ? '' : map['name'],
        user_id: map['user_id'] == null ? '' : map['user_id'],

        ////
      );
}
