// CommentLiveModel

class CommentLiveModel {
  String text;
  String avatar;
  String name;
  String id;

  CommentLiveModel({
    required this.text,
    required this.avatar,
    required this.name,
    required this.id,
  });

  factory CommentLiveModel.fromJson(Map<String, dynamic> map) =>
      CommentLiveModel(
        id: map['id'] == null ? '' : map['id'],
        name: map['publisher']['name'] == null ? '' : map['publisher']['name'],
        text: map['text'] == null ? '' : map['text'],
        avatar: map['publisher']['avatar'] == null
            ? ''
            : map['publisher']['avatar'],

        ////
      );
}
