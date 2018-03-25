import 'dart:async';

import 'package:CoreyWeb/src/service/database_service.dart';
import 'package:CoreyWeb/src/service/firebase_credentials.dart';
import 'package:CoreyWeb/src/service/model/body_info.dart';
import 'package:CoreyWeb/src/service/model/corey_user.dart';
import 'package:CoreyWeb/src/service/model/goal.dart';
import 'package:CoreyWeb/src/service/model/schedule_item.dart';
import 'package:CoreyWeb/src/service/model/workout.dart';
import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;

@Injectable()
class FirebaseService implements DatabaseService {
  // Private fields
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.DatabaseReference _fbRefWorkouts;
  fb.DatabaseReference _fbRefSchedule;
  fb.DatabaseReference _fbRefBodyDesired;
  fb.DatabaseReference _fbRefBodyGoals;

  // Inherited fields
  CoreyUser user;
  List<Workout> workouts;
  List<ScheduleItem> schedule;
  BodyInfo bodyInfo = new BodyInfo(0, []);

  FirebaseService() {
    _setup();
  }

  void _setup() {
    var credentials = FirebaseCredentials.getCredentials();

    fb.initializeApp(
        apiKey: credentials["apiKey"],
        authDomain: credentials["authDomain"],
        databaseURL: credentials["databaseURL"],
        storageBucket: credentials["storageBucket"]);

    _setupAuth();
    _setupDatabase();
  }

  void _authChanged(fb.User fbUser) {
    // User logged in
    if (fbUser != null) {
      user = new CoreyUser(fbUser.displayName, fbUser.email, fbUser.photoURL);
    } else {
      user = null;
    }
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
    } catch (error) {
      print("$runtimeType::login() -- $error | While sign in!");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  // -------------------------------------------------

  // ----------------- Workout logic -----------------

  void _newWorkout(fb.QueryEvent event) {
    Workout workout =
        new Workout.fromMap(event.snapshot.val(), event.snapshot.key);
    workouts.add(workout);
  }

  void _changeWorkout(fb.QueryEvent event) {
    Workout workout =
        new Workout.fromMap(event.snapshot.val(), event.snapshot.key);
    // TODO Extract index of Workout
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
    schedule =
        new List.generate(7, (i) => new ScheduleItem(day: i), growable: false);

    _fbRefSchedule = fb.database().ref("schedule");
    _fbRefSchedule.onChildAdded.listen(_newSchedule);
    _fbRefSchedule.onChildChanged.listen(_changeSchedule);
    _fbRefSchedule.onChildRemoved.listen(_removeSchedule);
  }

  void _newSchedule(fb.QueryEvent event) {
    ScheduleItem item = new ScheduleItem.fromMap(event.snapshot.val());
    schedule[item.day] = item;
  }

  void _changeSchedule(fb.QueryEvent event) {
    ScheduleItem item = new ScheduleItem.fromMap(event.snapshot.val());

    // Remove old position with the same id
    schedule
        .where((it) => it.id == item.id)
        .map((it) => it.day)
        .forEach((day) => schedule[day] = new ScheduleItem(day: day));

    // Update the new item
    schedule[item.day] = item;
  }

  void _removeSchedule(fb.QueryEvent event) {
    ScheduleItem item = new ScheduleItem.fromMap(event.snapshot.val());
    schedule[item.day] = new ScheduleItem(day: item.day);
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
    Goal goal = new Goal.fromMap(event.snapshot.val());
    // TODO Extract index of goal
  }

  void _removeBodyInfoGoals(fb.QueryEvent event) {
    Goal goal = new Goal.fromMap(event.snapshot.val());
    bodyInfo.goals.removeWhere((g) => g.id == goal.id);
  }
}
