class GetNameGroupsChatModel {
  String group_id;
  String group_name;
  String avatar;
  final user_data;
  final last_message;
  GetNameGroupsChatModel({
    required this.group_id,
    required this.group_name,
    required this.avatar,
    required this.user_data,
    required this.last_message,
  });

  factory GetNameGroupsChatModel.fromJson(Map<String, dynamic> map) =>
      GetNameGroupsChatModel(
        last_message: map['last_message'] == null ? '' : map['last_message'],
        group_id: map['group_id'] == null ? '' : map['group_id'],
        group_name: map['group_name'] == null ? '' : map['group_name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        user_data: map['user_data'] == null ? '' : map['user_data'],
        ////
      );
}
