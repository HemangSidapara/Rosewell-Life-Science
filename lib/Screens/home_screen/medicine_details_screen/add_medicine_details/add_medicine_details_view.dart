import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/add_medicine_details/add_medicine_details_controller.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';

class AddMedicineDetailsView extends StatefulWidget {
  const AddMedicineDetailsView({super.key});

  @override
  State<AddMedicineDetailsView> createState() => _AddMedicineDetailsViewState();
}

class _AddMedicineDetailsViewState extends State<AddMedicineDetailsView> {
  AddMedicineDetailsController addMedicineDetailsController = Get.find<AddMedicineDetailsController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isPadded: true,
      child: Column(
        children: [
          CustomHeaderWidget(
            title: AppStrings.addMedicine.tr,
            titleIcon: AppAssets.addMedicineDetailsIcon,
            onBackPressed: () {
              if (Get.keys[1]?.currentState?.canPop() == true) {
                Get.back(id: 1);
              }
            },
          ),
        ],
      ),
    );
  }
}
