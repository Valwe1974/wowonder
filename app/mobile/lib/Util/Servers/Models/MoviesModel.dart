class MoviesModel {
  String name;
  String genre;
  String iframe;
  String source;
  String views;
  String rating;
  String release;
  String producer;
  String country;
  String cover;
  String description;

  MoviesModel({
    required this.cover,
    required this.country,
    required this.source,
    required this.name,
    required this.genre,
    required this.iframe,
    required this.views,
    required this.rating,
    required this.release,
    required this.producer,
    required this.description,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> map) => MoviesModel(
        ///
        ///
        source: map['source'] == null ? '' : map['source'],
        producer: map['producer'] == null ? '' : map['producer'],
        iframe: map['iframe'] == null ? '' : map['iframe'],
        genre: map['genre'] == null ? '' : map['genre'],
        name: map['name'] == null ? '' : map['name'],
        views: map['views'] == null ? '' : map['views'],
        rating: map['rating'] == null ? '' : map['rating'],
        release: map['release'] == null ? '' : map['release'],
        country: map['country'] == null ? '' : map['country'],
        cover: map['cover'] == null ? '' : map['cover'],
        description: map['description'] == null ? '' : map['description'],

        ///
      );
}
