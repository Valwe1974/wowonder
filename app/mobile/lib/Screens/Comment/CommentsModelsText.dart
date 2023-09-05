class Comment {
  // ignore: constant_identifier_names
  static const TAG = 'Comment';

  String? avatar;
  String? userName;
  String? content;
  String? images;
  int? reaction1;
  int? reaction;
  String? id;
  String? comment_id;
  String? type;
  Comment({
    required this.comment_id,
    required this.type,
    required this.reaction,
    required this.id,
    required this.reaction1,
    required this.avatar,
    required this.userName,
    required this.content,
    required this.images,
  });
}
