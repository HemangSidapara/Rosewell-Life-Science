import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Screens/home_screen/home_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.WHITE_COLOR,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.WHITE_COLOR,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (Get.keys[0]?.currentState?.canPop() == true) {
            controller.onBottomItemChange(index: 0);
          } else if (Get.keys[1]?.currentState?.canPop() == true) {
            controller.onBottomItemChange(index: 1);
          } else {
            if (controller.bottomIndex.value != 0) {
              controller.onBottomItemChange(index: 0);
            } else if (Get.keys[0]?.currentState?.canPop() != true) {
              showExitDialog();
            }
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.WHITE_COLOR,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.PRIMARY_COLOR.withValues(alpha: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AssetImages(index: 0, iconName: AppAssets.homeIcon),
                if (getData(AppConstance.role) == 'Admin') AssetImages(index: 1, iconName: AppAssets.medicineDetailsBottomIcon, iconWidthInLandscape: 5.5, iconWidthInPortrait: 7),
                AssetImages(index: 2, iconName: AppAssets.settingsIcon, iconWidthInLandscape: 7, iconWidthInPortrait: 8.5),
              ],
            ),
          ),
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.bottomItemWidgetList,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AssetImages({
    required int index,
    required String iconName,
    double iconWidthInLandscape = 6,
    double iconWidthInPortrait = 8,
  }) {
    return Obx(
      () {
        return InkWell(
          onTap: () async {
            await controller.onBottomItemChange(index: index);
          },
          child: SizedBox(
            height: context.isPortrait ? 12.w : 10.h,
            width: context.isPortrait ? 12.w : 10.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconName,
                  width: context.isPortrait ? iconWidthInPortrait.w : iconWidthInLandscape.h,
                  color: controller.bottomIndex.value == index ? AppColors.SECONDARY_COLOR : AppColors.WHITE_COLOR,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showExitDialog() async {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'string',
      transitionDuration: const Duration(milliseconds: 375),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.WHITE_COLOR,
          surfaceTintColor: AppColors.WHITE_COLOR,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.WHITE_COLOR,
            ),
            height: context.isPortrait ? 30.h : 60.h,
            width: context.isPortrait ? 80.w : 40.w,
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.symmetric(horizontal: context.isPortrait ? 5.w : 5.h, vertical: context.isPortrait ? 2.h : 2.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.WARNING_COLOR,
                  size: context.isPortrait ? 10.w : 10.h,
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.areYouSureYouWantToExitTheApp.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ERROR_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: context.isPortrait ? 12.sp : 7.sp,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///No
                    ButtonWidget(
                      onPressed: () {
                        Get.back();
                      },
                      buttonTitle: AppStrings.no.tr,
                      fixedSize: Size(context.isPortrait ? 30.w : 15.w, context.isPortrait ? 5.h : 12.h),
                    ),

                    ///Yes, exit
                    ButtonWidget(
                      onPressed: () async {
                        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
                      },
                      buttonTitle: AppStrings.yesExit.tr,
                      buttonColor: AppColors.SECONDARY_COLOR,
                      fixedSize: Size(context.isPortrait ? 30.w : 15.w, context.isPortrait ? 5.h : 12.h),
                    ),
                  ],
                ),
                SizedBox(height: context.isPortrait ? 2.h : 2.w),
              ],
            ),
          ),
        );
      },
    );
  }
}
