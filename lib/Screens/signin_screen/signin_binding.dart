import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/signin_screen/signin_controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
