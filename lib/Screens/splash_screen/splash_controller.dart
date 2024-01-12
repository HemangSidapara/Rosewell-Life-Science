import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: AppColors.WHITE_COLOR, systemNavigationBarIconBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, statusBarColor: AppColors.TRANSPARENT, statusBarBrightness: Brightness.light));
        if (kDebugMode) {
          print("token value ::: ${getData(AppConstance.authorizationToken)}");
        }
        if (getData(AppConstance.authorizationToken) == null) {
          Get.offAllNamed(Routes.signInScreen);
        } else {
          Get.offAllNamed(Routes.homeScreen);
        }
      },
    );
  }
}
