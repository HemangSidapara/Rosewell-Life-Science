import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/presentation_for_doctors_screen/presentation_for_doctors_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';
import 'package:rosewell_life_science/Widgets/loading_widget.dart';
import 'package:rosewell_life_science/Widgets/textfield_widget.dart';

class PresentationForDoctorsView extends StatefulWidget {
  const PresentationForDoctorsView({super.key});

  @override
  State<PresentationForDoctorsView> createState() => _PresentationForDoctorsViewState();
}

class _PresentationForDoctorsViewState extends State<PresentationForDoctorsView> with TickerProviderStateMixin {
  PresentationForDoctorsController presentationForDoctorsController = Get.find<PresentationForDoctorsController>();

  @override
  void initState() {
    super.initState();
    presentationForDoctorsController.searchDoctorController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isPadded: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomHeaderWidget(
                title: AppStrings.presentation.tr,
                titleIcon: AppAssets.doctorListPresentationIcon,
                onBackPressed: () {
                  if (Get.keys[0]?.currentState?.canPop() == true) {
                    Get.back(id: 0);
                  }
                },
              ),

              Row(
                children: [
                  ///Export Doctors
                  IconButton(
                    onPressed: () {
                      presentationForDoctorsController.exportDoctorsToExcelApi();
                    },
                    style: IconButton.styleFrom(
                      maximumSize: Size.square(
                        context.isPortrait ? 8.w : 8.h,
                      ),
                      minimumSize: Size.square(
                        context.isPortrait ? 8.w : 8.h,
                      ),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: AppColors.SECONDARY_COLOR,
                    ),
                    icon: Obx(() {
                      if (presentationForDoctorsController.isExportLoading.isTrue) {
                        return SizedBox.square(
                          dimension: context.isPortrait ? 4.w : 4.h,
                          child: CircularProgressIndicator(
                            color: AppColors.WHITE_COLOR,
                            strokeWidth: 2,
                          ),
                        );
                      } else {
                        return FaIcon(
                          FontAwesomeIcons.fileExcel,
                          size: context.isPortrait ? 4.w : 4.h,
                          color: AppColors.WHITE_COLOR,
                        );
                      }
                    }),
                  ),
                  SizedBox(width: context.isPortrait ? 1.w : 1.h),

                  /// Refresh
                  Padding(
                    padding: EdgeInsets.only(right: context.isPortrait ? 2.w : 2.h),
                    child: IconButton(
                      onPressed: presentationForDoctorsController.isRefreshing.value
                          ? () {}
                          : () async {
                              await presentationForDoctorsController.getDoctorApiCall(isLoading: false);
                            },
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                      ),
                      icon: Obx(() {
                        return TweenAnimationBuilder(
                          duration: Duration(seconds: presentationForDoctorsController.isRefreshing.value ? 45 : 1),
                          tween: Tween(begin: 0.0, end: presentationForDoctorsController.isRefreshing.value ? 45.0 : presentationForDoctorsController.ceilValueForRefresh.value),
                          onEnd: () {
                            presentationForDoctorsController.isRefreshing.value = false;
                          },
                          builder: (context, value, child) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              presentationForDoctorsController.ceilValueForRefresh(value.toDouble().ceilToDouble());
                            });
                            return Transform.rotate(
                              angle: value * 2 * 3.141592653589793,
                              child: Icon(
                                Icons.refresh_rounded,
                                color: AppColors.SECONDARY_COLOR,
                                size: context.isPortrait ? 6.w : 6.h,
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.isPortrait ? 2.h : 2.w),

          ///Search bar
          TextFieldWidget(
            controller: presentationForDoctorsController.searchDoctorController,
            hintText: AppStrings.searchDoctor.tr,
            textFieldWidth: context.isPortrait ? null : 43.w,
            suffixIcon: presentationForDoctorsController.searchDoctorController.text.isNotEmpty
                ? InkWell(
                    onTap: () async {
                      presentationForDoctorsController.searchDoctorController.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                      await getSearchedDoctorList(searchedValue: presentationForDoctorsController.searchDoctorController.text);
                    },
                    child: Icon(
                      Icons.close,
                      color: AppColors.SECONDARY_COLOR,
                      size: context.isPortrait ? 4.w : 4.h,
                    ),
                  )
                : null,
            suffixIconConstraints: BoxConstraints(minWidth: context.isPortrait ? 10.w : 10.h, maxWidth: context.isPortrait ? 10.w : 10.h),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.SECONDARY_COLOR,
              size: context.isPortrait ? 4.w : 4.h,
            ),
            prefixIconConstraints: BoxConstraints(minWidth: context.isPortrait ? 10.w : 10.h, maxWidth: context.isPortrait ? 10.w : 10.h),
            onChanged: (value) async {
              await getSearchedDoctorList(searchedValue: value);
            },
          ),
          SizedBox(height: context.isPortrait ? 1.h : 1.w),

          ///Doctor List
          Expanded(
            child: Obx(() {
              if (presentationForDoctorsController.isGetDoctorLoading.value) {
                return const LoadingWidget();
              } else {
                return Row(
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: context.isPortrait ? null : 43.w,
                        child: Obx(() {
                          if (presentationForDoctorsController.searchedDoctorDataList.isEmpty) {
                            return Center(
                              child: Text(
                                AppStrings.noDataFound.tr,
                                style: TextStyle(
                                  color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          } else {
                            return ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: context.isPortrait ? 2.h : 2.w),
                              itemCount: presentationForDoctorsController.searchedDoctorDataList.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  controller: presentationForDoctorsController.searchedExpansionTileControllerList[index],
                                  dense: true,
                                  tilePadding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 2.w : 2.h),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: context.isPortrait ? 60.w : 50.h,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${index + 1}. ',
                                              style: TextStyle(
                                                color: AppColors.PRIMARY_COLOR,
                                                fontWeight: FontWeight.w600,
                                                fontSize: context.isPortrait ? 12.sp : 6.sp,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                presentationForDoctorsController.searchedDoctorDataList[index].name ?? '',
                                                style: TextStyle(
                                                  color: AppColors.PRIMARY_COLOR,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: context.isPortrait ? 12.sp : 6.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///View
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed(Routes.productImagePresentationScreen, arguments: presentationForDoctorsController.searchedDoctorDataList[index].doctorMeta?.map((e) => e).toList());
                                        },
                                        style: IconButton.styleFrom(
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          padding: EdgeInsets.zero,
                                        ),
                                        icon: Icon(
                                          Icons.remove_red_eye_rounded,
                                          color: AppColors.SECONDARY_COLOR,
                                          size: context.isLandscape ? 4.h : 4.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                  iconColor: AppColors.SECONDARY_COLOR,
                                  onExpansionChanged: (value) {
                                    if (value) {
                                      for (int i = 0; i < presentationForDoctorsController.searchedExpansionTileControllerList.length; i++) {
                                        try {
                                          if (i != index) {
                                            presentationForDoctorsController.searchedExpansionTileControllerList[i].collapse();
                                          } else {
                                            presentationForDoctorsController.expandedIndex(index);
                                          }
                                        } catch (e) {
                                          log(e.toString());
                                        }
                                      }
                                    }
                                    setState(() {});
                                  },
                                  collapsedIconColor: AppColors.SECONDARY_COLOR,
                                  collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                  trailing: const SizedBox(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: AppColors.SECONDARY_COLOR.withValues(alpha: 0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                  childrenPadding: context.isPortrait ? EdgeInsets.only(bottom: 2.h) : null,
                                  children: context.isPortrait
                                      ? [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                                            child: Divider(
                                              color: AppColors.PRIMARY_COLOR,
                                              thickness: 1,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),

                                          ///Image List in Portrait
                                          ConstrainedBox(
                                            constraints: BoxConstraints(maxHeight: 50.h),
                                            child: CustomScrollView(
                                              shrinkWrap: true,
                                              slivers: [
                                                for (int i = 0; i < (presentationForDoctorsController.searchedDoctorDataList[index].doctorMeta?.length ?? 0); i++) ...[
                                                  SliverToBoxAdapter(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '${i + 1}. ',
                                                            style: TextStyle(
                                                              color: AppColors.PRIMARY_COLOR,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                          Text(
                                                            presentationForDoctorsController.searchedDoctorDataList[index].doctorMeta?[i].name ?? '',
                                                            style: TextStyle(
                                                              color: AppColors.PRIMARY_COLOR,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  ///Images
                                                  SliverToBoxAdapter(
                                                    child: SizedBox(
                                                      height: 22.h,
                                                      child: ListView.builder(
                                                        itemCount: presentationForDoctorsController.searchedDoctorDataList[index].doctorMeta?[i].productMeta?.length ?? 0,
                                                        scrollDirection: Axis.horizontal,
                                                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                        itemBuilder: (context, innerIndex) {
                                                          return Center(
                                                            child: CachedNetworkImage(
                                                              imageUrl: presentationForDoctorsController.searchedDoctorDataList[index].doctorMeta![i].productMeta?[innerIndex].image ?? '',
                                                              fit: BoxFit.cover,
                                                              height: 20.h,
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
                                                                return SizedBox(
                                                                  width: 13.h,
                                                                  child: Icon(
                                                                    Icons.error_rounded,
                                                                    color: AppColors.ERROR_COLOR,
                                                                    size: 6.w,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ]
                                      : [],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: context.isPortrait ? 2.h : 2.w);
                              },
                            );
                          }
                        }),
                      ),
                    ),

                    ///Image List in Landscape
                    if (context.isLandscape)
                      if (presentationForDoctorsController.searchedExpansionTileControllerList.any(
                        (element) {
                          try {
                            return element.isExpanded == true;
                          } catch (e) {
                            return false;
                          }
                        },
                      ))
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: CustomScrollView(
                              slivers: [
                                for (int i = 0; i < (presentationForDoctorsController.searchedDoctorDataList[presentationForDoctorsController.expandedIndex.value].doctorMeta?.length ?? 0); i++) ...[
                                  SliverToBoxAdapter(
                                    child: Row(
                                      children: [
                                        Text(
                                          '${i + 1}. ',
                                          style: TextStyle(
                                            color: AppColors.PRIMARY_COLOR,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 6.sp,
                                          ),
                                        ),
                                        Text(
                                          presentationForDoctorsController.searchedDoctorDataList[presentationForDoctorsController.expandedIndex.value].doctorMeta?[i].name ?? '',
                                          style: TextStyle(
                                            color: AppColors.PRIMARY_COLOR,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 6.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SliverPadding(
                                    padding: EdgeInsets.symmetric(vertical: 2.w),
                                    sliver: SliverGrid.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.12,
                                        crossAxisSpacing: 2.h,
                                        mainAxisSpacing: 1.w,
                                      ),
                                      itemCount: presentationForDoctorsController.searchedDoctorDataList[presentationForDoctorsController.expandedIndex.value].doctorMeta?[i].productMeta?.length ?? 0,
                                      itemBuilder: (context, innerIndex) {
                                        return Center(
                                          child: CachedNetworkImage(
                                            imageUrl: presentationForDoctorsController.searchedDoctorDataList[presentationForDoctorsController.expandedIndex.value].doctorMeta?[i].productMeta?[innerIndex].image ?? '',
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
                                                size: 5.h,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Future<void> getSearchedDoctorList({required String searchedValue}) async {
    presentationForDoctorsController.searchedDoctorDataList.clear();
    presentationForDoctorsController.searchedExpansionTileControllerList.clear();
    if (searchedValue != "") {
      presentationForDoctorsController.searchedExpansionTileControllerList = RxList.generate(
        presentationForDoctorsController.doctorDataList
            .where(
              (e) {
                return e.name?.contains(searchedValue) == true || e.name?.toLowerCase().contains(searchedValue) == true;
              },
            )
            .toList()
            .length,
        (index) => ExpansibleController(),
      );
      presentationForDoctorsController.searchedDoctorDataList.addAll(
        presentationForDoctorsController.doctorDataList.where(
          (e) {
            return e.name?.contains(searchedValue) == true || e.name?.toLowerCase().contains(searchedValue) == true;
          },
        ).toList(),
      );
    } else {
      presentationForDoctorsController.searchedDoctorDataList.addAll(presentationForDoctorsController.doctorDataList);
      presentationForDoctorsController.searchedExpansionTileControllerList = RxList.generate(presentationForDoctorsController.searchedDoctorDataList.length, (index) => ExpansibleController());
    }
  }
}
