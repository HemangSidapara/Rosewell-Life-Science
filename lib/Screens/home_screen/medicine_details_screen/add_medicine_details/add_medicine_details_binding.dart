import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/add_medicine_details/add_medicine_details_controller.dart';

class AddMedicineDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddMedicineDetailsController());
  }
}
