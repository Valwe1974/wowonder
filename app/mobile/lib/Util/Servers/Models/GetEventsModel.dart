class GetEventsModel {
  String name;
  String location;
  String cover;
  String start_date;
  String end_date;
  String description;
  String going_count;
  String interested_count;
  bool is_going;
  bool is_interested;

  GetEventsModel({
    required this.is_interested,
    required this.is_going,
    required this.interested_count,
    required this.end_date,
    required this.going_count,
    required this.start_date,
    required this.description,
    required this.cover,
    required this.location,
    required this.name,
  });

  factory GetEventsModel.fromJson(Map<String, dynamic> map) => GetEventsModel(
        is_interested:
            map['is_interested'] == null ? false : map['is_interested'],
        is_going: map['is_going'] == null ? false : map['is_going'],
        interested_count:
            map['interested_count'] == null ? '' : map['interested_count'],
        going_count: map['going_count'] == null ? '' : map['going_count'],
        description: map['description'] == null ? '' : map['description'],
        end_date: map['end_date'] == null ? '' : map['end_date'],
        start_date: map['start_date'] == null ? '' : map['start_date'],
        cover: map['cover'] == null ? '' : map['cover'],
        name: map['name'] == null ? '' : map['name'],
        location: map['location'] == null ? '' : map['location'],
      );
}
