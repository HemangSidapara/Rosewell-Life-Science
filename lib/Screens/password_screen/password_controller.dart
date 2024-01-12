import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/services/auth_service/auth_service.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';

class PasswordController extends GetxController {
  RxBool isSignInLoading = false.obs;

  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();

  RxBool isShowPassword = false.obs;

  String? validatePassword(String value) {
    if (value.isEmpty == true) {
      return AppStrings.pleaseEnterPassword.tr;
    }
    return null;
  }

  Future<void> checkPassword() async {
    final isValid = passwordFormKey.currentState?.validate();
    if (isValid == true) {
      try {
        isSignInLoading(true);
        final isSuccess = await AuthService().loginService(
          phone: Get.arguments,
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
