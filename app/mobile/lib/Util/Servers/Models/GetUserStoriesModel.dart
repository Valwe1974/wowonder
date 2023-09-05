class GetUserStoriesModel {
  String name;
  String avatar;
  String stories;
  String user_id;
  List<UserDataStory> storiess;

  GetUserStoriesModel(
      {required this.name,
      required this.storiess,
      required this.avatar,
      required this.stories,
      required this.user_id});

  factory GetUserStoriesModel.fromJson(
          Map<String, dynamic> map) =>
      GetUserStoriesModel(
          storiess: List<UserDataStory>.from(
              map["stories"].map((x) => UserDataStory.fromJson(x))),
          user_id: map['user_id'] == null ? '' : map['user_id'],
          stories: map['stories'][0]['thumbnail'] == null
              ? ''
              : map['stories'][0]['thumbnail'],
          name: map['name'] == null ? '' : map['name'],
          avatar: map['avatar'] == null ? '' : map['avatar']
          ////
          );
}

class UserDataStory {
  String id;
  String thumbnail;
  String description;
  int view_count;
  // String filename;
  List<Videos> videos;
  UserDataStory({
    required this.description,
    required this.videos,
    required this.view_count,
    // required this.filename,
    required this.id,
    required this.thumbnail,
  });

  factory UserDataStory.fromJson(Map<String, dynamic> map) => UserDataStory(
        view_count: map['view_count'] == null ? '' : map['view_count'],
        description: map['description'] == null ? '' : map['description'],
        // filename:map['videos'][0]==null?'':map['videos'][0]['filename'],
        id: map['id'] == null ? '' : map['id'],
        videos: List<Videos>.from(map["videos"].map((x) => Videos.fromJson(x))),
        thumbnail: map['thumbnail'] == null ? '' : map['thumbnail'],
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
