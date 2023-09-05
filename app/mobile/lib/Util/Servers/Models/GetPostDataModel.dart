class GetPostDataModel {
  final is_post_saved;
  final is_post_reported;
  final comments_status;
  GetPostDataModel({
    required this.is_post_reported,
    required this.comments_status,
    required this.is_post_saved,
  });

  factory GetPostDataModel.fromJson(Map<String, dynamic> map) =>
      GetPostDataModel(
          comments_status:
              map['comments_status'] == null ? '' : map['comments_status'],
          is_post_reported:
              map['is_post_reported'] == null ? '' : map['is_post_reported'],
          is_post_saved:
              map['is_post_saved'] == null ? '' : map['is_post_saved']);
}
