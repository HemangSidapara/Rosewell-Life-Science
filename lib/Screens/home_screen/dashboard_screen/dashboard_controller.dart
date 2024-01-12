import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';

class DashboardController extends GetxController {
  List<String> contentList = [
    AppStrings.addStock,
    AppStrings.availableStock,
    AppStrings.pendingOrders,
    AppStrings.challan,
  ];

  List<String> contentIconList = [
    AppAssets.addStockIcon,
    AppAssets.totalStockIcon,
    AppAssets.pendingOrderIcon,
    AppAssets.challanIcon,
  ];
}
