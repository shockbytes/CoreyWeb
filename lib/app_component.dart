import 'package:CoreyWeb/src/body/body_component.dart';
import 'package:CoreyWeb/src/schedule/schedule_component.dart';
import 'package:CoreyWeb/src/service/database_service.dart';
import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:CoreyWeb/src/workout/workout_component.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-app',
  styleUrls: const [
    'app_component.css',
    'package:angular_components/app_layout/layout.scss.css',
    'strip.css',
  ],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    WorkoutComponent,
    ScheduleComponent,
    MaterialTabComponent,
    MaterialTabPanelComponent,
    DeferredContentDirective,
    MaterialButtonComponent,
    FixedMaterialTabStripComponent,
    MaterialIconComponent,
    NgIf,
    MaterialPersistentDrawerDirective,
    CORE_DIRECTIVES,
    ROUTER_DIRECTIVES
  ],
  providers: const [materialProviders, FirebaseService],
)
@RouteConfig(const [
  const Route(
      path: '/workout',
      name: 'Workout',
      component: WorkoutComponent),
  const Route(
      path: '/schedule',
      name: 'Schedule',
      component: ScheduleComponent),
  const Route(
      path: '/mybody',
      name: 'MyBody',
      component: BodyComponent),
  const Redirect(path: '/', redirectTo: const ['Schedule']),
])
class AppComponent {

  final DatabaseService databaseService;
  final Router _router;
  final tabLabels = const <String>['Workout', 'Schedule', 'My Body'];

  AppComponent(FirebaseService this.databaseService, this._router);

  void onTabChange(TabChangeEvent event) {
    switch (event.newIndex) {
      case 0:
        _router.navigate(['Workout']);
        break;

      case 1:
        _router.navigate(['Schedule']);
        break;

      case 2:
        _router.navigate(['MyBody']);
        break;
    }
  }

  void login() {
    databaseService.signIn();
  }

  void logout() {
    databaseService.signOut();
  }

}
