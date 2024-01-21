import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/api_keys.dart';
import 'package:rosewell_life_science/Constants/api_urls.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Network/ResponseModel.dart';
import 'package:rosewell_life_science/Network/api_base_helper.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class DoctorDetailsService {
  ///Get Doctors Service
  Future<ResponseModel> getDoctorsService() async {
    final response = await ApiBaseHelper().getHTTP(
      ApiUrls.getDoctorApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) {
        try {
          if (data.isSuccess && data.data['code']!.toString().toInt() >= 200 && data.data['code']!.toString().toInt() <= 299) {
            if (kDebugMode) {
              print("getDoctorApi success message :::: ${data.data['msg']}");
            }
          } else {
            if (kDebugMode) {
              print("getDoctorApi error message :::: ${data.data['msg']}");
            }
            Utils.handleMessage(message: data.data['msg'].toString().tr, isError: true);
          }
        } catch (e) {
          debugPrint(e.toString());
          Utils.handleMessage(message: AppStrings.temporaryServiceIsNotAvailable.tr, isError: true);
        }
      },
    );
    return response;
  }

  ///Add Doctor Service
  Future<bool> addDoctorsService({
    required String doctorName,
    required List<int> product,
  }) async {
    final params = {
      ApiKeys.doctorName: doctorName,
      ApiKeys.product: product,
    };
    final response = await ApiBaseHelper().postHTTP(
      ApiUrls.addDoctorApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) {
        try {
          if (data.isSuccess && data.data['code']!.toString().toInt() >= 200 && data.data['code']!.toString().toInt() <= 299) {
            if (kDebugMode) {
              print("addDoctorApi success message :::: ${data.data['msg']}");
            }
            Get.back(id: 0);
            Utils.handleMessage(message: data.data['msg'].toString().tr);
          } else {
            if (kDebugMode) {
              print("addDoctorApi error message :::: ${data.data['msg']}");
            }
            Utils.handleMessage(message: data.data['msg'].toString().tr, isError: true);
          }
        } catch (e) {
          debugPrint(e.toString());
          Utils.handleMessage(message: AppStrings.temporaryServiceIsNotAvailable.tr, isError: true);
        }
      },
      params: params,
    );
    return response.isSuccess;
  }

  ///Update Doctors Service
  Future<bool> updateDoctorService({
    required List<String> imagesPath,
    required String medicineName,
    required String pID,
  }) async {
    final params = {};
    final response = await ApiBaseHelper().postHTTP(
      ApiUrls.updateDoctorApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) {
        try {
          if (data.isSuccess && data.data['code']!.toString().toInt() >= 200 && data.data['code']!.toString().toInt() <= 299) {
            if (kDebugMode) {
              print("updateDoctorApi success message :::: ${data.data['msg']}");
            }
            Get.back(id: 1);
            Utils.handleMessage(message: data.data['msg'].toString().tr);
          } else {
            if (kDebugMode) {
              print("updateDoctorApi error message :::: ${data.data['msg']}");
            }
            Utils.handleMessage(message: data.data['msg'].toString().tr, isError: true);
          }
        } catch (e) {
          debugPrint(e.toString());
          Utils.handleMessage(message: AppStrings.temporaryServiceIsNotAvailable.tr, isError: true);
        }
      },
      params: params,
    );
    return response.isSuccess;
  }

  ///Delete Doctor Service
  Future<ResponseModel> deleteDoctorService({
    required String pID,
  }) async {
    final params = {};
    final response = await ApiBaseHelper().deleteHTTP(
      ApiUrls.deleteDoctorApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message);
      },
      onSuccess: (data) {
        if (data.statusCode! >= 200 && data.statusCode! <= 299) {
          if (kDebugMode) {
            print("deleteDoctorApi success message :::: ${data.response?.data['msg']}");
          }
        } else {
          if (kDebugMode) {
            print("deleteDoctorApi error message :::: ${data.response?.data['msg']}");
          }
          Utils.handleMessage(message: data.response?.data['msg'], isError: true);
        }
      },
      params: params,
    );
    return response;
  }
}
