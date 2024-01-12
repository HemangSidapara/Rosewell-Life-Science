import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Screens/home_screen/settings_screen/settings_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';
import 'package:rosewell_life_science/Widgets/button_widget.dart';
import 'package:rosewell_life_science/Widgets/custom_header_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with AutomaticKeepAliveClientMixin {
  SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Header
          CustomHeaderWidget(
            title: AppStrings.settings.tr,
            titleIcon: AppAssets.settingsAnim,
            titleIconSize: context.isPortrait ? 7.w : 7.h,
          ),
          SizedBox(height: 5.h),

          ///Change Language
          ExpansionTile(
            controller: settingsController.expansionTileController,
            onExpansionChanged: (value) {
              if (value) {
                settingsController.isExpanded(value);
              }
              Future.delayed(
                const Duration(milliseconds: 250),
                () {
                  settingsController.isExpanded(value);
                },
              );
            },
            title: Text(
              AppStrings.changeLanguage.tr,
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontWeight: FontWeight.w600,
                fontSize: context.isPortrait ? 12.sp : 6.5.sp,
              ),
            ),
            collapsedBackgroundColor: AppColors.LIGHT_SECONDARY_COLOR,
            backgroundColor: AppColors.LIGHT_SECONDARY_COLOR,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            childrenPadding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 2.h),
            children: [
              Divider(
                color: AppColors.PRIMARY_COLOR,
                thickness: 1,
              ),
              SizedBox(height: 1.h),
              Obx(() {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: context.isPortrait ? 50.h : 50.w, minHeight: 0.h, maxWidth: 90.w, minWidth: 90.w),
                  child: GridView.count(
                    crossAxisCount: context.isPortrait ? 2 : 3,
                    shrinkWrap: true,
                    crossAxisSpacing: context.isPortrait ? 5.w : 5.h,
                    childAspectRatio: context.isPortrait ? 3 : 5,
                    children: [
                      ///English
                      InkWell(
                        onTap: () async {
                          await setData(AppConstance.languageCode, 'en');
                          await setData(AppConstance.languageCountryCode, 'IN');
                          await Get.updateLocale(
                            Locale(getString(AppConstance.languageCode) ?? 'en', getString(AppConstance.languageCountryCode) ?? 'IN'),
                          );
                          settingsController.isGujaratiLang(false);
                          settingsController.isHindiLang(false);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                          child: Row(
                            children: [
                              AnimatedOpacity(
                                opacity: settingsController.isGujaratiLang.isFalse && settingsController.isHindiLang.isFalse ? 1 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.done_rounded,
                                  size: context.isPortrait ? 6.w : 6.h,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                AppStrings.english.tr,
                                style: TextStyle(
                                  fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///Gujarati
                      InkWell(
                        onTap: () async {
                          await setData(AppConstance.languageCode, 'gu');
                          await setData(AppConstance.languageCountryCode, 'IN');
                          await Get.updateLocale(
                            Locale(getString(AppConstance.languageCode) ?? 'gu', getString(AppConstance.languageCountryCode) ?? 'IN'),
                          );
                          settingsController.isGujaratiLang(true);
                          settingsController.isHindiLang(false);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                          child: Row(
                            children: [
                              AnimatedOpacity(
                                opacity: settingsController.isGujaratiLang.isTrue ? 1 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.done_rounded,
                                  size: context.isPortrait ? 6.w : 6.h,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                AppStrings.gujarati.tr,
                                style: TextStyle(
                                  fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///Hindi
                      InkWell(
                        onTap: () async {
                          await setData(AppConstance.languageCode, 'hi');
                          await setData(AppConstance.languageCountryCode, 'IN');
                          await Get.updateLocale(
                            Locale(getString(AppConstance.languageCode) ?? 'hi', getString(AppConstance.languageCountryCode) ?? 'IN'),
                          );
                          settingsController.isGujaratiLang(false);
                          settingsController.isHindiLang(true);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                          child: Row(
                            children: [
                              AnimatedOpacity(
                                opacity: settingsController.isHindiLang.isTrue ? 1 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.done_rounded,
                                  size: context.isPortrait ? 6.w : 6.h,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                AppStrings.hindi.tr,
                                style: TextStyle(
                                  fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.PRIMARY_COLOR,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),

          const Spacer(),

          ///LogOut
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonWidget(
              onPressed: () {
                clearData();
                Get.offAllNamed(Routes.signInScreen);
              },
              buttonTitle: AppStrings.logOut.tr,
              fixedSize: Size(context.isPortrait ? double.maxFinite : 70.w, context.isPortrait ? 5.h : 9.h),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
