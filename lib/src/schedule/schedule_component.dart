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
  final today = new DateTime.now().weekday -1; // Start with 0 index;
  final days = const <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  ScheduleComponent(FirebaseService this.databaseService);

}