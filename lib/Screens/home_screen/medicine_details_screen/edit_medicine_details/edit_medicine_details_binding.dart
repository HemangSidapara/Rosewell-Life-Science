import 'package:get/get.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/edit_medicine_details/edit_medicine_details_controller.dart';

class EditMedicineDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(EditMedicineDetailsController());
  }
}
