import 'dart:async';

import 'package:CoreyWeb/src/service/model/body_info.dart';
import 'package:CoreyWeb/src/service/model/corey_user.dart';
import 'package:CoreyWeb/src/service/model/schedule_item.dart';
import 'package:CoreyWeb/src/service/model/workout.dart';

abstract class DatabaseService {
  CoreyUser user;
  List<Workout> workouts;
  List<ScheduleItem> schedule;
  BodyInfo bodyInfo;

  // Login
  Future signIn();

  void signOut();

  // Body Info
  void setDesiredWeight(int weight);

  // Schedule
  void pushScheduleItem(String name, int day);

  void removeScheduleItem(ScheduleItem item);

  void updateScheduleItem(ScheduleItem item);

  List<String> availableScheduleItems();

}