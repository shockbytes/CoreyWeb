class ScheduleItem {
  String name;
  String id;
  int day;
  bool isEmpty;

  ScheduleItem({this.day = 0, this.id = "", this.name = "empty", this.isEmpty = true});

  ScheduleItem.fromMap(Map map)
      : this(id: map['id'], name: map['name'], day: map["day"],isEmpty: map["empty"]);

  Map toMap() => {
    "id": id,
    "name": name,
    "day": day,
    "empty": isEmpty
  };
}
