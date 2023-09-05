class NotificationsModels {
  String type;
  String name;
  String avatar;
  String type_text;
  String time_text_string;
  String time_text;
  String user_id;
  String cover;
  String post_id;

  NotificationsModels(
      {required this.time_text_string,
      required this.user_id,
      required this.time_text,
      required this.type,
      required this.post_id,
      required this.name,
      required this.cover,
      required this.avatar,
      required this.type_text});

  factory NotificationsModels.fromJson(Map<String, dynamic> map) =>
      NotificationsModels(
          post_id: map['post_id'] == null ? '' : map['post_id'],
          cover: map['notifier'] == null ? '' : map['notifier']['cover'],
          user_id: map['notifier'] == null ? '' : map['notifier']['user_id'],
          time_text: map['time_text'] == null ? '' : map['time_text'],
          time_text_string:
              map['time_text_string'] == null ? '' : map['time_text_string'],
          type_text: map['type_text'] == '' ? map['text'] : map['type_text'],
          avatar: map['notifier'] == null
              ? ''
              : map['notifier']['avatar'] == null
                  ? ''
                  : map['notifier']['avatar'],
          type: map['type'] == null ? '' : map['type'],
          name: map['notifier'] == null
              ? ''
              : map['notifier']['name'] == null
                  ? ''
                  : map['notifier']['name']);
}
