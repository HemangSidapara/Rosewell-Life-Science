import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/edit_doctor_details_screen/edit_doctor_details_controller.dart';

class EditDoctorDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditDoctorDetailsController());
  }
}
