import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/medicine_details_controller.dart';

class MedicineDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MedicineDetailsController());
  }
}
