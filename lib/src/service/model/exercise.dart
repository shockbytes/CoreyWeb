class Exercise {
  String equipment;
  String name;
  String repetitions;

  Exercise(this.name, this.repetitions, this.equipment);

  Exercise.fromMap(Map map)
      : this(map['name'].toString().replaceAll("_", " "), map["repetitions"],
            map["equipment"]);

  Map toMap() => {
        "name": name.replaceAll(" ", "_"),
        "repetitions": repetitions,
        "equipment": equipment
      };
}
