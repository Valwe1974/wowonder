class GetAllFrindsModel {
  String user_id;
  String name;
  String avatar;
  final friends_count;
  GetAllFrindsModel({
    required this.friends_count,
    required this.user_id,
    required this.name,
    required this.avatar,
  });

  factory GetAllFrindsModel.fromJson(Map<String, dynamic> map) =>
      GetAllFrindsModel(
        friends_count: map['details']['mutual_friends_count'] == null
            ? ''
            : map['details']['mutual_friends_count'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        name: map['name'] == null ? '' : map['name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
      );
}
