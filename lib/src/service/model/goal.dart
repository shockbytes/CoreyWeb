class Goal {
  String id;
  String message;
  bool isDone;

  Goal(this.id, this.message, this.isDone);

  Goal.fromMap(Map map) : this(map['id'], map['message'], map["done"]);

  Map toMap() => {"id": id, "message": message, "done": isDone};
}
