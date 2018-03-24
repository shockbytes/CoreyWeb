import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:CoreyWeb/src/service/model/body_info.dart';
import 'package:CoreyWeb/src/service/model/goal.dart';
import 'package:CoreyWeb/src/service/model/schedule_item.dart';
import 'package:CoreyWeb/src/service/model/workout.dart';
import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;

@Injectable()
class FirebaseService {
  // Private fields
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.DatabaseReference _fbRefWorkouts;
  fb.DatabaseReference _fbRefSchedule;
  fb.DatabaseReference _fbRefBodyDesired;
  fb.DatabaseReference _fbRefBodyGoals;

  // Public fields
  fb.User user;
  List<Workout> workouts;
  List<ScheduleItem> schedule;
  BodyInfo bodyInfo = new BodyInfo(0, []);

  FirebaseService() {
    _loadCredentials();
  }

  void _loadCredentials() {
    var url = "http://localhost:8080/firebase_config.json";
    HttpRequest.getString(url).then(_onCredentialsLoaded).catchError(_onError);
  }

  void _onCredentialsLoaded(String response) {
    var json = JSON.decode(response);

    fb.initializeApp(
        apiKey: json["apiKey"],
        authDomain: json["authDomain"],
        databaseURL: json["databaseURL"],
        storageBucket: json["storageBucket"]);

    _setupAuth();
    _setupDatabase();
  }

  bool _onError(Object any) {
    print("Error while requesting data... $any");
    return true;
  }

  void _authChanged(fb.User fbUser) {
    user = fbUser;
  }

  void _setupAuth() {
    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  void _setupDatabase() {
    _setupWorkoutDatabase();
    _setupScheduleDatabase();
    _setupBodyInfoDatabase();
  }

  // ----------------- Sign in logic -----------------

  Future signIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
      print(_fbAuth.currentUser.displayName);
    } catch (error) {
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  bool isSignedIn() {
    return _fbAuth.currentUser != null;
  }

  // -------------------------------------------------

  // ----------------- Workout logic -----------------

  void _newWorkout(fb.QueryEvent event) {
    Workout workout =
        new Workout.fromMap(event.snapshot.val(), event.snapshot.key);
    workouts.add(workout);
  }

  void _changeWorkout(fb.QueryEvent event) {
    // TODO
  }

  void _removeWorkout(fb.QueryEvent event) {
    Workout workout =
        new Workout.fromMap(event.snapshot.val(), event.snapshot.key);
    workouts.removeWhere((w) => w.id == workout.id);
  }

  void _setupWorkoutDatabase() {
    workouts = [];
    _fbRefWorkouts = fb.database().ref("workout");
    _fbRefWorkouts.onChildAdded.listen(_newWorkout);
    _fbRefWorkouts.onChildChanged.listen(_changeWorkout);
    _fbRefWorkouts.onChildRemoved.listen(_removeWorkout);
  }

  // -------------------------------------------------

  // ---------------- Schedule logic -----------------

  void _setupScheduleDatabase() {
    schedule = [];
    _fbRefSchedule = fb.database().ref("schedule");
    _fbRefSchedule.onChildAdded.listen(_newSchedule);
    _fbRefSchedule.onChildChanged.listen(_changeSchedule);
    _fbRefSchedule.onChildRemoved.listen(_removeSchedule);
  }

  void _newSchedule(fb.QueryEvent event) {
    ScheduleItem item = new ScheduleItem.fromMap(event.snapshot.val());
    schedule.add(item);
  }

  void _changeSchedule(fb.QueryEvent event) {
    // TODO
  }

  void _removeSchedule(fb.QueryEvent event) {
    ScheduleItem item = new ScheduleItem.fromMap(event.snapshot.val());
    schedule.removeWhere((w) => w.id == item.id);
  }

  // -------------------------------------------------

  // --------------- Body info logic -----------------
  void _setupBodyInfoDatabase() {

    _fbRefBodyDesired = fb.database().ref("body/desired");
    _fbRefBodyDesired.onValue.listen(_bodyInfoDesiredWeight);

    _fbRefBodyGoals = fb.database().ref("body/goal");
    _fbRefBodyGoals.onChildAdded.listen(_newBodyInfoGoals);
    _fbRefBodyGoals.onChildChanged.listen(_changeBodyInfoGoals);
    _fbRefBodyGoals.onChildChanged.listen(_removeBodyInfoGoals);
  }

  void _bodyInfoDesiredWeight(fb.QueryEvent event) {
    bodyInfo.desiredWeight = event.snapshot.val();
  }

  void _newBodyInfoGoals(fb.QueryEvent event) {
    Goal goal = new Goal.fromMap(event.snapshot.val());
    bodyInfo.goals.add(goal);
  }

  void _changeBodyInfoGoals(fb.QueryEvent event) {
    // TODO
  }

  void _removeBodyInfoGoals(fb.QueryEvent event) {
    Goal goal = new Goal.fromMap(event.snapshot.val());
    bodyInfo.goals.removeWhere((g) => g.id == goal.id);
  }

}
