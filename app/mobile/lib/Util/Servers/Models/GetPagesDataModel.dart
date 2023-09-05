class GetPagesDataModel {
  String call_action_type;
  String page_title;
  String about;
  String avatar;
  String cover;
  String website;
  String company;
  String phone;
  String address;
  final is_reported;
  final is_page_onwer;
  final is_verified;
  String call_action_type_text;
  final likes_count;
  final is_liked;
  final is_rated;
  String call_action_type_url;
  String users_post;
  String google;
  String vk;
  String twitter;
  String linkedin;
  String instgram;
  String youtube;
  String facebook;
  int rating;
  String post_count;

  String category;
  String page_id;
  String verified;
  GetPagesDataModel({
    required this.facebook,
    required this.is_reported,
    required this.call_action_type,
    required this.page_title,
    required this.about,
    required this.avatar,
    required this.cover,
    required this.website,
    required this.company,
    required this.phone,
    required this.address,
    required this.category,
    required this.is_page_onwer,
    required this.is_verified,
    required this.call_action_type_text,
    required this.likes_count,
    required this.is_liked,
    required this.is_rated,
    required this.call_action_type_url,
    required this.users_post,
    required this.google,
    required this.vk,
    required this.twitter,
    required this.linkedin,
    required this.instgram,
    required this.youtube,
    required this.rating,
    required this.post_count,
    required this.page_id,
    required this.verified,
    //
  });

  factory GetPagesDataModel.fromJson(Map<String, dynamic> map) =>
      GetPagesDataModel(
        call_action_type:
            map['call_action_type'] == null ? '' : map['call_action_type'],
        page_title: map['page_title'] == null ? '' : map['page_title'],
        about: map['about'] == null ? '' : map['about'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
        cover: map['cover'] == null ? '' : map['cover'],
        website: map['website'] == null ? '' : map['website'],
        company: map['company'] == null ? '' : map['company'],
        phone: map['phone'] == null ? '' : map['phone'],
        address: map['address'] == null ? '' : map['address'],
        category: map['category'] == null ? '' : map['category'],
        is_reported: map['is_reported'] == null ? false : map['is_reported'],
        is_page_onwer:
            map['is_page_onwer'] == null ? false : map['is_page_onwer'],
        is_verified: map['is_verified'] == null ? 0 : map['is_verified'],
        call_action_type_text: map['call_action_type_text'] == null
            ? ''
            : map['call_action_type_text'],
        likes_count: map['likes_count'] == null ? '' : map['likes_count'],
        is_liked: map['is_liked'] == null ? false : map['is_liked'],
        is_rated: map['is_rated'] == null ? false : map['is_rated'],
        call_action_type_url: map['call_action_type_url'] == null
            ? ''
            : map['call_action_type_url'],
        users_post: map['users_post'] == null ? '' : map['users_post'],
        google: map['google'] == null ? '' : map['google'],
        vk: map['vk'] == null ? '' : map['vk'],
        twitter: map['twitter'] == null ? '' : map['twitter'],
        linkedin: map['linkedin'] == null ? '' : map['linkedin'],
        instgram: map['instgram'] == null ? '' : map['instgram'],
        youtube: map['youtube'] == null ? '' : map['youtube'],
        rating: map['rating'] == null ? 0 : map['rating'],
        post_count: map['post_count'] == null ? '' : map['post_count'],
        facebook: map['facebook'] == null ? '' : map['facebook'],
        page_id: map['page_id'] == null ? '' : map['page_id'],
        verified: map['verified'] == null ? '' : map['verified'],
        ////
        ///
      );
}

//////////////////////////////
///
///
///


// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

