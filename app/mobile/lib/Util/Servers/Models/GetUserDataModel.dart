class GetUserDataModel {
  String name;
  String friend_privacy;
  String country_id;
  String email;
  String follow_privacy;
  String first_name;
  String phone_number;
  String last_name;
  String url;
  String cover;
  String pro_type;
  String confirm_followers;
  String avatar;
  String adminPanel;
  String verified;
  String following_count;
  String followers_count;
  String post_count;
  int is_following;
  String gender;
  String balance;
  String address;
  String working;
  String wallet;
  String about;
  String school;
  String working_link;
  String birthday;
  int is_following_me;
  String website;
  int can_follow;
  String user_id;
  String message_privacy;
  String username;
  String google;
  String vk;
  String twitter;
  String linkedin;
  String instgram;
  String youtube;
  String facebook;
  String points;
  final API_notification_settings;
  GetUserDataModel({
    required this.pro_type,
    required this.adminPanel,
    required this.API_notification_settings,
    required this.country_id,
    required this.friend_privacy,
    required this.follow_privacy,
    required this.email,
    required this.phone_number,
    required this.username,
    required this.points,
    required this.url,
    required this.user_id,
    required this.confirm_followers,
    required this.can_follow,
    required this.wallet,
    required this.first_name,
    required this.working,
    required this.address,
    required this.balance,
    required this.gender,
    required this.last_name,
    required this.birthday,
    required this.following_count,
    required this.post_count,
    required this.is_following,
    required this.avatar,
    required this.followers_count,
    required this.verified,
    required this.cover,
    required this.name,
    required this.about,
    required this.school,
    required this.working_link,
    required this.website,
    required this.message_privacy,
    required this.is_following_me,
    required this.google,
    required this.vk,
    required this.twitter,
    required this.linkedin,
    required this.instgram,
    required this.youtube,
    required this.facebook,

    ////details
  });

  factory GetUserDataModel.fromJson(Map<String, dynamic> map) =>
      GetUserDataModel(
          pro_type: map['pro_type'] == null ? '' : map['pro_type'],
          wallet: map['wallet'] == null ? '' : map['wallet'],
          balance: map['balance'] == null ? '' : map['balance'],
          points: map['points'] == null ? '' : map['points'],
          url: map['url'] == null ? '' : map['url'],
          API_notification_settings: map['API_notification_settings'],
          follow_privacy:
              map['follow_privacy'] == null ? '' : map['follow_privacy'],
          friend_privacy:
              map['friend_privacy'] == null ? '' : map['friend_privacy'],
          country_id: map['country_id'] == null ? '' : map['country_id'],
          adminPanel: map['admin'],
          email: map['email'] == null ? '' : map['email'],
          phone_number: map['phone_number'] == null ? '' : map['phone_number'],
          last_name: map['last_name'] == null ? '' : map['last_name'],
          first_name: map['first_name'] == null ? '' : map['first_name'],
          username: map['username'] == null ? '' : map['username'],
          user_id: map['user_id'] == null ? '' : map['user_id'],
          is_following_me:
              map['is_following_me'] == null ? 0 : map['is_following_me'],
          message_privacy:
              map['message_privacy'] == null ? '' : map['message_privacy'],
          confirm_followers:
              map['confirm_followers'] == null ? '' : map['confirm_followers'],
          can_follow: map['can_follow'] == null ? '' : map['can_follow'],
          website: map['website'] == null ? '' : map['website'],
          birthday: map['birthday'] == null ? '' : map['birthday'],
          working_link: map['working_link'] == null ? '' : map['working_link'],
          about: map['about'] == null ? '' : map['about'],
          school: map['school'] == null ? '' : map['school'],
          working: map['working'] == null ? '' : map['working'],
          address: map['address'] == null ? '' : map['address'],
          gender: map['gender'] == null ? '' : map['gender'],
          is_following: map['is_following'] == null ? '' : map['is_following'],
          post_count: map['details']['post_count'],
          verified: map['verified'],
          following_count: map['details']['following_count'] == null
              ? ''
              : map['details']['following_count'],
          followers_count: map['details']['followers_count'] == null
              ? ''
              : map['details']['followers_count'],
          cover: map['cover'] == null ? '' : map['cover'],
          avatar: map['avatar'] == null ? '' : map['avatar'],
          google: map['google'] == null ? '' : map['google'],
          vk: map['vk'] == null ? '' : map['vk'],
          twitter: map['twitter'] == null ? '' : map['twitter'],
          linkedin: map['linkedin'] == null ? '' : map['linkedin'],
          instgram: map['instgram'] == null ? '' : map['instgram'],
          youtube: map['youtube'] == null ? '' : map['youtube'],
          facebook: map['facebook'] == null ? '' : map['facebook'],
          name: map['name'] == null ? '' : map['name']);

  /////details
}
