import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/splash_screen/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
