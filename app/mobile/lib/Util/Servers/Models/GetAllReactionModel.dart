class GetAllReactionModel {
  String name;
  String avatar;

  GetAllReactionModel({
    required this.avatar,
    required this.name,
  });

  factory GetAllReactionModel.fromJson(Map<String, dynamic> map) =>
      GetAllReactionModel(
        name: map['name'] == null ? '' : map['name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
      );
}
