import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/password_screen/password_controller.dart';

class PasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PasswordController());
  }
}
