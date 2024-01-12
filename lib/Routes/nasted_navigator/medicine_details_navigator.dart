import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/add_medicine_details/add_medicine_details_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/add_medicine_details/add_medicine_details_view.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/edit_medicine_details/edit_medicine_details_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/edit_medicine_details/edit_medicine_details_view.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/medicine_details_binding.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/medicine_details_view.dart';

class MedicineDetailsNavigator extends StatelessWidget {
  const MedicineDetailsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(1),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.addMedicineDetailsScreen:
            return GetPageRoute(
              routeName: Routes.addMedicineDetailsScreen,
              page: () => const AddMedicineDetailsView(),
              binding: AddMedicineDetailsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          case Routes.editMedicineDetailsScreen:
            return GetPageRoute(
              routeName: Routes.editMedicineDetailsScreen,
              page: () => const EditMedicineDetailsView(),
              binding: EditMedicineDetailsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
          default:
            return GetPageRoute(
              routeName: Routes.medicineDetailsScreen,
              page: () => const MedicineDetailsView(),
              binding: MedicineDetailsBinding(),
              transition: Transition.rightToLeftWithFade,
              transitionDuration: transitionDuration,
            );
        }
      },
    );
  }
}
