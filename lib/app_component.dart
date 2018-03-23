import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:CoreyWeb/src/workout/workout_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';

@Component(
  selector: 'my-app',
  styleUrls: const [
    'app_component.css',
    'package:angular_components/app_layout/layout.scss.css',
  ],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    WorkoutComponent,
    MaterialTabComponent,
    RouterOutlet,
    MaterialTabPanelComponent,
    DeferredContentDirective,
    MaterialButtonComponent,
    FixedMaterialTabStripComponent,
    MaterialIconComponent,
    NgIf,
    MaterialPersistentDrawerDirective,
  ],
  providers: const [materialProviders, FirebaseService],
)
class AppComponent {
  int tabIndex = 0;
  final FirebaseService firebase;

  final tabLabels = const <String>[
    'Workout',
    'Schedule',
    'My Body'
  ];

  AppComponent(FirebaseService this.firebase);

  void onTabChange(TabChangeEvent event) {
    tabIndex = event.newIndex;
  }

  void login() {
    if (!firebase.isSignedIn()) {
      firebase.signIn();
    } else {
      firebase.signOut();
    }
  }

}
