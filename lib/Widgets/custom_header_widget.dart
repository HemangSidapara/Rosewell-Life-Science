import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_assets.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class CustomHeaderWidget extends StatefulWidget {
  final String title;
  final String titleIcon;
  final double? titleIconSize;
  final void Function()? onBackPressed;

  const CustomHeaderWidget({
    super.key,
    required this.title,
    required this.titleIcon,
    this.onBackPressed,
    this.titleIconSize,
  });

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidgetState();
}

class _CustomHeaderWidgetState extends State<CustomHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.onBackPressed != null) ...[
          IconButton(
            onPressed: widget.onBackPressed,
            style: IconButton.styleFrom(
              highlightColor: AppColors.PRIMARY_COLOR.withOpacity(0.2),
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
          SizedBox(width: 2.w),
        ],
        Text(
          widget.title,
          style: TextStyle(
            color: AppColors.PRIMARY_COLOR,
            fontSize: context.isPortrait ? 16.sp : 9.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(width: 2.w),
        Image.asset(
          widget.titleIcon,
          width: widget.titleIconSize ?? (context.isPortrait ? 8.w : 8.h),
        ),
      ],
    );
  }
}
