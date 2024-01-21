import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/add_doctor_details_screen/add_doctor_details_controller.dart';

class AddDoctorDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddDoctorDetailsController());
  }
}
