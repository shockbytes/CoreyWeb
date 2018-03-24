import 'package:CoreyWeb/src/service/model/exercise.dart';

class TimeExercise extends Exercise {
  int restDuration;
  int workDuration;

  TimeExercise(String name, String repetitions, String equipment,
      this.restDuration, this.workDuration)
      : super(name, repetitions, equipment);
}
