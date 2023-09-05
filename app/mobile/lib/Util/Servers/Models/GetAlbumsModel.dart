class GetAlbumsModel {
  String first_image;
  final photo_album;
  String album_name;
  String id;

  GetAlbumsModel({
    required this.first_image,
    required this.id,
    required this.album_name,
    required this.photo_album,
  });

  factory GetAlbumsModel.fromJson(Map<String, dynamic> map) => GetAlbumsModel(
        id: map['id'] == null ? '' : map['id'],
        first_image: map['first_image'] == null ? '' : map['first_image'],
        photo_album: map['photo_album'],
        album_name: map['album_name'] == null ? '' : map['album_name'],

        ////
      );
}
