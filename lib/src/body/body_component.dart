import 'dart:async';

import 'package:CoreyWeb/src/service/database_service.dart';
import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'body',
  styleUrls: const ['body_component.css'],
  templateUrl: 'body_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
    MaterialInputComponent,
    materialNumberInputDirectives,
    materialInputDirectives,
    formDirectives,
    MaterialNumberValueAccessor,
    MaterialMultilineInputComponent,
  ],
  providers: const [materialProviders],
)
class BodyComponent {

  final DatabaseService databaseService;

  BodyComponent(FirebaseService this.databaseService);

  void onChange(String text) {
    int weight = int.parse(text, onError: (source) => 75);
    databaseService.setDesiredWeight(weight);
  }

}