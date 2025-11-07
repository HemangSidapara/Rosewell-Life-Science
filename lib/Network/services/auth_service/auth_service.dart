import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/api_keys.dart';
import 'package:rosewell_life_science/Constants/api_urls.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Network/api_base_helper.dart';
import 'package:rosewell_life_science/Network/models/auth_models/login_model.dart';
import 'package:rosewell_life_science/Network/response_model.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class AuthService {
  ///Get In App Data Service
  static Future<ResponseModel> getInAppDataService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getInAppDataApi,
      showProgress: false,
      onError: (dioExceptions) {
        if (kDebugMode) {
          print("❌ getInAppDataApi OnError: ${dioExceptions.message}");
        }
        Utils.handleMessage(message: dioExceptions.message, isError: true);
      },
      onSuccess: (res) async {
        if (res.isSuccess) {
          if (kDebugMode) {
            print("✅ getInAppDataApi Success: ${res.message}");
          }
        } else {
          if (kDebugMode) {
            print("❌ getInAppDataApi Error: ${res.message}");
          }
        }
      },
    );

    return response;
  }

  ///login Service
  Future<bool> loginService({
    required String phone,
    required String password,
  }) async {
    final param = {
      ApiKeys.phone: phone,
      ApiKeys.password: password,
    };
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.loginApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) async {
        try {
          final loginModel = loginModelFromJson(jsonEncode(data.response!.data));
          if (data.isSuccess && loginModel.code!.toInt() >= 200 && loginModel.code!.toInt() <= 299) {
            setData(AppConstance.authorizationToken, loginModel.token);
            setData(AppConstance.role, loginModel.role);
            await setData(AppConstance.cityName, loginModel.cityName);
            if (kDebugMode) {
              print("login success message :::: ${loginModel.msg}");
            }
            Utils.handleMessage(message: loginModel.msg?.tr);
          } else {
            if (kDebugMode) {
              print("login error message :::: ${loginModel.msg}");
            }
            Utils.handleMessage(message: loginModel.msg?.tr, isError: true);
          }
        } catch (e) {
          Utils.handleMessage(message: AppStrings.temporaryServiceIsNotAvailable.tr, isError: true);
        }
      },
      params: param,
    );
    return response.isSuccess;
  }
}
