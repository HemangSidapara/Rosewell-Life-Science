import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/presentation_for_doctors_screen/presentation_for_doctors_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';

class PresentationForDoctorsView extends StatefulWidget {
  const PresentationForDoctorsView({super.key});

  @override
  State<PresentationForDoctorsView> createState() => _PresentationForDoctorsViewState();
}

class _PresentationForDoctorsViewState extends State<PresentationForDoctorsView> {
  PresentationForDoctorsController presentationForDoctorsController = Get.find<PresentationForDoctorsController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      isPadded: true,
      child: Column(
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
              Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: IconButton(
                  onPressed: presentationForDoctorsController.isRefreshing.value
                      ? () {}
                      : () async {
                          await presentationForDoctorsController.getOrdersApiCall(isLoading: false);
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
                            size: 6.w,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
