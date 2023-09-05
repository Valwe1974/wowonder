class OffersModel {
  final id;
  final page_id;
  String offer_text;
  String description;
  String image;
  String expire_date;

  OffersModel({
    required this.image,
    required this.description,
    required this.offer_text,
    required this.id,
    required this.page_id,
    required this.expire_date,
  });

  factory OffersModel.fromJson(Map<String, dynamic> map) => OffersModel(
        expire_date: map['expire_date'] == null ? '' : map['expire_date'],
        image: map['image'] == null ? '' : map['image'],
        description: map['description'] == null ? '' : map['description'],
        offer_text: map['offer_text'] == null ? '' : map['offer_text'],
        id: map['id'] == null ? '' : map['id'],
        page_id: map['page_id'] == null ? '' : map['page_id'],
      );
}
