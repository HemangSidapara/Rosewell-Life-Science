import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/presentation_for_doctors_screen/presentation_for_doctors_controller.dart';

class PresentationForDoctorsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PresentationForDoctorsController());
  }
}
