import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';

class SignInController extends GetxController {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();

  String? validatePhoneNumber(String value) {
    if (value.isEmpty == true) {
      return AppStrings.pleaseEnterPhoneNumber.tr;
    } else if (!GetUtils.isPhoneNumber(value)) {
      return AppStrings.pleaseEnterValidPhoneNumber.tr;
    }
    return null;
  }

  Future<void> checkLogin() async {
    final isValid = signInFormKey.currentState!.validate();
    if (!isValid) {
    } else {
      await Get.toNamed(Routes.passwordScreen, arguments: phoneNumberController.text);
    }
  }
}
