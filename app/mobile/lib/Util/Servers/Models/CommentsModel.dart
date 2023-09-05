class GetCommentsModel {
  String text;
  String id;
  String type;
  String avatar;
  String name;
  String c_file;
  int reaction1;
  int reaction;
  String comments_status;
  String comment_id;
  String replies;

  GetCommentsModel({
    required this.type,
    required this.replies,
    required this.comment_id,
    required this.text,
    required this.reaction,
    required this.reaction1,
    required this.id,
    required this.avatar,
    required this.name,
    required this.c_file,
    required this.comments_status,
  });

  factory GetCommentsModel.fromJson(Map<String, dynamic> map) =>
      GetCommentsModel(
        replies: map['replies'] == null ? '' : map['replies'],
        type: map['reaction'] == null
            ? ''
            : map['reaction']['type'] == null
                ? ''
                : map['reaction']['type'],
        comment_id: map['comment_id'] == null ? '' : map['comment_id'],
        comments_status:
            map['comments_status'] == null ? '' : map['comments_status'],
        reaction: map['reaction'] == null
            ? 0
            : map['reaction']['count'] == null
                ? '0'
                : map['reaction']['count'],
        reaction1: map['reaction'] == null
            ? 0
            : map['reaction']['1'] == null
                ? 0
                : map['reaction']['1'],
        id: map['id'] == null ? '' : map['id'],
        c_file: map['c_file'] == null ? '' : map['c_file'],
        name: map['publisher']['name'] == null ? '' : map['publisher']['name'],
        avatar: map['publisher']['avatar'] == null
            ? ''
            : map['publisher']['avatar'],
        text: map['text'] == null ? '' : map['text'],
      );
}
