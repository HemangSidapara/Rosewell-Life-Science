import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';

class ProgressDialog extends GetxController with GetSingleTickerProviderStateMixin {
  static var isOpen = false;
  final RxDouble _progressValue = 0.0.obs;
  final RxBool _progressStart = true.obs;

  @override
  void onInit() {
    super.onInit();
    simulateSlowLoader();
  }

  Future<void> simulateSlowLoader() async {
    if (_progressStart.value) {
      for (int i = 0; i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 10));
        _progressValue.value = i / 100.0;
      }
      _progressStart(false);
    } else {
      _progressValue.value = 0.0;
      _progressStart(true);
    }
    simulateSlowLoader();
  }

  void showProgressDialog(bool showDialog) {
    if (showDialog) {
      isOpen = true;
      if (kDebugMode) {
        print('|--------------->🕙️ Loader start 🕑️<---------------|');
      }

      Get.dialog(
        barrierColor: AppColors.TRANSPARENT,
        PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) => Future.value(true),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return LinearProgressIndicator(
                    color: AppColors.SECONDARY_COLOR,
                    minHeight: 4,
                    value: _progressValue.value,
                    backgroundColor: AppColors.SECONDARY_COLOR.withValues(alpha: 0.25),
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.SECONDARY_COLOR),
                  );
                }),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    } else if (Get.isDialogOpen == true) {
      if (kDebugMode) {
        print('|--------------->🕙️ Loader end 🕑️<---------------|');
      }
      Get.back();
      isOpen = false;
    }
  }
}
