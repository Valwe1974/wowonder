class GetAllMessageGroupsModel {
  String text;
  String id;
  String avatar;
  String position;
  String time_text;
  String user_id;
  String media;
  String stickers;
  String seen;
  final replyText;
  final reaction;
  String reply_id;
  GetAllMessageGroupsModel({
    required this.seen,
    required this.stickers,
    required this.replyText,
    required this.reply_id,
    required this.text,
    required this.reaction,
    required this.user_id,
    required this.media,
    required this.time_text,
    required this.id,
    required this.avatar,
    required this.position,
  });

  factory GetAllMessageGroupsModel.fromJson(Map<String, dynamic> map) =>
      GetAllMessageGroupsModel(
        reaction: map['reaction'] == null ? '' : map['reaction'],
        seen: map['seen'] == null ? '' : map['seen'],
        reply_id: map['reply_id'] == '0' ? '' : map['reply_id'],
        replyText: map['reply'] == null ? '' : map['reply'],
        time_text: map['time_text'] == null ? '' : map['time_text'],
        media: map['media'] == null ? '' : map['media'],
        stickers: map['stickers'] == null ? '' : map['stickers'],
        id: map['id'] == null ? '' : map['id'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        position: map['position'] == null ? '' : map['position'],
        avatar: map['user_data']['avatar'] == null
            ? ''
            : map['user_data']['avatar'],
        text: map['text'] == null ? '' : map['text'],
      );
}
