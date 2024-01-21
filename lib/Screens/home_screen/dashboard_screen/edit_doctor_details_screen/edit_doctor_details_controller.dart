import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDoctorDetailsController extends GetxController {
  GlobalKey<FormState> editMedicineFormKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState<String>> dropdownKey = GlobalKey<DropdownSearchState<String>>();
  RxBool isDeleteMedicineLoading = false.obs;
  RxString deletingPID = ''.obs;

  TextEditingController medicineNameController = TextEditingController();
  RxList<String> oldImageList = RxList();
  RxList<String> pickedImageList = RxList();

  RxBool isGetMedicineLoading = false.obs;
  RxBool isEditMedicineLoading = false.obs;
  RxBool isValidate = true.obs;
}
