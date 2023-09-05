class GetProudctsModel {
  String images;
  String name;
  String id;
  final imagesAll;
  String type;
  String location;
  String price;
  String edit_description;
  String user_id;

  GetProudctsModel({
    required this.images,
    required this.edit_description,
    required this.imagesAll,
    required this.location,
    required this.id,
    required this.type,
    required this.price,
    required this.name,
    required this.user_id,
  });

  factory GetProudctsModel.fromJson(Map<String, dynamic> map) =>
      GetProudctsModel(
          edit_description:
              map['description'] == null ? '' : map['description'],
          imagesAll: map['images'],
          location: map['location'] == null ? '' : map['location'],
          type: map['type'] == null ? '' : map['type'],
          price: map['price'] == null ? '' : map['price'],
          id: map['id'] == null ? '' : map['id'],
          user_id: map['user_id'] == null ? '' : map['user_id'],
          name: map['name'] == null ? '' : map['name'],
          images: map['images'][0]['image_org'] == null
              ? ''
              : map['images'][0]['image_org']
          ////
          );
}
