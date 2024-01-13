import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/services/utils_service/image_picker_service.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/add_medicine_details/add_medicine_details_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';
import 'package:rosewell_life_science/Widgets/textfield_widget.dart';

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
          SizedBox(height: 3.h),
          Form(
            key: addMedicineDetailsController.addMedicineFormKey,
            child: Column(
              children: [
                ///Medicine Name
                TextFieldWidget(
                  title: AppStrings.medicineName.tr,
                  hintText: AppStrings.enterMedicineName.tr,
                  validator: addMedicineDetailsController.validateMedicineName,
                ),
                SizedBox(height: 2.h),

                ///Upload Images
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: context.isPortrait ? 2.w : 1.w),
                      child: Text(
                        AppStrings.imagesOfMedicine.tr,
                        style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontSize: context.isPortrait ? 12.sp : 8.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DottedBorder(
                        color: AppColors.PRIMARY_COLOR,
                        strokeWidth: 2.5,
                        strokeCap: StrokeCap.butt,
                        dashPattern: const [12, 8],
                        child: Obx(() {
                          return InkWell(
                            onTap: addMedicineDetailsController.pickedImageList.isEmpty
                                ? () async {
                                    addMedicineDetailsController.pickedImageList.addAll(await ImagePickerService().pickMultiImage());
                                  }
                                : null,
                            child: Obx(() {
                              return Container(
                                width: double.maxFinite,
                                height: addMedicineDetailsController.pickedImageList.isEmpty ? 12.h : 51.h,
                                color: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: AnimatedCrossFade(
                                  firstChild: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.library_add_rounded,
                                        color: AppColors.PRIMARY_COLOR,
                                        size: 7.w,
                                      ),
                                      Text(
                                        AppStrings.chooseImagesFromYourDevice.tr,
                                        style: TextStyle(
                                          color: AppColors.PRIMARY_COLOR,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  secondChild: Container(
                                    width: double.maxFinite,
                                    height: 51.h,
                                    color: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.5),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: GridView.builder(
                                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                                            itemCount: addMedicineDetailsController.pickedImageList.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 2.w,
                                              mainAxisSpacing: 1.h,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: [
                                                  Image.file(
                                                    File(
                                                      addMedicineDetailsController.pickedImageList[index],
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child: SizedBox(
                                                      height: 6.w,
                                                      width: 6.w,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          addMedicineDetailsController.pickedImageList.removeAt(index);
                                                        },
                                                        style: IconButton.styleFrom(
                                                          backgroundColor: AppColors.ERROR_COLOR,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(99),
                                                          ),
                                                          padding: EdgeInsets.zero,
                                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                        ),
                                                        icon: Icon(
                                                          Icons.close_rounded,
                                                          color: AppColors.WHITE_COLOR,
                                                          size: 4.w,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            addMedicineDetailsController.pickedImageList.addAll(await ImagePickerService().pickMultiImage());
                                          },
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.h),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.library_add_rounded,
                                                    color: AppColors.PRIMARY_COLOR,
                                                    size: 7.w,
                                                  ),
                                                  Text(
                                                    AppStrings.addMoreImages.tr,
                                                    style: TextStyle(
                                                      color: AppColors.PRIMARY_COLOR,
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  crossFadeState: addMedicineDetailsController.pickedImageList.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
