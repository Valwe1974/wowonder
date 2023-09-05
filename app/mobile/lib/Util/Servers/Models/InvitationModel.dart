class InvitationModel {
  List<UserDataStory> Data;

  InvitationModel({
    required this.Data,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> map) => InvitationModel(
        Data: List<UserDataStory>.from(
            map["data"].map((x) => UserDataStory.fromJson(x))),
      );
}

class UserDataStory {
  String user_id;

  // String filename;
  // List<Videos> videos;
  UserDataStory({
    // required this.filename,
    required this.user_id,
  });

  factory UserDataStory.fromJson(Map<String, dynamic> map) => UserDataStory(
        // filename:map['videos'][0]==null?'':map['videos'][0]['filename'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        // videos: List<Videos>.from(map["videos"].map((x) => Videos.fromJson(x))),

        ////
      );
}

class Videos {
  String id;

  String filename;
  Videos({
    required this.filename,
    required this.id,
  });

  factory Videos.fromJson(Map<String, dynamic> map) => Videos(
        id: map['id'] == null ? '' : map['id'],
        filename: map['filename'] == null ? '' : map['filename'],

        ////
      );
}
