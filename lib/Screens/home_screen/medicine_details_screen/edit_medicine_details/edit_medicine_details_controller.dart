import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Network/models/medicine_details_models/get_medicine_model.dart' as get_medicine;
import 'package:rosewell_life_science/Network/services/medicine_details_service/medicine_details_service.dart';

class EditMedicineDetailsController extends GetxController {
  GlobalKey<FormState> editMedicineFormKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<String>> dropdownKey = GlobalKey<DropdownSearchState<String>>();
  RxBool isDeleteMedicineLoading = false.obs;
  RxString deletingPID = ''.obs;

  TextEditingController medicineNameController = TextEditingController();
  RxList<get_medicine.ProductMeta> oldImageList = RxList();
  RxList<String> pickedImageList = RxList();

  RxBool isGetMedicineLoading = false.obs;
  RxBool isEditMedicineLoading = false.obs;
  RxBool isValidate = true.obs;

  RxList<get_medicine.Data> medicineDataList = RxList<get_medicine.Data>();

  RxList<String> medicineList = RxList();
  RxInt selectedMedicine = (-1).obs;

  String? validateMedicineName(String? value) {
    if (value?.isEmpty == true || value == null) {
      return AppStrings.pleaseEnterMedicineName.tr;
    }
    return null;
  }

  String? validateMedicineList(get_medicine.Data? value) {
    if (value == null && isValidate.isFalse) {
      return AppStrings.pleaseSelectMedicine.tr;
    }
    return null;
  }

  Future<RxList<get_medicine.Data>> getMedicineApiCall({bool isLoading = true}) async {
    try {
      isGetMedicineLoading(isLoading);
      final response = await MedicineDetailsService().getMedicineService();

      if (response.isSuccess) {
        get_medicine.GetMedicineModel getStockModel = get_medicine.getMedicineModelFromJson(response.response.toString());
        medicineDataList.clear();
        medicineList.clear();
        medicineDataList.addAll(getStockModel.data?.toList() ?? []);
        medicineList.addAll(getStockModel.data?.toList().map((e) => e.name ?? '').toList() ?? []);
      }
      return medicineDataList;
    } finally {
      isGetMedicineLoading(false);
    }
  }

  Future<void> checkEditMedicine() async {
    try {
      isEditMedicineLoading(true);
      this.isValidate.value = pickedImageList.isNotEmpty || oldImageList.isNotEmpty;
      final isValidate = editMedicineFormKey.currentState?.validate() == true && this.isValidate.value;

      if (isValidate) {
        final response = await MedicineDetailsService().updateMedicineService(
          oldImage: oldImageList,
          imagesPath: pickedImageList,
          medicineName: medicineNameController.text.trim(),
          pID: medicineDataList[selectedMedicine.value].pId ?? '',
        );

        if (response) {}
      }
    } finally {
      isEditMedicineLoading(false);
    }
  }

  Future<void> deleteMedicineApiCall({required String pID}) async {
    try {
      isDeleteMedicineLoading(true);
      final response = await MedicineDetailsService().deleteMedicineService(pID: pID);

      if (response.isSuccess) {
        Get.back(id: 1, closeOverlays: true);
        Utils.handleMessage(message: response.message);
      }
    } finally {
      isDeleteMedicineLoading(false);
    }
  }
}
