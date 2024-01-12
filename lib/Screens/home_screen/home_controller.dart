import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Routes/nasted_navigator/dashboard_navigator.dart';

class HomeController extends GetxController {
  RxInt bottomIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  List<Widget> bottomItemWidgetList = [
    const DashboardNavigator(),
    Container(),
    Container(),
    Container(),
  ];

  Future<void> onBottomItemChange({required int index}) async {
    bottomIndex.value = index;
    if (index == 0) {
      if (Get.keys[0]?.currentState?.canPop() == true) {
        Get.back(id: 0);
      }
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {}
    pageController.animateToPage(
      bottomIndex.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
