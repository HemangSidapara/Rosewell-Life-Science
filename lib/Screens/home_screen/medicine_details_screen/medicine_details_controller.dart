import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';

class MedicineDetailsController extends GetxController {
  List<String> contentList = [
    AppStrings.addMedicineDetails,
    AppStrings.editMedicineDetails,
  ];

  List<String> contentIconList = [
    AppAssets.addMedicineDetailsIcon,
    AppAssets.editMedicineDetailsIcon,
  ];
}
