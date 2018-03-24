


import 'dart:async';

import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'schedule',
  styleUrls: const ['schedule_component.css'],
  templateUrl: 'schedule_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [materialProviders],
)
class ScheduleComponent {

  final FirebaseService _firebase;

  ScheduleComponent(FirebaseService this._firebase);

  Future<Null> ngOnInit() async {
    // TODO
  }

}