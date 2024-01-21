// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/edit_doctor_details_screen/edit_doctor_details_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';

class EditDoctorDetailsView extends StatefulWidget {
  const EditDoctorDetailsView({super.key});

  @override
  State<EditDoctorDetailsView> createState() => _EditDoctorDetailsViewState();
}

class _EditDoctorDetailsViewState extends State<EditDoctorDetailsView> {
  EditDoctorDetailsController editDoctorDetailsController = Get.find<EditDoctorDetailsController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isPadded: true,
      bottomSheet: context.isPortrait ? EditDoctorButton() : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeaderWidget(
            title: AppStrings.editDoctor.tr,
            titleIcon: AppAssets.editDoctorDetailsIcon,
            onBackPressed: () {
              if (Get.keys[0]?.currentState?.canPop() == true) {
                Get.back(id: 0);
              }
            },
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  Widget EditDoctorButton() {
    return Obx(() {
      return ButtonWidget(
        onPressed: () async {},
        isLoading: editDoctorDetailsController.isEditMedicineLoading.value,
        fixedSize: context.isPortrait ? Size(double.maxFinite, 5.h) : Size(43.w, 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_rounded,
              size: context.isPortrait ? 5.w : 4.5.h,
              color: AppColors.WHITE_COLOR,
            ),
            SizedBox(width: context.isPortrait ? 1.w : 1.h),
            Text(
              AppStrings.edit.tr,
              style: TextStyle(
                color: AppColors.WHITE_COLOR,
                fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
