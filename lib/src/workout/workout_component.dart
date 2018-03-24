import 'dart:async';

import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:CoreyWeb/src/service/model/workout.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';


@Component(
  selector: 'workout',
  styleUrls: const ['workout_component.css'],
  templateUrl: 'workout_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [materialProviders],
  pipes: const [COMMON_PIPES],
)
class WorkoutComponent {

  final FirebaseService firebase;

  WorkoutComponent(FirebaseService this.firebase);

}