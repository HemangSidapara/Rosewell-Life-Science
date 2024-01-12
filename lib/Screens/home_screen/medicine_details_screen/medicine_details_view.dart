import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/medicine_details_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';

class MedicineDetailsView extends StatefulWidget {
  const MedicineDetailsView({super.key});

  @override
  State<MedicineDetailsView> createState() => _MedicineDetailsViewState();
}

class _MedicineDetailsViewState extends State<MedicineDetailsView> {
  MedicineDetailsController medicineDetailsController = Get.find<MedicineDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header
          CustomHeaderWidget(
            title: AppStrings.medicineDetails.tr,
            titleIcon: AppAssets.medicineDetailsIcon,
            titleIconSize: context.isPortrait ? 7.w : 7.h,
          ),
          SizedBox(height: 5.h),

          Flexible(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(vertical: context.isPortrait ? 2.h : 2.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.isPortrait ? 1 : 2,
                mainAxisSpacing: context.isPortrait ? 2.h : 2.w,
                childAspectRatio: context.isPortrait ? 4 : 2.8,
                crossAxisSpacing: context.isPortrait ? 2.h : 4.w,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    if (index == 0) {
                      Get.toNamed(Routes.addMedicineDetailsScreen, id: 1);
                    } else if (index == 1) {
                      Get.toNamed(Routes.editMedicineDetailsScreen, id: 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 2.h : 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (context.isPortrait)
                            SizedBox(
                              width: 65.w,
                              child: Row(
                                children: [
                                  Image.asset(
                                    medicineDetailsController.contentIconList[index],
                                    width: 14.w,
                                  ),
                                  SizedBox(width: 3.w),
                                  Flexible(
                                    child: Text(
                                      medicineDetailsController.contentList[index],
                                      style: TextStyle(
                                        color: AppColors.SECONDARY_COLOR,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (context.isLandscape) ...[
                            Flexible(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  medicineDetailsController.contentList[index],
                                  style: TextStyle(
                                    color: AppColors.SECONDARY_COLOR,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 6.5.sp,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                medicineDetailsController.contentIconList[index],
                                width: 14.h,
                              ),
                            ),
                          ],
                          if (context.isPortrait)
                            Image.asset(
                              AppAssets.frontIcon,
                              color: AppColors.SECONDARY_COLOR,
                              width: context.isPortrait ? 9.w : 8.h,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
