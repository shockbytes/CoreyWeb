class Workout {
  String id;
  String name;
  String intensity;
  String bodyRegion;

  Workout(this.id, this.name, this.bodyRegion, this.intensity);

  Workout.fromMap(Map map, String id)
      : this(id, map['name'].toString().replaceAll("_", " "), map["bodyRegion"],
            map["intensity"]);

  Map toMap() => {
        "name": name.replaceAll(" ", "_"),
        "bodyRegion": bodyRegion,
        "intensity": intensity
      };
}
