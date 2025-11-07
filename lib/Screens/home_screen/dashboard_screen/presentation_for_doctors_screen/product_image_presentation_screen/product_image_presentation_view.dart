import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_strings.dart';
import 'package:rosewell_life_science/Network/models/doctor_details_model/get_doctor_model.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class ProductImagePresentationView extends StatefulWidget {
  const ProductImagePresentationView({super.key});

  @override
  State<ProductImagePresentationView> createState() => _ProductImagePresentationViewState();
}

class _ProductImagePresentationViewState extends State<ProductImagePresentationView> {
  RxList<ProductMeta> imageList = RxList();
  RxBool isAppBarVisible = true.obs;
  RxBool isOneOpacity = true.obs;
  RxBool isInitPortrait = true.obs;
  PageController pageController = PageController(initialPage: 0);

  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isInitPortrait(context.isPortrait);
    });
    pageController.addListener(() {
      setState(() {});
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    imageList.clear();
    for (List<ProductMeta>? element in (Get.arguments as List<DoctorMeta>).map((e) => e.productMeta).toList()) {
      element?.forEach((element) {
        imageList.add(element);
      });
    }
    showAppBar();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.WHITE_COLOR,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.WHITE_COLOR,
        statusBarBrightness: Brightness.dark,
      ),
    );
    timer?.cancel();
    super.dispose();
  }

  void showAppBar() {
    isAppBarVisible(true);
    isOneOpacity(true);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    timer = Timer.periodic(const Duration(seconds: 1), (tick) {
      if (tick.tick == 3) {
        tick.cancel();
        isOneOpacity(false);
        Future.delayed(
          const Duration(milliseconds: 300),
          () {
            isAppBarVisible(false);
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: isAppBarVisible.value
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight - 10),
                child: AnimatedOpacity(
                  opacity: isOneOpacity.value ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    color: AppColors.WHITE_COLOR,
                    child: AppBar(
                      backgroundColor: AppColors.PRIMARY_COLOR.withValues(alpha: 0.5),
                      centerTitle: true,
                      leadingWidth: 10.w,
                      leading: Padding(
                        padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: IconButton.styleFrom(
                            highlightColor: AppColors.WHITE_COLOR.withValues(alpha: 0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Image.asset(
                            AppAssets.backIcon,
                            color: AppColors.SECONDARY_COLOR,
                            width: context.isPortrait ? 8.w : 8.h,
                          ),
                        ),
                      ),
                      title: Text(
                        (Get.arguments as List<DoctorMeta>).where((element) => element.productMeta?.any((element) => element.pId == imageList[pageController.hasClients ? pageController.page!.toInt() : 0].pId) == true).toList().first.name ?? '',
                        style: TextStyle(
                          color: AppColors.SECONDARY_COLOR,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
        body: GestureDetector(
          onTap: showAppBar,
          child: Container(
            height: context.isLandscape ? 100.h : 100.h,
            width: context.isLandscape ? 100.w : 100.w,
            color: AppColors.WHITE_COLOR,
            child: Obx(() {
              if (imageList.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noDataFound.tr,
                    style: TextStyle(
                      color: AppColors.SECONDARY_COLOR,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: imageList[index].image ?? '',
                            fit: BoxFit.contain,
                            progressIndicatorBuilder: (context, url, downloadProgress) {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: AppColors.SECONDARY_COLOR,
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Icon(
                                Icons.error_rounded,
                                color: AppColors.ERROR_COLOR,
                                size: 5.w,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      );
    });
  }
}
