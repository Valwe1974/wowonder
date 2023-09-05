
class MangeSessionsModel {
  String user_id;
  String id;
  String platform;
  String browser;
  String ip_address;
  String time;
  String session_id;
  MangeSessionsModel({
    required this.user_id,
    required this.platform,
    required this.id,
    required this.browser,
    required this.ip_address,
    required this.time,
    required this.session_id,
  });

  factory MangeSessionsModel.fromJson(Map<String, dynamic> map) =>
      MangeSessionsModel(
        session_id: map['session_id'] == null ? '' : map['session_id'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        platform: map['platform'] == null ? '' : map['platform'],
        browser: map['browser'] == null ? '' : map['browser'],
        ip_address: map['ip_address'] == null ? '' : map['ip_address'],
        time: map['time'] == null ? '' : map['time'],
        id: map['id'] == null ? '' : map['id'],

        ////
      );
}
