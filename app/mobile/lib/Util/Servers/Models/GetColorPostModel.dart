class GetColorPostModel {
  final color_1;
  final color_2;
  final text_color;
  final image;
  GetColorPostModel({
    required this.color_1,
    required this.color_2,
    required this.text_color,
    required this.image,
  });

  factory GetColorPostModel.fromJson(Map<String, dynamic> map) =>
      GetColorPostModel(
        color_1: map['color_1'] == null ? '' : map['color_1'],
        color_2: map['color_2'] == null ? '' : map['color_2'],
        text_color: map['text_color'] == null ? '' : map['text_color'],
        image: map['image'] == null ? '' : map['image'],
      );
}
