import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:rosewell_life_science/Screens/home_screen/dashboard_screen/hand_shaken_animation.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with AutomaticKeepAliveClientMixin {
  DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                AppStrings.hello.tr,
                style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: context.isPortrait ? 16.sp : 9.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const HandShakenAnimation(),
              Text(
                ',',
                style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: context.isPortrait ? 16.sp : 9.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),

          ///Presentation for Doctors
          ElevatedButton(
            onPressed: () async {
              Get.toNamed(Routes.presentationForDoctorsScreen, id: 0);
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
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 65.w,
                      child: Row(
                        children: [
                          Image.asset(
                            AppAssets.doctorListIcon,
                            width: context.isPortrait ? 14.w : 14.h,
                          ),
                          SizedBox(width: 3.w),
                          Flexible(
                            child: Text(
                              AppStrings.presentationForDoctors.tr,
                              style: TextStyle(
                                color: AppColors.SECONDARY_COLOR,
                                fontWeight: FontWeight.w600,
                                fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      AppAssets.frontIcon,
                      color: AppColors.SECONDARY_COLOR,
                      width: context.isPortrait ? 9.w : 8.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
