

class PokesModel {
  ///

  String id;
  String received_user_id;
  String send_user_id;
  String dt;
  String avatar;
  String name;
  String user_id;
  String cover;
  PokesModel({
    required this.avatar,
    required this.dt,
    required this.id,
    required this.received_user_id,
    required this.send_user_id,
    required this.name,
    required this.user_id,
    required this.cover,
    //
  });

  factory PokesModel.fromJson(Map<String, dynamic> map) => PokesModel(
        user_id: map['user_data'] == null ? '' : map['user_data']['user_id'],
        cover: map['user_data'] == null ? '' : map['user_data']['cover'],
        name: map['user_data'] == null ? '' : map['user_data']['name'],
        avatar: map['user_data'] == null ? '' : map['user_data']['avatar'],
        dt: map['dt'] == null ? '' : map['dt'],
        send_user_id: map['send_user_id'] == null ? '' : map['send_user_id'],
        received_user_id:
            map['received_user_id'] == null ? '' : map['received_user_id'],
        id: map['id'] == null ? '' : map['id'],

        //
      );
}
