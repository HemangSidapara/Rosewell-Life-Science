import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/edit_medicine_details/edit_medicine_details_controller.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';

class EditMedicineDetailsView extends StatefulWidget {
  const EditMedicineDetailsView({super.key});

  @override
  State<EditMedicineDetailsView> createState() => _EditMedicineDetailsViewState();
}

class _EditMedicineDetailsViewState extends State<EditMedicineDetailsView> {
  EditMedicineDetailsController editMedicineDetailsController = Get.find<EditMedicineDetailsController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isPadded: true,
      child: Column(
        children: [
          CustomHeaderWidget(
            title: AppStrings.editMedicine.tr,
            titleIcon: AppAssets.editMedicineDetailsIcon,
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
