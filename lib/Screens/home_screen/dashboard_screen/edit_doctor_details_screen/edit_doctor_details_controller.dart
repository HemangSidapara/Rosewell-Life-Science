import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Network/models/doctor_details_model/get_doctor_model.dart' as get_doctor;
import 'package:rosewell_life_science/Network/models/medicine_details_models/get_medicine_model.dart' as get_medicine;
import 'package:rosewell_life_science/Network/services/doctor_details_service/doctor_details_service.dart';
import 'package:rosewell_life_science/Network/services/medicine_details_service/medicine_details_service.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class EditDoctorDetailsController extends GetxController {
  GlobalKey<FormState> editDoctorFormKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<String>> doctorDropdownKey = GlobalKey<DropdownSearchState<String>>();
  final GlobalKey<DropdownSearchState<String>> medicineDropdownKey = GlobalKey<DropdownSearchState<String>>();
  RxBool isDeleteDoctorLoading = false.obs;
  RxString deletingDID = ''.obs;

  TextEditingController doctorNameController = TextEditingController();
  RxList<String> pickedImageList = RxList();

  RxBool isGetDoctorLoading = false.obs;
  RxBool isGetMedicineLoading = false.obs;
  RxBool isEditMedicineLoading = false.obs;
  RxBool isValidate = true.obs;

  RxList<get_doctor.Data> doctorDataList = RxList<get_doctor.Data>();
  RxList<get_doctor.Data> selectedDoctorList = RxList<get_doctor.Data>();
  RxInt selectedDoctor = (-1).obs;

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

  String? validateDoctorList(get_doctor.Data? value) {
    if (value == null && isValidate.isFalse) {
      return AppStrings.pleaseSelectDoctor.tr;
    }
    return null;
  }

  Future<RxList<get_doctor.Data>> getDoctorsApiCall({bool isLoading = true}) async {
    try {
      isGetDoctorLoading(isLoading);
      final response = await DoctorDetailsService().getDoctorsService();

      if (response.isSuccess) {
        get_doctor.GetDoctorModel doctorModel = get_doctor.getDoctorModelFromJson(response.response.toString());
        doctorDataList.clear();
        doctorDataList.addAll(doctorModel.data?.toList() ?? []);
      }
      return doctorDataList;
    } finally {
      isGetDoctorLoading(false);
    }
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

  Future<void> checkEditDoctor() async {
    try {
      isEditMedicineLoading(true);
      isValidate.value = selectedMedicineList.isNotEmpty;
      final isValid = editDoctorFormKey.currentState?.validate();

      if (isValid == true) {
        final response = await DoctorDetailsService().updateDoctorService(
          dID: doctorDataList[selectedDoctor.value].dId ?? '',
          doctorName: doctorNameController.text.trim(),
          product: selectedMedicineList.map((element) => element.pId?.toInt() ?? -1).toList(),
        );

        if (response) {}
      }
    } finally {
      isEditMedicineLoading(false);
    }
  }

  Future<void> deleteDoctorApiCall({required String dID}) async {
    try {
      isDeleteDoctorLoading(true);
      final response = await DoctorDetailsService().deleteDoctorService(dID: dID);

      if (response.isSuccess) {
        Get.back(id: 0, closeOverlays: true);
        Utils.handleMessage(message: response.message);
      }
    } finally {
      isDeleteDoctorLoading(false);
    }
  }
}
