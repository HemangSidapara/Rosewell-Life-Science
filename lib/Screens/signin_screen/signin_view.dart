import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Screens/signin_screen/signin_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_scaffold_widget.dart';
import 'package:rosewell_life_science/Widgets/textfield_widget.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  SignInController controller = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h).copyWith(bottom: 6.h),
        child: context.isPortrait
            ? MainColumn()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainColumn(),
                ],
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MainColumn() {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///Heading
        Text(
          AppStrings.login.tr,
          style: TextStyle(
            color: AppColors.SECONDARY_COLOR,
            fontSize: context.isPortrait ? 25.sp : 15.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 1.h),

        ///Login Image
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.loginImage,
                  height: context.isPortrait ? 35.h : 45.h,
                ),
                SizedBox(height: 2.h),

                ///Fields
                Form(
                  key: controller.signInFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.viewInsetsOf(context).bottom != 0
                          ? context.isPortrait
                                ? 2.h
                                : 2.w
                          : context.isPortrait
                          ? 0
                          : 2.w,
                    ),
                    child: Column(
                      children: [
                        ///cityName
                        TextFieldWidget(
                          controller: controller.cityNameController,
                          title: AppStrings.cityName.tr,
                          hintText: AppStrings.enterCityName.tr,
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          validator: (value) {
                            return controller.validateCityName(value!);
                          },
                        ),
                        SizedBox(height: context.isPortrait ? 2.h : 2.w),

                        ///password
                        Obx(() {
                          return TextFieldWidget(
                            controller: controller.passwordController,
                            title: AppStrings.password.tr,
                            hintText: AppStrings.enterPassword.tr,
                            validator: (value) {
                              return controller.validatePassword(value!);
                            },
                            obscureText: !controller.isShowPassword.value,
                            suffixIconConstraints: BoxConstraints(minWidth: context.isPortrait ? 12.w : 12.h, maxWidth: context.isPortrait ? 12.w : 12.h),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isShowPassword.toggle();
                              },
                              style: IconButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(
                                !controller.isShowPassword.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: AppColors.PRIMARY_COLOR,
                                size: context.isPortrait ? 6.w : 4.h,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                ///Submit
                if (context.isLandscape)
                  Obx(() {
                    return ButtonWidget(
                      onPressed: () async {
                        await controller.checkLogin();
                      },
                      isLoading: controller.isSignInLoading.value,
                      buttonTitle: AppStrings.next.tr,
                    );
                  }),
              ],
            ),
          ),
        ),

        ///Submit
        if (context.isPortrait)
          Obx(() {
            return ButtonWidget(
              onPressed: () async {
                await controller.checkLogin();
              },
              isLoading: controller.isSignInLoading.value,
              buttonTitle: AppStrings.next.tr,
            );
          }),

        SizedBox(height: keyboardPadding),
      ],
    );
  }
}
