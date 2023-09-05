class GetAllChatsModel {
  String user_id;
  String name;
  String avatar;
  String text;
  String time;
  String time_text;
  final count;
  String message_count;
  String username;
  String lastseen_status;
  final reaction;

  GetAllChatsModel({
    required this.reaction,
    required this.lastseen_status,
    required this.count,
    required this.message_count,
    required this.time_text,
    required this.time,
    required this.text,
    required this.user_id,
    required this.username,
    required this.name,
    required this.avatar,
  });

  factory GetAllChatsModel.fromJson(Map<String, dynamic> map) =>
      GetAllChatsModel(
        reaction: map['reaction'] == null ? '' : map['reaction'],
        message_count: map['message_count'] == null ? '' : map['message_count'],
        lastseen_status:
            map['lastseen_status'] == null ? '' : map['lastseen_status'],
        username: map['username'] == null ? '' : map['username'],
        count: map['last_message']['reaction'] == null
            ? ''
            : map['last_message']['reaction']['count'],
        time_text: map['last_message']['time_text'] == null
            ? ''
            : map['last_message']['time_text'],
        time: map['last_message']['time'] == null
            ? ''
            : map['last_message']['time'],
        text: map['last_message']['text'] == null
            ? ''
            : map['last_message']['text'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        name: map['name'] == null ? '' : map['name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
      );
}
