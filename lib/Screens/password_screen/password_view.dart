import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Screens/password_screen/password_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';
import 'package:rosewell_life_science/Widgets/textfield_widget.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  PasswordController controller = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return CustomScaffoldWidget(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ///Heading
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h).copyWith(bottom: 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                    AppAssets.backIcon,
                    width: context.isPortrait ? 10.w : 5.w,
                    color: AppColors.SECONDARY_COLOR,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      AppStrings.password.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.SECONDARY_COLOR,
                        fontSize: context.isPortrait ? 25.sp : 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),

          ///Password Image
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h).copyWith(bottom: keyboardPadding !=0?keyboardPadding: 6.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.otpImage,
                      height: context.isPortrait ? 28.h : 35.h,
                    ),
                    SizedBox(height: 4.8.h),

                    ///Password Field
                    Obx(() {
                      return Form(
                        key: controller.passwordFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.viewInsetsOf(context).bottom != 0
                                  ? context.isPortrait
                                      ? 2.h
                                      : 2.w
                                  : context.isPortrait
                                      ? 0
                                      : 2.w),
                          child: TextFieldWidget(
                            controller: controller.passwordController,
                            title: AppStrings.password.tr,
                            hintText: AppStrings.enterPassword.tr,
                            validator: (value) {
                              return controller.validatePassword(value!);
                            },
                            obscureText: !controller.isShowPassword.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isShowPassword.toggle();
                              },
                              icon: Icon(
                                !controller.isShowPassword.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: AppColors.PRIMARY_COLOR,
                                size: context.isPortrait ? 6.w : 3.w,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    ///Submit
                    if (context.isLandscape)
                      Obx(() {
                        return ButtonWidget(
                          onPressed: controller.isSignInLoading.value
                              ? () {}
                              : () async {
                                  await controller.checkPassword();
                                },
                          isLoading: controller.isSignInLoading.value,
                          buttonTitle: AppStrings.login.tr,
                        );
                      }),
                  ],
                ),
              ),
            ),
          ),

          ///Submit
          if (context.isPortrait)
            Obx(() {
              return ButtonWidget(
                onPressed: controller.isSignInLoading.value
                    ? () {}
                    : () async {
                        await controller.checkPassword();
                      },
                isLoading: controller.isSignInLoading.value,
                buttonTitle: AppStrings.login.tr,
              );
            }),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }
}
