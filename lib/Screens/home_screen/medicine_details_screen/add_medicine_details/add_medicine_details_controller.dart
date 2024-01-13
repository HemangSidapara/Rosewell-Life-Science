import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';

class AddMedicineDetailsController extends GetxController {
  GlobalKey<FormState> addMedicineFormKey = GlobalKey<FormState>();

  RxList<String> pickedImageList = RxList();

  String? validateMedicineName(String? value) {
    if (value?.isEmpty == true || value == null) {
      return AppStrings.pleaseEnterMedicineName.tr;
    }
    return null;
  }
}
