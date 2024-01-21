import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/add_doctor_details_screen/add_doctor_details_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/add_doctor_details_screen/add_doctor_details_view.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/dashboard_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/dashboard_view.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/edit_doctor_details_screen/edit_doctor_details_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/edit_doctor_details_screen/edit_doctor_details_view.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/presentation_for_doctors_screen/presentation_for_doctors_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/presentation_for_doctors_screen/presentation_for_doctors_view.dart';

class DashboardNavigator extends StatelessWidget {
  const DashboardNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(0),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.presentationForDoctorsScreen:
            return GetPageRoute(
              routeName: Routes.presentationForDoctorsScreen,
              page: () => const PresentationForDoctorsView(),
              binding: PresentationForDoctorsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.addDoctorDetailsScreen:
            return GetPageRoute(
              routeName: Routes.addDoctorDetailsScreen,
              page: () => const AddDoctorDetailsView(),
              binding: AddDoctorDetailsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.editDoctorDetailsScreen:
            return GetPageRoute(
              routeName: Routes.editDoctorDetailsScreen,
              page: () => const EditDoctorDetailsView(),
              binding: EditDoctorDetailsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
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
