import 'package:get/get.dart';

class PresentationForDoctorsController extends GetxController {
  RxBool isGetOrdersLoading = true.obs;
  RxBool isRefreshing = false.obs;
  RxDouble ceilValueForRefresh = 0.0.obs;

  @override
  void onReady() async {
    await getOrdersApiCall();
  }

  Future<void> getOrdersApiCall({bool isLoading = true}) async {
    try {
      isRefreshing(!isLoading);
      isGetOrdersLoading(isLoading);
    } finally {
      isRefreshing(false);
      isGetOrdersLoading(false);
    }
  }
}
