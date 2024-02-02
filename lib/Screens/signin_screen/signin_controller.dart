import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/services/auth_service/auth_service.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  RxBool isSignInLoading = false.obs;

  TextEditingController cityNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isShowPassword = false.obs;

  String? validatePassword(String value) {
    if (value.isEmpty == true) {
      return AppStrings.pleaseEnterPassword.tr;
    }
    return null;
  }

  String? validateCityName(String value) {
    if (value.isEmpty == true) {
      return AppStrings.pleaseEnterPhoneNumber.tr;
    }
    return null;
  }

  Future<void> checkLogin() async {
    final isValid = signInFormKey.currentState!.validate();
    if (isValid == true) {
      try {
        isSignInLoading(true);
        final isSuccess = await AuthService().loginService(
          phone: cityNameController.text,
          password: passwordController.text,
        );
        if (isSuccess) {
          await Get.offAllNamed(Routes.homeScreen);
        }
      } finally {
        isSignInLoading(false);
      }
    }
  }
}
