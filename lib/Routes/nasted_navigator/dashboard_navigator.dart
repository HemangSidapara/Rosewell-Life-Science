import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/dashboard_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/dashboard_view.dart';

class DashboardNavigator extends StatelessWidget {
  const DashboardNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(0),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return GetPageRoute(
              routeName: Routes.dashboardScreen,
              page: () => const DashboardView(),
              binding: DashboardBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
