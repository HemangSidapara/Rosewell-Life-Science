import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Routes/nasted_navigator/dashboard_navigator.dart';
import 'package:rosewell_life_science/Routes/nasted_navigator/medicine_details_navigator.dart';
import 'package:rosewell_life_science/Routes/nasted_navigator/settings_navigator.dart';

class HomeController extends GetxController {
  RxInt bottomIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  List<Widget> bottomItemWidgetList = [
    const DashboardNavigator(),
    const MedicineDetailsNavigator(),
    const SettingsNavigator(),
  ];

  Future<void> onBottomItemChange({required int index}) async {
    bottomIndex.value = index;
    if (index == 0) {
      if (Get.keys[0]?.currentState?.canPop() == true) {
        Get.back(id: 0);
      }
    } else if (index == 1) {
      if (Get.keys[1]?.currentState?.canPop() == true) {
        Get.back(id: 1);
      }
    }
    pageController.animateToPage(
      bottomIndex.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
