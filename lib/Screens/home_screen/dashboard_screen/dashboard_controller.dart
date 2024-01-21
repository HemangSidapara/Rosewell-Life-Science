import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Routes/app_pages.dart';

class DashboardController extends GetxController {
  List<String> contentRouteList = [
    Routes.addDoctorDetailsScreen,
    Routes.editDoctorDetailsScreen,
  ];

  List<String> contentList = [
    AppStrings.addDoctor,
    AppStrings.editDoctor,
  ];

  List<String> contentIconList = [
    AppAssets.addDoctorDetailsIcon,
    AppAssets.editDoctorDetailsIcon,
  ];
}
