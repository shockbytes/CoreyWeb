


import 'dart:async';

import 'package:CoreyWeb/src/service/database_service.dart';
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

  final DatabaseService databaseService;

  ScheduleComponent(FirebaseService this.databaseService);

  Future<Null> ngOnInit() async {

  }

}