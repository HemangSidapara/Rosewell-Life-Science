import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/services/medicine_details_service/medicine_details_service.dart';

class AddMedicineDetailsController extends GetxController {
  GlobalKey<FormState> addMedicineFormKey = GlobalKey<FormState>();

  TextEditingController medicineNameController = TextEditingController();
  RxList<String> pickedImageList = RxList();

  RxBool isAddMedicineLoading = false.obs;
  RxBool isValidate = true.obs;

  String? validateMedicineName(String? value) {
    if (value?.isEmpty == true || value == null) {
      return AppStrings.pleaseEnterMedicineName.tr;
    }
    return null;
  }

  Future<void> checkAddMedicine() async {
    try {
      isAddMedicineLoading(true);
      isValidate.value = addMedicineFormKey.currentState?.validate() == true && pickedImageList.isNotEmpty;

      if (isValidate.isTrue) {
        final response = await MedicineDetailsService().addMedicineService(
          imagesPath: pickedImageList,
          medicineName: medicineNameController.text.trim(),
        );

        if (response) {}
      }
    } finally {
      isAddMedicineLoading(false);
    }
  }
}
