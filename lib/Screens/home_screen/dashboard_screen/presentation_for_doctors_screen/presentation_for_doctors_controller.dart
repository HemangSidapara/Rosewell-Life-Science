import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart' as excel_file;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/app_utils.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Network/models/doctor_details_model/get_doctor_model.dart' as get_doctor;
import 'package:rosewell_life_science/Network/services/doctor_details_service/doctor_details_service.dart';
import 'package:rosewell_life_science/Network/services/utils_service/file_picker_service.dart';
import 'package:rosewell_life_science/Utils/app_formatter.dart';

class PresentationForDoctorsController extends GetxController {
  RxBool isGetDoctorLoading = true.obs;
  RxBool isRefreshing = false.obs;
  RxDouble ceilValueForRefresh = 0.0.obs;

  TextEditingController searchDoctorController = TextEditingController();

  RxList<ExpansibleController> expansionTileControllerList = RxList();
  RxList<ExpansibleController> searchedExpansionTileControllerList = RxList();
  RxList<get_doctor.Data> doctorDataList = RxList();
  RxList<get_doctor.Data> searchedDoctorDataList = RxList();
  RxInt expandedIndex = (-1).obs;

  RxBool isExportLoading = false.obs;

  @override
  void onReady() async {
    await getDoctorApiCall();
  }

  Future<void> getDoctorApiCall({bool isLoading = true}) async {
    try {
      isRefreshing(!isLoading);
      isGetDoctorLoading(true);
      final response = await DoctorDetailsService().getDoctorsService();

      if (response.isSuccess) {
        get_doctor.GetDoctorModel doctorModel = get_doctor.getDoctorModelFromJson(response.response.toString());
        expansionTileControllerList.clear();
        searchedExpansionTileControllerList.clear();
        expansionTileControllerList = RxList.generate(doctorModel.data?.length ?? 0, (index) => ExpansibleController());
        searchedExpansionTileControllerList = RxList.generate(doctorModel.data?.length ?? 0, (index) => ExpansibleController());
        doctorDataList.clear();
        searchedDoctorDataList.clear();
        doctorDataList.addAll(doctorModel.data ?? []);
        searchedDoctorDataList.addAll(doctorModel.data ?? []);
      }
    } finally {
      isRefreshing(false);
      isGetDoctorLoading(false);
    }
  }

  Future<void> exportDoctorsToExcelApi() async {
    try {
      isExportLoading(true);
      final excel = excel_file.Excel.createExcel();
      final sheet = excel['Doctors'];

      // Header row
      sheet.appendRow([
        excel_file.TextCellValue('Doctor Name'),
        excel_file.TextCellValue('Medicine Names'),
      ]);

      // Iterate doctors
      for (var doctor in searchedDoctorDataList) {
        String doctorName = doctor.name ?? "";
        List<get_doctor.DoctorMeta> doctorMeta = doctor.doctorMeta ?? [];

        // Collect medicine names
        List<String> medicines = doctorMeta.map((meta) => meta.name ?? "").toList();
        medicines.removeWhere((element) => element.isEmpty);

        // Add row to Excel
        sheet.appendRow([
          excel_file.TextCellValue(doctorName),
          excel_file.TextCellValue(medicines.join(', ')),
        ]);
      }

      // Save file
      final directory = Directory(AppConstance.androidDownloadPath);
      final filePath = '${directory.path}/${getData(AppConstance.cityName)?.toString().cleanFileName ?? ""}_doctor_medicines.xlsx';
      final fileBytes = excel.encode();
      final file = File(filePath);

      if (fileBytes != null) {
        final permission = await FilePickerService().permissionStatus(
          whenOpenSettings: () async {
            await openAppSettings();
            return true;
          },
        );
        if (permission.$1 == PermissionStatus.granted && permission.$2 == PermissionStatus.granted) {
          if (file.existsSync()) {
            await file.delete();
          }
          await file.create(recursive: true);
          await file.writeAsBytes(fileBytes);
          if (kDebugMode) {
            print('✅ Excel file exported successfully: $filePath');
          }
          Utils.handleMessage(message: AppStrings.excelFileExported);
        } else {
          if (kDebugMode) {
            print('❌ Permission denied');
          }
          Utils.handleMessage(message: AppStrings.storagePermissionRequired, isError: true);
        }
      } else {
        Utils.handleMessage(message: AppStrings.issueInExportExcelFile, isError: true);
      }
    } catch (e, st) {
      log("Export Exception: $e\n$st");
      Utils.handleMessage(message: "Export Error: $e\n$st", isError: true);
    } finally {
      isExportLoading(false);
    }
  }
}
