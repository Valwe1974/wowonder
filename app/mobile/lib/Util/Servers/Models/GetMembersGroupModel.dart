class GetMembersGroupModel {
  String name;
  String avatar;
  String member_id;
  String confirm_followers;
  String user_id;
  int admin;
  int is_following;
  String cover;
  GetMembersGroupModel({
    required this.admin,
    required this.name,
    required this.cover,
    required this.member_id,
    required this.is_following,
    required this.confirm_followers,
    required this.avatar,
    required this.user_id,
  });

  factory GetMembersGroupModel.fromJson(Map<String, dynamic> map) =>
      GetMembersGroupModel(
        ///
        ///
        is_following: map['is_following'] == null ? '' : map['is_following'],
        confirm_followers:
            map['confirm_followers'] == null ? '' : map["confirm_followers"],
        cover: map['cover'] == null ? '' : map['cover'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        member_id: map['member_id'] == null ? '' : map['member_id'],
        admin: map['is_admin'] == null ? '' : map['is_admin'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        name: map['name'] == null ? '' : map['name'],

        ///
      );
}
