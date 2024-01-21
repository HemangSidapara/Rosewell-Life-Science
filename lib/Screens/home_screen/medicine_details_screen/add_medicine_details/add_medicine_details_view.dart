// ignore_for_file: non_constant_identifier_names
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
import 'package:rosewell_life_science/Widgets/button_widget.dart';
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
      bottomSheet: context.isPortrait ? AddMedicineButton() : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeaderWidget(
            title: AppStrings.addMedicine.tr,
            titleIcon: AppAssets.addMedicineDetailsIcon,
            onBackPressed: () {
              if (Get.keys[1]?.currentState?.canPop() == true) {
                Get.back(id: 1, closeOverlays: true);
              }
            },
          ),
          SizedBox(height: 3.h),
          if (context.isPortrait)
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: addMedicineDetailsController.addMedicineFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Medicine Name
                      TextFieldWidget(
                        controller: addMedicineDetailsController.medicineNameController,
                        title: AppStrings.medicineName.tr,
                        hintText: AppStrings.enterMedicineName.tr,
                        validator: addMedicineDetailsController.validateMedicineName,
                        maxLength: 50,
                      ),
                      SizedBox(height: 2.h),

                      ///upload Images
                      UploadImageView(),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: addMedicineDetailsController.addMedicineFormKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Medicine Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Medicine Name
                          TextFieldWidget(
                            controller: addMedicineDetailsController.medicineNameController,
                            title: AppStrings.medicineName.tr,
                            hintText: AppStrings.enterMedicineName.tr,
                            validator: addMedicineDetailsController.validateMedicineName,
                            textFieldWidth: 43.w,
                            maxLength: 50,
                          ),
                          SizedBox(height: 2.w),

                          ///Add Medicine Button
                          AddMedicineButton(),
                        ],
                      ),

                      ///Upload Images
                      UploadImageView(),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget UploadImageView() {
    return Column(
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
        Obx(() {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: DottedBorder(
              color: addMedicineDetailsController.isValidate.isTrue ? AppColors.PRIMARY_COLOR : AppColors.ERROR_COLOR,
              strokeWidth: 2.5,
              strokeCap: StrokeCap.butt,
              dashPattern: const [12, 8],
              child: Obx(() {
                return InkWell(
                  onTap: addMedicineDetailsController.pickedImageList.isEmpty
                      ? () async {
                          addMedicineDetailsController.pickedImageList.addAll(await ImagePickerService().pickMultiImage());
                          addMedicineDetailsController.isValidate.value = addMedicineDetailsController.pickedImageList.isNotEmpty;
                        }
                      : null,
                  child: Obx(() {
                    return Container(
                      width: context.isPortrait ? double.maxFinite : 43.w,
                      height: context.isPortrait
                          ? addMedicineDetailsController.pickedImageList.isEmpty
                              ? 12.h
                              : 51.h
                          : addMedicineDetailsController.pickedImageList.isEmpty
                              ? 12.w
                              : 51.w,
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
                              size: context.isPortrait ? 7.w : 6.h,
                            ),
                            Text(
                              AppStrings.chooseImagesFromYourDevice.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.PRIMARY_COLOR,
                                fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        secondChild: Container(
                          width: double.maxFinite,
                          height: context.isPortrait ? 51.h : 51.w,
                          color: AppColors.LIGHT_SECONDARY_COLOR.withOpacity(0.5),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Flexible(
                                child: GridView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 2.w : 2.h, vertical: context.isPortrait ? 1.h : 1.w),
                                  itemCount: addMedicineDetailsController.pickedImageList.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: context.isPortrait ? 1 : 1.12,
                                    crossAxisSpacing: context.isPortrait ? 2.w : 2.h,
                                    mainAxisSpacing: context.isPortrait ? 1.h : 1.w,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        Center(
                                          child: Image.file(
                                            File(
                                              addMedicineDetailsController.pickedImageList[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            height: context.isPortrait ? 6.w : 5.5.h,
                                            width: context.isPortrait ? 6.w : 5.5.h,
                                            child: IconButton(
                                              onPressed: () {
                                                addMedicineDetailsController.pickedImageList.removeAt(index);
                                                addMedicineDetailsController.isValidate.value = addMedicineDetailsController.pickedImageList.isNotEmpty;
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
                                                size: context.isPortrait ? 4.w : 3.5.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                color: AppColors.PRIMARY_COLOR.withOpacity(0.5),
                                thickness: 1.5,
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
                                          size: context.isPortrait ? 7.w : 6.h,
                                        ),
                                        Text(
                                          AppStrings.addMoreImages.tr,
                                          style: TextStyle(
                                            color: AppColors.PRIMARY_COLOR,
                                            fontSize: context.isPortrait ? 12.sp : 6.5.sp,
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
          );
        }),
        if (mounted)
          Obx(() {
            if (addMedicineDetailsController.isValidate.isFalse) {
              return Padding(
                padding: EdgeInsets.only(left: context.isPortrait ? 2.5.w : 1.5.w, top: context.isPortrait ? 0.6.h : 0.6.w),
                child: Text(
                  AppStrings.pleaseChooseImages.tr,
                  style: TextStyle(
                    color: AppColors.ERROR_COLOR,
                    fontSize: context.isPortrait ? 10.sp : 5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
      ],
    );
  }

  Widget AddMedicineButton() {
    return Obx(() {
      return ButtonWidget(
        onPressed: () async {
          await addMedicineDetailsController.checkAddMedicine();
        },
        isLoading: addMedicineDetailsController.isAddMedicineLoading.value,
        fixedSize: context.isPortrait ? Size(double.maxFinite, 5.h) : Size(43.w, 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              size: context.isPortrait ? 5.w : 4.5.h,
              color: AppColors.WHITE_COLOR,
            ),
            SizedBox(width: context.isPortrait ? 1.w : 1.h),
            Text(
              AppStrings.add.tr,
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
