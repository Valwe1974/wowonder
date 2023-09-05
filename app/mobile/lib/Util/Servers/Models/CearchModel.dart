class CearchModel {
  String user_id;
  String avatar;
  String name;

  CearchModel({
    required this.user_id,
    required this.avatar,
    required this.name,
  });

  factory CearchModel.fromJson(Map<String, dynamic> map) => CearchModel(
      user_id: map['user_id'] == null ? "" : map['user_id'],
      avatar: map['avatar'] == null ? '' : map['avatar'],
      name: map['name'] == null ? '' : map['name']);
}
