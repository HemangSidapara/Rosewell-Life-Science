import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:rosewell_life_science/Constants/api_keys.dart';
import 'package:rosewell_life_science/Constants/api_urls.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Network/api_base_helper.dart';
import 'package:rosewell_life_science/Network/models/medicine_details_models/get_medicine_model.dart' as get_medicine;
import 'package:rosewell_life_science/Network/response_model.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class MedicineDetailsService {
  ///Get Medicine Service
  Future<ResponseModel> getMedicineService() async {
    final response = await ApiBaseHelper.getHTTP(
      ApiUrls.getMedicineApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) {
        try {
          if (data.isSuccess && data.data['code']!.toString().toInt() >= 200 && data.data['code']!.toString().toInt() <= 299) {
            if (kDebugMode) {
              print("getMedicineApi success message :::: ${data.data['msg']}");
            }
          } else {
            if (kDebugMode) {
              print("getMedicineApi error message :::: ${data.data['msg']}");
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

  ///Add Medicine Service
  Future<bool> addMedicineService({
    required List<String> imagesPath,
    required String medicineName,
  }) async {
    final params = FormData.fromMap({
      ApiKeys.image: [
        for (String file in imagesPath)
          await MultipartFile.fromFile(
            file,
            // filename: file.split('/').last.split('.')[file.split('/').last.split('.').length - 2],
            // contentType: MediaType(lookupMimeType(file)!.split('/')[0], file.split('/').last.split('.').last),
          ),
      ],
      ApiKeys.medicineName: medicineName,
    });
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.addMedicineApi,
      showProgress: false,
      options: Options(contentType: Headers.multipartFormDataContentType),
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) {
        try {
          if (data.isSuccess && data.data['code']!.toString().toInt() >= 200 && data.data['code']!.toString().toInt() <= 299) {
            if (kDebugMode) {
              print("addMedicineApi success message :::: ${data.data['msg']}");
            }
            Get.back(id: 1);
            Utils.handleMessage(message: data.data['msg'].toString().tr);
          } else {
            if (kDebugMode) {
              print("addMedicineApi error message :::: ${data.data['msg']}");
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

  ///Update Medicine Service
  Future<bool> updateMedicineService({
    required List<get_medicine.ProductMeta> oldImage,
    required List<String> imagesPath,
    required String medicineName,
    required String pID,
  }) async {
    final params = FormData.fromMap({
      ApiKeys.oldMetaID: oldImage.map((e) => e.metaId).toList().join(','),
      ApiKeys.image: [
        for (String file in imagesPath)
          await MultipartFile.fromFile(
            file,
            // filename: file.split('/').last.split('.')[file.split('/').last.split('.').length - 2],
            // contentType: MediaType(lookupMimeType(file)!.split('/')[0], file.split('/').last.split('.').last),
          ),
      ],
      ApiKeys.medicineName: medicineName,
      ApiKeys.pID: pID,
    });
    final response = await ApiBaseHelper.postHTTP(
      ApiUrls.updateMedicineApi,
      showProgress: false,
      options: Options(contentType: Headers.multipartFormDataContentType),
      onError: (error) {
        Utils.handleMessage(message: error.message, isError: true);
      },
      onSuccess: (data) {
        try {
          if (data.isSuccess && data.data['code']!.toString().toInt() >= 200 && data.data['code']!.toString().toInt() <= 299) {
            if (kDebugMode) {
              print("updateMedicineApi success message :::: ${data.data['msg']}");
            }
            Get.back(id: 1);
            Utils.handleMessage(message: data.data['msg'].toString().tr);
          } else {
            if (kDebugMode) {
              print("updateMedicineApi error message :::: ${data.data['msg']}");
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

  ///Delete Medicine Service
  Future<ResponseModel> deleteMedicineService({
    required String pID,
  }) async {
    final params = {
      ApiKeys.pID: pID,
    };
    final response = await ApiBaseHelper.deleteHTTP(
      ApiUrls.deleteMedicineApi,
      showProgress: false,
      onError: (error) {
        Utils.handleMessage(message: error.message);
      },
      onSuccess: (data) {
        if (data.statusCode! >= 200 && data.statusCode! <= 299) {
          if (kDebugMode) {
            print("deleteMedicineApi success message :::: ${data.response?.data['msg']}");
          }
        } else {
          if (kDebugMode) {
            print("deleteMedicineApi error message :::: ${data.response?.data['msg']}");
          }
          Utils.handleMessage(message: data.response?.data['msg'], isError: true);
        }
      },
      params: params,
    );
    return response;
  }
}
