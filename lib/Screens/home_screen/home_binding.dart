import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
