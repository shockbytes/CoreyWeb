class ScheduleItem {
  String name;
  String id;
  int day;
  bool isEmpty;

  ScheduleItem(this.id, this.name, this.day, this.isEmpty);

  ScheduleItem.fromMap(Map map)
      : this(map['id'], map['name'], map["day"], map["empty"]);

  Map toMap() => {
    "id": id,
    "name": name,
    "day": day,
    "empty": isEmpty
  };
}
