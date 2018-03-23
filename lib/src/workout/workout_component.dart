import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';


@Component(
  selector: 'workout',
  styleUrls: const ['workout_component.css'],
  templateUrl: 'workout_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [materialProviders],
)
@RouteConfig(const [
  const Route(path: '/workout', name: 'Workout', component: WorkoutComponent)
])
class WorkoutComponent implements OnInit {


  @override
  ngOnInit() {
    // TODO: implement ngOnInit
  }

  WorkoutComponent();

}