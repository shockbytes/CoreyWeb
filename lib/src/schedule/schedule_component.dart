
import 'package:CoreyWeb/src/service/database_service.dart';
import 'package:CoreyWeb/src/service/firebase_service.dart';
import 'package:CoreyWeb/src/service/model/schedule_item.dart';
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
  final today = new DateTime.now().weekday - 1; // Start with 0 index;
  final days = const <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // -------------- For detail view --------------
  bool showScheduleDetailDialog = false;
  String scheduleDetailDay = "";
  String scheduleName = "";
  ScheduleItem selectedDetailItem;
  // ---------------------------------------------

  ScheduleComponent(FirebaseService this.databaseService);

  scheduleClick(ScheduleItem item) {
    _showDialog(item);
  }

  scheduleItemSelected(String item) {
    print(item);

    if (selectedDetailItem.isEmpty) {
      databaseService.pushScheduleItem(item, selectedDetailItem.day);
    } else {
      databaseService.updateScheduleItem(selectedDetailItem..name = item);
    }

    _resetDialog();
  }

  clearDay() {

    databaseService.removeScheduleItem(selectedDetailItem);
    _resetDialog();
  }

  _showDialog(ScheduleItem item) {
    scheduleDetailDay = days[item.day];
    selectedDetailItem = item;
    scheduleName = !item.isEmpty ? item.name : "";
    showScheduleDetailDialog = true;
  }

  _resetDialog() {
    selectedDetailItem = null;
    showScheduleDetailDialog = false;
  }

}
