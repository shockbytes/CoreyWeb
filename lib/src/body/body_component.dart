
import 'dart:async';

import 'package:CoreyWeb/src/service/database_service.dart';
import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'body',
  styleUrls: const ['body_component.css'],
  templateUrl: 'body_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [materialProviders],
)
class BodyComponent implements OnInit {

  final DatabaseService databaseService;

  String name;

  BodyComponent(FirebaseService this.databaseService);

  Future<Null> ngOnInit() async {

  }

}