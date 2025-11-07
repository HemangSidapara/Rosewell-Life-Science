import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';

Future<void> showUpdateDialog({
  required void Function() onUpdate,
  bool canPop = true,
  required RxBool isUpdateLoading,
  required RxInt downloadedProgress,
}) async {
  await showGeneralDialog(
    context: Get.context!,
    barrierDismissible: false,
    useRootNavigator: true,
    barrierLabel: 'string',
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(animation),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      final isMobile = context.isPhone;
      final isTablet = context.isTablet || context.isSmallTablet || context.isLargeTablet;
      final dialogHeight = isMobile
          ? 35.h
          : isTablet
          ? 35.h
          : 32.h;
      final dialogWidth = isMobile
          ? 80.w
          : isTablet
          ? 40.w
          : 30.w;
      final dialogPadding = EdgeInsets.symmetric(
        horizontal: isMobile
            ? 5.w
            : isTablet
            ? 2.w
            : 1.w,
        vertical: isMobile ? 2.h : 1.h,
      );

      final spacerHorizontal = isMobile
          ? 5.w
          : isTablet
          ? 3.w
          : 2.w;
      final spacer = isMobile
          ? 2.h
          : isTablet
          ? 1.5.h
          : 1.h;
      final iconSize = isMobile
          ? 10.h
          : isTablet
          ? 8.h
          : 8.h;
      final fontSize = isMobile ? 16.sp : 12.sp;
      final buttonFontSize = isMobile ? 12.sp : 10.sp;

      final loaderSize = isMobile
          ? 5.w
          : isTablet
          ? 3.w
          : 2.w;

      return PopScope(
        canPop: canPop,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.WHITE_COLOR,
          contentPadding: EdgeInsets.symmetric(horizontal: isMobile ? 2.w : 1.w),
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.WHITE_COLOR),
            height: dialogHeight,
            width: dialogWidth,
            clipBehavior: Clip.hardEdge,
            padding: dialogPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.updateAnim, height: iconSize),
                SizedBox(height: spacer),
                Text(
                  AppStrings.newVersionAvailable.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.SECONDARY_COLOR, fontSize: fontSize, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Obx(() {
                  return ButtonWidget(
                    onPressed: onUpdate,
                    isLoading: isUpdateLoading.value,
                    loaderWidget: Row(
                      children: [
                        SizedBox(width: spacerHorizontal),
                        Text(
                          "${downloadedProgress.value}%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.WHITE_COLOR,
                            fontWeight: FontWeight.w700,
                            fontSize: buttonFontSize,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: loaderSize,
                                width: loaderSize,
                                child: CircularProgressIndicator(
                                  color: AppColors.WHITE_COLOR,
                                  strokeWidth: 1.6,
                                  value: downloadedProgress.value / 100,
                                ),
                              ),
                              SizedBox(width: 4.w),
                            ],
                          ),
                        ),
                      ],
                    ),
                    buttonTitle: AppStrings.update.tr,
                  );
                }),
                SizedBox(height: spacer),
              ],
            ),
          ),
        ),
      );
    },
  );
}
