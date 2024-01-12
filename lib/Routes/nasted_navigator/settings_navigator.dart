import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/settings_screen/settings_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/settings_screen/settings_view.dart';

class SettingsNavigator extends StatelessWidget {
  const SettingsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(2),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return GetPageRoute(
              routeName: Routes.settingsScreen,
              page: () => const SettingsView(),
              binding: SettingsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
