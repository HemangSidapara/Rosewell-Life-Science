import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';

class SettingsController extends GetxController {
  ExpansibleController expansionTileController = ExpansibleController();
  RxBool isGujaratiLang = true.obs;
  RxBool isHindiLang = true.obs;
  RxBool isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (getString(AppConstance.languageCode) == 'gu') {
      isGujaratiLang.value = true;
      isHindiLang.value = false;
    } else if (getString(AppConstance.languageCode) == 'hi') {
      isGujaratiLang.value = false;
      isHindiLang.value = true;
    } else if (getString(AppConstance.languageCode) == 'en') {
      isGujaratiLang.value = false;
      isHindiLang.value = false;
    } else {
      isGujaratiLang.value = false;
      isHindiLang.value = false;
    }
  }
}
