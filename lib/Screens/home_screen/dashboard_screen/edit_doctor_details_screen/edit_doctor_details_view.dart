// ignore_for_file: non_constant_identifier_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/models/doctor_details_model/get_doctor_model.dart' as get_doctor;
import 'package:rosewell_life_science/Network/models/medicine_details_models/get_medicine_model.dart' as get_medicine;
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/edit_doctor_details_screen/edit_doctor_details_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';
import 'package:rosewell_life_science/Widgets/loading_widget.dart';
import 'package:rosewell_life_science/Widgets/textfield_widget.dart';

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
                Get.back(id: 0, closeOverlays: true);
              }
            },
          ),
          SizedBox(height: 3.h),
          if (context.isPortrait)
            Expanded(
              child: Form(
                key: editDoctorDetailsController.editDoctorFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Doctor List
                    DoctorListView(),

                    ///Doctor Name
                    Obx(() {
                      return TextFieldWidget(controller: editDoctorDetailsController.doctorNameController, title: AppStrings.doctorName.tr, hintText: AppStrings.enterDoctorName.tr, validator: editDoctorDetailsController.validateDoctorName, maxLength: 50, readOnly: editDoctorDetailsController.selectedDoctor.value == -1);
                    }),
                    SizedBox(height: 2.h),

                    ///Medicine List
                    MedicineListView(),
                    SizedBox(height: 3.h),

                    ///Medicine Details
                    MedicineDetailsView(),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: Form(
                key: editDoctorDetailsController.editDoctorFormKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Doctor Name & Medicine List
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Doctor List
                          DoctorListView(),

                          ///Doctor Name
                          Obx(() {
                            return TextFieldWidget(controller: editDoctorDetailsController.doctorNameController, title: AppStrings.doctorName.tr, hintText: AppStrings.enterDoctorName.tr, validator: editDoctorDetailsController.validateDoctorName, textFieldWidth: 43.w, maxLength: 50, readOnly: editDoctorDetailsController.selectedDoctor.value == -1);
                          }),
                          SizedBox(height: 1.w),

                          ///Medicine List
                          MedicineListView(),
                          SizedBox(height: 3.w),

                          ///Edit Doctor Button
                          EditDoctorButton(),
                        ],
                      ),
                    ),

                    ///Medicine Details
                    MedicineDetailsView(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget DoctorListView() {
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
                  AppStrings.listOfDoctors.tr,
                  style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: context.isPortrait ? 12.sp : 8.sp, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  editDoctorDetailsController.editDoctorFormKey.currentState?.reset();
                  editDoctorDetailsController.selectedDoctor(-1);
                  editDoctorDetailsController.doctorNameController.clear();
                  editDoctorDetailsController.selectedMedicineList.clear();
                  editDoctorDetailsController.pickedImageList.clear();
                  editDoctorDetailsController.isValidate(true);
                },
                child: Text(
                  AppStrings.reset.tr,
                  style: TextStyle(color: AppColors.LIGHT_BLUE_COLOR, fontWeight: FontWeight.w900, fontSize: context.isPortrait ? 12.sp : 8.sp),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          return SizedBox(
            width: context.isPortrait ? null : 43.w,
            height: editDoctorDetailsController.isValidate.isFalse && editDoctorDetailsController.selectedDoctor.value == -1
                ? context.isPortrait
                      ? 8.h
                      : 8.w
                : context.isPortrait
                ? 4.5.h
                : 4.5.w,
            child: Obx(() {
              return DropdownSearch<get_doctor.Data>(
                key: editDoctorDetailsController.doctorDropdownKey,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                items: (filter, loadProps) async {
                  editDoctorDetailsController.getMedicineApiCall(isLoading: false);
                  return editDoctorDetailsController.getDoctorsApiCall(isLoading: false);
                },
                selectedItem: editDoctorDetailsController.selectedDoctor.value == -1 ? null : editDoctorDetailsController.doctorDataList[editDoctorDetailsController.selectedDoctor.value],
                suffixProps: DropdownSuffixProps(
                  dropdownButtonProps: DropdownButtonProps(
                    padding: EdgeInsets.zero,
                    iconOpened: Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.SECONDARY_COLOR, size: context.isPortrait ? 5.w : 5.h),
                    iconClosed: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.SECONDARY_COLOR, size: context.isPortrait ? 5.w : 5.h),
                  ),
                ),
                validator: editDoctorDetailsController.validateDoctorList,
                decoratorProps: DropDownDecoratorProps(
                  baseStyle: TextStyle(color: AppColors.SECONDARY_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 10.sp : 5.sp),
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.WHITE_COLOR,
                    hintText: AppStrings.selectDoctor.tr,
                    hintStyle: TextStyle(color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5), fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
                    errorStyle: TextStyle(color: AppColors.ERROR_COLOR, fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.ERROR_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.ERROR_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 3.w : 3.h, vertical: context.isPortrait ? 0 : 0.8.w).copyWith(right: context.isPortrait ? 1.w : 1.h),
                  ),
                ),
                compareFn: (item1, item2) {
                  return item1.dId == item2.dId;
                },
                itemAsString: (item) {
                  return item.name ?? '';
                },
                popupProps: PopupProps.menu(
                  menuProps: MenuProps(backgroundColor: AppColors.WHITE_COLOR, borderRadius: BorderRadius.circular(12)),
                  loadingBuilder: (context, searchEntry) {
                    return const Center(child: LoadingWidget());
                  },
                  emptyBuilder: (context, searchEntry) {
                    return Center(
                      child: Text(
                        AppStrings.noDataFound.tr,
                        style: TextStyle(color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5), fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
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
                              editDoctorDetailsController.editDoctorFormKey.currentState?.reset();
                              editDoctorDetailsController.selectedDoctor.value = editDoctorDetailsController.doctorDataList.indexWhere((element) => element.dId == item.dId);
                              editDoctorDetailsController.doctorNameController.text = item.name ?? '';
                              editDoctorDetailsController.selectedMedicineList.clear();
                              editDoctorDetailsController.selectedMedicineList.addAll(
                                editDoctorDetailsController.medicineDataList.where((p0) {
                                  return editDoctorDetailsController.doctorDataList[editDoctorDetailsController.selectedDoctor.value].doctorMeta?.any((element) => element.productMeta?[0].pId == p0.pId) == true;
                                }),
                              );
                              editDoctorDetailsController.isValidate(true);
                            },
                            style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 1.h : 1.w),
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            ),
                            child: Text(
                              item.name?.tr ?? '',
                              style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 1.h : 1.w),
                            child: IconButton(
                              onPressed: editDoctorDetailsController.deletingDID.value == item.dId
                                  ? () {}
                                  : () async {
                                      final modelData = editDoctorDetailsController.doctorDataList.where((p0) => p0.dId == item.dId).toList();
                                      if (modelData.isNotEmpty) {
                                        editDoctorDetailsController.deletingDID(item.dId);
                                        await editDoctorDetailsController.deleteDoctorApiCall(dID: modelData.first.dId ?? '');
                                        if (editDoctorDetailsController.selectedDoctor.value == editDoctorDetailsController.doctorDataList.indexWhere((element) => element.dId == item.dId)) {
                                          editDoctorDetailsController.editDoctorFormKey.currentState?.reset();
                                          editDoctorDetailsController.selectedDoctor(-1);
                                          editDoctorDetailsController.doctorNameController.clear();
                                          editDoctorDetailsController.selectedMedicineList.clear();
                                        }
                                        editDoctorDetailsController.deletingDID('');
                                      }
                                    },
                              icon: editDoctorDetailsController.deletingDID.value == item.dId
                                  ? Center(
                                      child: SizedBox(
                                        height: context.isPortrait ? 5.w : 5.h,
                                        width: context.isPortrait ? 5.w : 5.h,
                                        child: CircularProgressIndicator(color: AppColors.SECONDARY_COLOR),
                                      ),
                                    )
                                  : Icon(Icons.delete_forever_rounded, color: AppColors.ERROR_COLOR, size: context.isPortrait ? 5.w : 5.h),
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
                    style: TextStyle(color: AppColors.SECONDARY_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 10.sp : 5.sp),
                    decoration: InputDecoration(
                      hintText: AppStrings.searchDoctor.tr,
                      hintStyle: TextStyle(color: AppColors.HINT_GREY_COLOR, fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: AppColors.PRIMARY_COLOR)),
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

  Widget MedicineDetailsView() {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return Expanded(
      child: Obx(() {
        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            if (editDoctorDetailsController.selectedMedicineList.isEmpty)
              SliverToBoxAdapter(
                child: SizedBox(
                  width: context.isPortrait ? null : 43.w,
                  height: keyboardPadding != 0 ? 5.h : 40.h,
                  child: Center(
                    child: Text(
                      AppStrings.noMedicineHasBeenSelected.tr,
                      style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: context.isPortrait ? 12.sp : 5.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            else
              for (int i = 0; i < editDoctorDetailsController.selectedMedicineList.length; i++) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 2.w : 5.w, vertical: context.isPortrait ? 2.h : 2.w),
                    child: Row(
                      children: [
                        Text(
                          '${i + 1}. ',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 12.sp : 5.sp),
                        ),
                        Text(
                          editDoctorDetailsController.selectedMedicineList[i].name ?? '',
                          style: TextStyle(color: AppColors.PRIMARY_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 12.sp : 5.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 0 : 5.h),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: context.isPortrait ? 1 : 1.12, crossAxisSpacing: context.isPortrait ? 2.w : 2.h, mainAxisSpacing: context.isPortrait ? 1.h : 1.w),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Center(
                        child: CachedNetworkImage(
                          imageUrl: editDoctorDetailsController.selectedMedicineList[i].productMeta?[index].image ?? '',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) {
                            return Center(
                              child: CircularProgressIndicator(value: downloadProgress.progress, color: AppColors.SECONDARY_COLOR, strokeWidth: 2),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error_rounded, color: AppColors.ERROR_COLOR, size: context.isPortrait ? 5.h : 5.w);
                          },
                        ),
                      );
                    }, childCount: editDoctorDetailsController.selectedMedicineList[i].productMeta?.length ?? 0),
                  ),
                ),
              ],
            if (context.isPortrait) SliverToBoxAdapter(child: SizedBox(height: 7.h)),
          ],
        );
      }),
    );
  }

  Widget MedicineListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.isPortrait ? 2.w : 1.w),
          child: Text(
            AppStrings.listOfMedicine.tr,
            style: TextStyle(color: AppColors.PRIMARY_COLOR, fontSize: context.isPortrait ? 12.sp : 8.sp, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 1.h),
        Obx(() {
          return SizedBox(
            width: context.isPortrait ? null : 43.w,
            height: editDoctorDetailsController.isValidate.isFalse && editDoctorDetailsController.selectedMedicineList.isEmpty
                ? context.isPortrait
                      ? 8.h
                      : 8.w
                : context.isPortrait
                ? 4.5.h
                : 5.w,
            child: DropdownSearch<get_medicine.Data>.multiSelection(
              key: editDoctorDetailsController.medicineDropdownKey,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              items: (filter, loadProps) async {
                return editDoctorDetailsController.getMedicineApiCall(isLoading: false);
              },
              suffixProps: DropdownSuffixProps(
                dropdownButtonProps: DropdownButtonProps(
                  constraints: BoxConstraints.loose(Size(7.w, 4.5.h)),
                  padding: EdgeInsets.zero,
                  iconOpened: Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.SECONDARY_COLOR, size: context.isPortrait ? 5.w : 5.h),
                  iconClosed: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.SECONDARY_COLOR, size: context.isPortrait ? 5.w : 5.h),
                ),
              ),
              validator: editDoctorDetailsController.validateMedicineList,
              decoratorProps: DropDownDecoratorProps(
                baseStyle: TextStyle(color: AppColors.SECONDARY_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 10.sp : 5.sp),
                decoration: InputDecoration(
                  filled: true,
                  enabled: true,
                  fillColor: AppColors.WHITE_COLOR,
                  hintStyle: TextStyle(color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5), fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
                  errorStyle: TextStyle(color: AppColors.ERROR_COLOR, fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PRIMARY_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.ERROR_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.ERROR_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 3.w : 3.h, vertical: context.isPortrait ? 0 : 0.8.w).copyWith(right: context.isPortrait ? 1.w : 1.h),
                ),
              ),
              compareFn: (item1, item2) {
                return item1.pId == item2.pId;
              },
              popupProps: PopupPropsMultiSelection.menu(
                menuProps: MenuProps(backgroundColor: AppColors.WHITE_COLOR, borderRadius: BorderRadius.circular(12)),
                validationBuilder: (context, item) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 1.h : 1.w),
                    child: ButtonWidget(
                      fixedSize: Size(double.maxFinite, context.isPortrait ? 5.h : 5.w),
                      onPressed: () {
                        setState(() {
                          editDoctorDetailsController.selectedMedicineList.clear();
                          editDoctorDetailsController.selectedMedicineList.addAll(item);
                        });
                        Navigator.of(context).pop();
                      },
                      buttonTitle: AppStrings.select.tr,
                    ),
                  );
                },
                itemBuilder: (context, item, isDisabled, isSelected) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 2.h : 2.w),
                    child: Text(
                      item.name ?? '',
                      style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w500),
                    ),
                  );
                },
                showSelectedItems: true,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  cursorColor: AppColors.PRIMARY_COLOR,
                  style: TextStyle(color: AppColors.SECONDARY_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 10.sp : 5.sp),
                  decoration: InputDecoration(
                    hintText: AppStrings.searchMedicine.tr,
                    hintStyle: TextStyle(color: AppColors.HINT_GREY_COLOR, fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1, color: AppColors.PRIMARY_COLOR)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 1, color: AppColors.PRIMARY_COLOR),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 4.w : 4.h, vertical: context.isPortrait ? 1.2.h : 1.2.w),
                  ),
                ),
                loadingBuilder: (context, searchEntry) {
                  return const Center(child: LoadingWidget());
                },
                emptyBuilder: (context, searchEntry) {
                  return Center(
                    child: Text(
                      AppStrings.noDataFound.tr,
                      style: TextStyle(color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5), fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                checkBoxBuilder: (context, item, isDisabled, isSelected) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(1.5),
                      margin: EdgeInsets.only(right: context.isPortrait ? 4.w : 4.h),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.PRIMARY_COLOR : AppColors.TRANSPARENT,
                        border: Border.all(color: AppColors.PRIMARY_COLOR, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, color: AppColors.WHITE_COLOR, size: context.isPortrait ? 4.3.w : 4.3.h),
                    ),
                  );
                },
              ),
              dropdownBuilder: (context, selectedItems) {
                selectedItems.clear();
                selectedItems.addAll(editDoctorDetailsController.selectedMedicineList);
                if (editDoctorDetailsController.selectedMedicineList.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    editDoctorDetailsController.isValidate(true);
                  });
                }
                if (selectedItems.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 0.3.h),
                    child: Text(
                      AppStrings.selectMedicine.tr,
                      style: TextStyle(color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5), fontSize: context.isPortrait ? 10.sp : 5.sp, fontWeight: FontWeight.w600),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      children: selectedItems.map((value) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedItems.removeWhere((element) {
                                    return element == value;
                                  });
                                  editDoctorDetailsController.selectedMedicineList.removeWhere((element) {
                                    return element.pId == value.pId;
                                  });
                                });
                              },
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: EdgeInsets.only(left: context.isPortrait ? 2.w : 2.h, right: context.isPortrait ? 3.w : 3.h, top: context.isPortrait ? 0.3.h : 0.3.w, bottom: context.isPortrait ? 0.3.h : 0.3.w),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.PRIMARY_COLOR),
                                      margin: EdgeInsets.only(right: context.isPortrait ? 2.5.w : 2.5.h),
                                      child: Text(
                                        value.name ?? '',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: AppColors.WHITE_COLOR, fontWeight: FontWeight.w600, fontSize: context.isPortrait ? 10.sp : 5.sp),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 2.5,
                                    right: context.isPortrait ? 1.5.w : 1.5.h,
                                    child: Container(
                                      decoration: BoxDecoration(color: AppColors.WHITE_COLOR, shape: BoxShape.circle),
                                      child: Container(
                                        decoration: BoxDecoration(color: AppColors.ERROR_COLOR.withValues(alpha: 0.8), shape: BoxShape.circle),
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(size: context.isPortrait ? 2.w : 2.h, Icons.close, color: AppColors.WHITE_COLOR),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              },
              selectedItems: editDoctorDetailsController.selectedMedicineList,
            ),
          );
        }),
      ],
    );
  }

  Widget EditDoctorButton() {
    return Obx(() {
      return ButtonWidget(
        onPressed: () async {
          await editDoctorDetailsController.checkEditDoctor();
        },
        isLoading: editDoctorDetailsController.isEditMedicineLoading.value,
        fixedSize: context.isPortrait ? Size(double.maxFinite, 5.h) : Size(43.w, 8.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_rounded, size: context.isPortrait ? 5.w : 4.5.h, color: AppColors.WHITE_COLOR),
            SizedBox(width: context.isPortrait ? 1.w : 1.h),
            Text(
              AppStrings.edit.tr,
              style: TextStyle(color: AppColors.WHITE_COLOR, fontSize: context.isPortrait ? 12.sp : 6.5.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    });
  }
}
