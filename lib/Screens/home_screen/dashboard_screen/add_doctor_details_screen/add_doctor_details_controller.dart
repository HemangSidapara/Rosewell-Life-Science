import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/models/medicine_details_models/get_medicine_model.dart' as get_medicine;
import 'package:rosewell_life_science/Network/services/doctor_details_service/doctor_details_service.dart';
import 'package:rosewell_life_science/Network/services/medicine_details_service/medicine_details_service.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class AddDoctorDetailsController extends GetxController {
  GlobalKey<FormState> addDoctorFormKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<String>> dropdownKey = GlobalKey<DropdownSearchState<String>>();

  TextEditingController doctorNameController = TextEditingController();
  RxList<String> pickedImageList = RxList();

  RxBool isGetMedicineLoading = false.obs;
  RxBool isAddDoctorLoading = false.obs;
  RxBool isValidate = true.obs;

  RxList<get_medicine.Data> medicineDataList = RxList<get_medicine.Data>();
  RxList<get_medicine.Data> selectedMedicineList = RxList<get_medicine.Data>();

  String? validateDoctorName(String? value) {
    if (value?.isEmpty == true || value == null) {
      return AppStrings.pleaseEnterDoctorName.tr;
    }
    return null;
  }

  String? validateMedicineList(List<get_medicine.Data>? value) {
    if ((value == null || value.isEmpty) && isValidate.isFalse) {
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
        medicineDataList.addAll(getStockModel.data?.toList() ?? []);
      }
      return medicineDataList;
    } finally {
      isGetMedicineLoading(false);
    }
  }

  Future<void> checkAddMedicine() async {
    try {
      isAddDoctorLoading(true);
      isValidate.value = selectedMedicineList.isNotEmpty;
      final isValid = addDoctorFormKey.currentState?.validate();

      if (isValid == true) {
        final response = await DoctorDetailsService().addDoctorsService(
          doctorName: doctorNameController.text.trim(),
          product: selectedMedicineList.map((element) => element.pId?.toInt() ?? -1).toList(),
        );

        if (response) {}
      }
    } finally {
      isAddDoctorLoading(false);
    }
  }
}
