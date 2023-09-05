class FollowingModel {
  String user_id;
  String name;
  String avatar;
  String gender;
  FollowingModel(
      {required this.avatar,
      required this.gender,
      required this.name,
      required this.user_id
      ////details
      });

  factory FollowingModel.fromJson(Map<String, dynamic> map) => FollowingModel(
      gender: map['gender'] == null ? '' : map['gender'],
      user_id: map['user_id'] == null ? '' : map['user_id'],
      avatar: map['avatar'] == null ? '' : map['avatar'],
      name: map['name'] == null ? '' : map['name']);

  /////details
}
