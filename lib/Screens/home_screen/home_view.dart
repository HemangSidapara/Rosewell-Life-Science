import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Screens/home_screen/home_controller.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.WHITE_COLOR,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.WHITE_COLOR,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (Get.keys[0]?.currentState?.canPop() == true) {
          controller.onBottomItemChange(index: 0);
        } else {
          if (controller.bottomIndex.value == 0) {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          } else {
            controller.onBottomItemChange(index: 0);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.WHITE_COLOR,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.LIGHT_SECONDARY_COLOR,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AssetImages(index: 0, iconName: AppAssets.homeIcon),
                AssetImages(index: 1, iconName: AppAssets.addNewProductIcon),
                AssetImages(index: 2, iconName: AppAssets.ordersHistoryIcon),
                AssetImages(index: 3, iconName: AppAssets.settingsIcon),
              ],
            ),
          ),
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.bottomItemWidgetList,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AssetImages({
    required int index,
    required String iconName,
  }) {
    return Obx(
      () {
        return InkWell(
          onTap: () async {
            await controller.onBottomItemChange(index: index);
          },
          child: SizedBox(
            height: 12.w,
            width: 12.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconName,
                  width: 8.w,
                  color: controller.bottomIndex.value == index ? AppColors.PRIMARY_COLOR : AppColors.LIGHT_BLACK_COLOR,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
