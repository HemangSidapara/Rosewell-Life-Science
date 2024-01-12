import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Localization/localization.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setSize(MediaQuery.sizeOf(context));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      translations: Localization(),
      locale: getString(AppConstance.languageCode) != null && getString(AppConstance.languageCode) != '' && getString(AppConstance.languageCountryCode) != null && getString(AppConstance.languageCountryCode) != '' ? Locale(getString(AppConstance.languageCode) ?? Get.deviceLocale?.languageCode ?? 'en', getString(AppConstance.languageCountryCode)) : Get.deviceLocale,
      fallbackLocale: const Locale('en', 'IN'),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.WHITE_COLOR,
        primaryColor: AppColors.PRIMARY_COLOR,
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        datePickerTheme: DatePickerThemeData(headerBackgroundColor: AppColors.SECONDARY_COLOR),
      ),
      initialRoute: Routes.splashScreen,
      defaultTransition: Transition.downToUp,
      getPages: AppPages.pages,
    );
  }
}
