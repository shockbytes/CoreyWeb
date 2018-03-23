import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:CoreyWeb/app_component.dart';

void main() {
  bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    // Remove next line in production
    provide(LocationStrategy, useClass: HashLocationStrategy),
  ]);
}
