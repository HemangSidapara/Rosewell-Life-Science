import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/models/medicine_details_models/get_medicine_model.dart';
import 'package:rosewell_life_science/Network/services/utils_service/image_picker_service.dart';
import 'package:rosewell_life_science/Screens/home_screen/medicine_details_screen/edit_medicine_details/edit_medicine_details_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';
import 'package:rosewell_life_science/Widgets/loading_widget.dart';
import 'package:rosewell_life_science/Widgets/textfield_widget.dart';

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
      bottomSheet: context.isPortrait ? EditMedicineButton() : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 3.h),
          if (context.isPortrait)
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: editMedicineDetailsController.editMedicineFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Medicine List
                      MedicineListView(),

                      ///Medicine Name
                      Obx(() {
                        return TextFieldWidget(
                          controller: editMedicineDetailsController.medicineNameController,
                          title: AppStrings.medicineName.tr,
                          hintText: AppStrings.enterMedicineName.tr,
                          validator: editMedicineDetailsController.validateMedicineName,
                          maxLength: 50,
                          readOnly: editMedicineDetailsController.selectedMedicine.value == -1,
                        );
                      }),
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
                  key: editMedicineDetailsController.editMedicineFormKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Medicine Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Medicine List
                          MedicineListView(),

                          ///Medicine Name
                          Obx(() {
                            return TextFieldWidget(
                              controller: editMedicineDetailsController.medicineNameController,
                              title: AppStrings.medicineName.tr,
                              hintText: AppStrings.enterMedicineName.tr,
                              validator: editMedicineDetailsController.validateMedicineName,
                              textFieldWidth: 43.w,
                              maxLength: 50,
                              readOnly: editMedicineDetailsController.selectedMedicine.value == -1,
                            );
                          }),
                          SizedBox(height: 2.w),

                          ///Add Medicine Button
                          EditMedicineButton(),
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

  // ignore_for_file: non_constant_identifier_names
  Widget MedicineListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.isPortrait ? null : 43.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: context.isPortrait ? 2.w : 1.w),
                child: Text(
                  AppStrings.listOfMedicine.tr,
                  style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: context.isPortrait ? 12.sp : 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  editMedicineDetailsController.editMedicineFormKey.currentState?.reset();
                  editMedicineDetailsController.selectedMedicine(-1);
                  editMedicineDetailsController.medicineNameController.clear();
                  editMedicineDetailsController.oldImageList.clear();
                  editMedicineDetailsController.pickedImageList.clear();
                  editMedicineDetailsController.isValidate(true);
                },
                child: Text(
                  AppStrings.reset.tr,
                  style: TextStyle(
                    color: AppColors.LIGHT_BLUE_COLOR,
                    fontWeight: FontWeight.w900,
                    fontSize: context.isPortrait ? 12.sp : 8.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          return SizedBox(
            width: context.isPortrait ? null : 43.w,
            height: editMedicineDetailsController.isValidate.isFalse && editMedicineDetailsController.selectedMedicine.value == -1
                ? context.isPortrait
                      ? 8.h
                      : 8.w
                : context.isPortrait
                ? 4.5.h
                : 4.5.w,
            child: Obx(() {
              return DropdownSearch<Data>(
                key: editMedicineDetailsController.dropdownKey,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                items: (filter, loadProps) async {
                  return editMedicineDetailsController.getMedicineApiCall(isLoading: false);
                },
                selectedItem: editMedicineDetailsController.selectedMedicine.value == -1 ? null : editMedicineDetailsController.medicineDataList[editMedicineDetailsController.selectedMedicine.value],
                suffixProps: DropdownSuffixProps(
                  dropdownButtonProps: DropdownButtonProps(
                    padding: EdgeInsets.zero,
                    iconClosed: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.SECONDARY_COLOR,
                      size: context.isPortrait ? 5.w : 5.h,
                    ),
                    iconOpened: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AppColors.SECONDARY_COLOR,
                      size: context.isPortrait ? 5.w : 5.h,
                    ),
                  ),
                ),

                validator: editMedicineDetailsController.validateMedicineList,
                decoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(
                    color: AppColors.SECONDARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: context.isPortrait ? 10.sp : 5.sp,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.WHITE_COLOR,
                    hintText: AppStrings.selectMedicine.tr,
                    hintStyle: TextStyle(
                      color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5),
                      fontSize: context.isPortrait ? 10.sp : 5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    errorStyle: TextStyle(
                      color: AppColors.ERROR_COLOR,
                      fontSize: context.isPortrait ? 10.sp : 5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.PRIMARY_COLOR,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.PRIMARY_COLOR,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.PRIMARY_COLOR,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.ERROR_COLOR,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.ERROR_COLOR,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 3.w : 3.h, vertical: context.isPortrait ? 0 : 0.8.w).copyWith(right: context.isPortrait ? 1.w : 1.h),
                  ),
                ),
                itemAsString: (item) {
                  return item.name ?? '';
                },
                popupProps: PopupProps.menu(
                  menuProps: MenuProps(
                    backgroundColor: AppColors.WHITE_COLOR,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  loadingBuilder: (context, searchEntry) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  },
                  emptyBuilder: (context, searchEntry) {
                    return Center(
                      child: Text(
                        AppStrings.noDataFound.tr,
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5),
                          fontSize: context.isPortrait ? 10.sp : 5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, item, isDisabled, isSelected) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              editMedicineDetailsController.editMedicineFormKey.currentState?.reset();
                              editMedicineDetailsController.selectedMedicine.value = editMedicineDetailsController.medicineDataList.indexWhere((element) => element.pId == item.pId);
                              editMedicineDetailsController.medicineNameController.text = item.name ?? '';
                              editMedicineDetailsController.oldImageList.clear();
                              editMedicineDetailsController.pickedImageList.clear();
                              editMedicineDetailsController.isValidate(true);
                              editMedicineDetailsController.oldImageList.addAll(editMedicineDetailsController.medicineDataList[editMedicineDetailsController.selectedMedicine.value].productMeta ?? []);
                            },
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 1.h : 1.w),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            ),
                            child: Text(
                              item.name?.tr ?? '',
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontSize: context.isPortrait ? 10.sp : 5.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 1.h : 1.w),
                            child: IconButton(
                              onPressed: editMedicineDetailsController.deletingPID.value == item.pId
                                  ? () {}
                                  : () async {
                                      final modelData = editMedicineDetailsController.medicineDataList.where((p0) => p0.pId == item.pId).toList();
                                      if (modelData.isNotEmpty) {
                                        editMedicineDetailsController.deletingPID(item.pId);
                                        await editMedicineDetailsController.deleteMedicineApiCall(pID: modelData.first.pId ?? '');
                                        if (editMedicineDetailsController.selectedMedicine.value == editMedicineDetailsController.medicineDataList.indexWhere((element) => element.pId == item.pId)) {
                                          editMedicineDetailsController.editMedicineFormKey.currentState?.reset();
                                          editMedicineDetailsController.selectedMedicine(-1);
                                          editMedicineDetailsController.medicineNameController.clear();
                                          editMedicineDetailsController.oldImageList.clear();
                                          editMedicineDetailsController.pickedImageList.clear();
                                        }
                                        editMedicineDetailsController.deletingPID('');
                                      }
                                    },
                              icon: editMedicineDetailsController.deletingPID.value == item.pId
                                  ? Center(
                                      child: SizedBox(
                                        height: context.isPortrait ? 5.w : 5.h,
                                        width: context.isPortrait ? 5.w : 5.h,
                                        child: CircularProgressIndicator(
                                          color: AppColors.SECONDARY_COLOR,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.delete_forever_rounded,
                                      color: AppColors.ERROR_COLOR,
                                      size: context.isPortrait ? 5.w : 5.h,
                                    ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                  interceptCallBacks: true,
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    cursorColor: AppColors.PRIMARY_COLOR,
                    style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontWeight: FontWeight.w600,
                      fontSize: context.isPortrait ? 10.sp : 5.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: AppStrings.searchMedicine.tr,
                      hintStyle: TextStyle(
                        color: AppColors.HINT_GREY_COLOR,
                        fontSize: context.isPortrait ? 10.sp : 5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppColors.PRIMARY_COLOR),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1, color: AppColors.PRIMARY_COLOR),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 4.w : 4.h, vertical: context.isPortrait ? 1.2.h : 1.2.w),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
        SizedBox(height: context.isPortrait ? 2.h : 1.w),
      ],
    );
  }

  Widget UploadImageView() {
    return Obx(() {
      return IgnorePointer(
        ignoring: editMedicineDetailsController.selectedMedicine.value == -1,
        child: Column(
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
                  options: CircularDottedBorderOptions(
                    color: editMedicineDetailsController.isValidate.isTrue ? AppColors.PRIMARY_COLOR : AppColors.ERROR_COLOR,
                    strokeWidth: 2.5,
                    strokeCap: StrokeCap.butt,
                    dashPattern: const [12, 8],
                  ),
                  child: Obx(() {
                    return InkWell(
                      onTap: editMedicineDetailsController.oldImageList.isEmpty && editMedicineDetailsController.pickedImageList.isEmpty
                          ? () async {
                              editMedicineDetailsController.pickedImageList.addAll(await ImagePickerService().pickMultiImage());
                              editMedicineDetailsController.isValidate.value = editMedicineDetailsController.pickedImageList.isNotEmpty;
                            }
                          : null,
                      child: Obx(() {
                        return Container(
                          width: context.isPortrait ? double.maxFinite : 43.w,
                          height: context.isPortrait
                              ? editMedicineDetailsController.oldImageList.isEmpty && editMedicineDetailsController.pickedImageList.isEmpty
                                    ? 12.h
                                    : 51.h
                              : editMedicineDetailsController.oldImageList.isEmpty && editMedicineDetailsController.pickedImageList.isEmpty
                              ? 12.w
                              : 51.w,
                          color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.5),
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
                              color: AppColors.LIGHT_SECONDARY_COLOR.withValues(alpha: 0.5),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: GridView.builder(
                                      padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 2.w : 2.h, vertical: context.isPortrait ? 1.h : 1.w),
                                      itemCount: editMedicineDetailsController.oldImageList.length + editMedicineDetailsController.pickedImageList.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: context.isPortrait ? 1 : 1.12,
                                        crossAxisSpacing: context.isPortrait ? 2.w : 2.h,
                                        mainAxisSpacing: context.isPortrait ? 1.h : 1.w,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            if (index < editMedicineDetailsController.oldImageList.length)
                                              Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: editMedicineDetailsController.oldImageList[index].image ?? '',
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context, url, downloadProgress) {
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                        value: downloadProgress.progress,
                                                        color: AppColors.SECONDARY_COLOR,
                                                        strokeWidth: 2,
                                                      ),
                                                    );
                                                  },
                                                  errorWidget: (context, url, error) {
                                                    return Icon(
                                                      Icons.error_rounded,
                                                      color: AppColors.ERROR_COLOR,
                                                      size: context.isPortrait ? 5.h : 5.w,
                                                    );
                                                  },
                                                ),
                                              )
                                            else
                                              Center(
                                                child: Image.file(
                                                  File(
                                                    editMedicineDetailsController.pickedImageList[index - editMedicineDetailsController.oldImageList.length],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: SizedBox(
                                                height: context.isPortrait ? 6.w : 4.5.h,
                                                width: context.isPortrait ? 6.w : 4.5.h,
                                                child: IconButton(
                                                  onPressed: () {
                                                    if (index < editMedicineDetailsController.oldImageList.length && editMedicineDetailsController.oldImageList.isNotEmpty) {
                                                      editMedicineDetailsController.oldImageList.removeAt(index);
                                                    } else {
                                                      editMedicineDetailsController.pickedImageList.removeAt(index);
                                                    }
                                                    editMedicineDetailsController.isValidate.value = editMedicineDetailsController.oldImageList.isNotEmpty || editMedicineDetailsController.pickedImageList.isNotEmpty;
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
                                                    size: context.isPortrait ? 4.w : 3.h,
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
                                    color: AppColors.PRIMARY_COLOR.withValues(alpha: 0.5),
                                    thickness: 1.5,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      editMedicineDetailsController.pickedImageList.addAll(await ImagePickerService().pickMultiImage());
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
                            crossFadeState: editMedicineDetailsController.oldImageList.isEmpty && editMedicineDetailsController.pickedImageList.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                if (editMedicineDetailsController.isValidate.isFalse) {
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
            SizedBox(height: context.isPortrait ? 4.h : 4.w),
          ],
        ),
      );
    });
  }

  Widget EditMedicineButton() {
    return Obx(() {
      return ButtonWidget(
        onPressed: () async {
          await editMedicineDetailsController.checkEditMedicine();
        },
        isLoading: editMedicineDetailsController.isEditMedicineLoading.value,
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
