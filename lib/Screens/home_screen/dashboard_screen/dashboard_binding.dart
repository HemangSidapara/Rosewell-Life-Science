import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}
