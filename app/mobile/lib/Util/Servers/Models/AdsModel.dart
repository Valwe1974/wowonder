class AdsModel {
  String id;
  String url;
  String name;
  String headline;
  String description;
  String location;
  String ad_media;
  String gender;
  String bidding;
  String clicks;
  String views;
  String appears;
  String timeStart;
  String timeEnd;
  String budget;
  final country_ids;

  AdsModel({
    required this.country_ids,
    required this.budget,
    required this.timeStart,
    required this.timeEnd,
    required this.appears,
    required this.views,
    required this.description,
    required this.id,
    required this.url,
    required this.name,
    required this.headline,
    required this.location,
    required this.ad_media,
    required this.gender,
    required this.bidding,
    required this.clicks,
  });

  factory AdsModel.fromJson(Map<String, dynamic> map) => AdsModel(
      country_ids: map['country_ids'] == null ? '' : map['country_ids'],
      budget: map['budget'] == null ? '' : map['budget'],
      timeEnd: map['end'] == null ? '' : map['end'],
      timeStart: map['start'] == null ? '' : map['start'],
      appears: map['appears'] == null ? '' : map['appears'],
      views: map['views'] == null ? '' : map['views'],
      clicks: map['clicks'] == null ? '' : map['clicks'],
      bidding: map['bidding'] == null ? '' : map['bidding'],
      gender: map['gender'] == null ? '' : map['gender'],
      ad_media: map['ad_media'] == null ? "" : map['ad_media'],
      id: map['id'] == null ? "" : map['id'],
      url: map['url'] == null ? '' : map['url'],
      headline: map['headline'] == null ? '' : map['headline'],
      description: map['description'] == null ? '' : map['description'],
      location: map['location'] == null ? '' : map['location'],
      name: map['name'] == null ? '' : map['name']);
}
