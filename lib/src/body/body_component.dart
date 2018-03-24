
import 'dart:async';

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

  final FirebaseService _firebase;

  String name;

  BodyComponent(FirebaseService this._firebase);

  Future<Null> ngOnInit() async {
    name = _firebase.user?.displayName;
    //heroes = (await _heroService.getHeroes()).skip(1).take(4).toList();
  }

}