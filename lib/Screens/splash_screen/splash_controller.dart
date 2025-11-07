import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Network/models/auth_models/get_in_app_data_model.dart';
import 'package:rosewell_life_science/Network/services/auth_service/auth_service.dart';
import 'package:rosewell_life_science/Network/services/utils_service/install_apk_service.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';
import 'package:rosewell_life_science/Utils/in_app_update_dialog_widget.dart';

class SplashController extends GetxController {
  String newAPKUrl = "";
  String newAPKVersion = "";
  RxBool isUpdateLoading = false.obs;
  RxInt downloadedProgress = 0.obs;
  RxString currentVersion = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    final packageInfo = await PackageInfo.fromPlatform();

    currentVersion.value = "${packageInfo.version}.${packageInfo.buildNumber}";
    await _getLatestVersion().then((value) {
      newAPKUrl = value.$1 ?? '';
      newAPKVersion = value.$2 ?? '';
    });

    if (newAPKUrl.isNotEmpty && newAPKVersion.isNotEmpty) {
      if (Utils.isUpdateAvailable(packageInfo.version, newAPKVersion)) {
        await showUpdateDialog(
          canPop: false,
          onUpdate: () async {
            await _downloadAndInstall();
          },
          isUpdateLoading: isUpdateLoading,
          downloadedProgress: downloadedProgress,
        );
      } else {
        nextScreenRoute();
      }
    } else {
      nextScreenRoute();
    }
  }

  Future<void> nextScreenRoute() async {
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

  /// Get latest Version on server
  Future<(String?, String?)> _getLatestVersion() async {
    final response = await AuthService.getInAppDataService();
    if (response.isSuccess) {
      GetInAppDataModel versionModel = GetInAppDataModel.fromJson(response.response?.data);
      return (versionModel.data?.firstOrNull?.appUrl, versionModel.data?.firstOrNull?.appVersion);
    }
    return (null, null);
  }

  /// Download and install
  Future<void> _downloadAndInstall() async {
    try {
      isUpdateLoading(true);
      final directory = await getExternalStorageDirectory();
      final downloadPath = '${directory?.path}/app-release.apk';

      if (newAPKUrl.isNotEmpty) {
        final downloadUrl = newAPKUrl;
        final response = await Dio().downloadUri(
          Uri.parse(downloadUrl),
          downloadPath,
          onReceiveProgress: (counter, total) {
            if (total != -1) {
              if (kDebugMode) {
                print("Downloaded % :: ${(counter / total * 100).toStringAsFixed(0)}%");
              }
              downloadedProgress.value = (counter / total * 100).toStringAsFixed(0).toInt();
            }
          },
        );

        if (response.statusCode == 200) {
          File file = File(downloadPath);
          if (await file.exists()) {
            await InstallApkService.instance.installApk();
            Utils.handleMessage(message: 'Downloaded successfully!');
          } else {
            Utils.handleMessage(message: 'Downloaded file not found.', isError: true);
          }
        } else {
          Utils.handleMessage(message: 'Failed to update.', isError: true);
        }
      } else {
        Utils.handleMessage(message: 'Failed to download.', isError: true);
      }
    } finally {
      isUpdateLoading(false);
    }
  }
}
