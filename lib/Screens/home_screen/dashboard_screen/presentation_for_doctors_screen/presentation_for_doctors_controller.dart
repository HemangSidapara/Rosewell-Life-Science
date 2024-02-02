import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Network/models/doctor_details_model/get_doctor_model.dart' as get_doctor;
import 'package:rosewell_life_science/Network/services/doctor_details_service/doctor_details_service.dart';

class PresentationForDoctorsController extends GetxController {
  RxBool isGetDoctorLoading = true.obs;
  RxBool isRefreshing = false.obs;
  RxDouble ceilValueForRefresh = 0.0.obs;

  TextEditingController searchDoctorController = TextEditingController();

  RxList<ExpansionTileController> expansionTileControllerList = RxList();
  RxList<ExpansionTileController> searchedExpansionTileControllerList = RxList();
  RxList<get_doctor.Data> doctorDataList = RxList();
  RxList<get_doctor.Data> searchedDoctorDataList = RxList();
  RxInt expandedIndex = (-1).obs;

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
        expansionTileControllerList = RxList.generate(doctorModel.data?.length ?? 0, (index) => ExpansionTileController());
        searchedExpansionTileControllerList = RxList.generate(doctorModel.data?.length ?? 0, (index) => ExpansionTileController());
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
}
