import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/settings_screen/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
