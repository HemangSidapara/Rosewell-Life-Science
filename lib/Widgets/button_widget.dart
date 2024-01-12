import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class ButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final Widget? child;
  final String buttonTitle;
  final Size? fixedSize;
  final OutlinedBorder? shape;
  final bool isLoading;
  final Color? buttonColor;

  const ButtonWidget({
    super.key,
    this.onPressed,
    this.child,
    this.buttonTitle = '',
    this.fixedSize,
    this.shape,
    this.isLoading = false,
    this.buttonColor,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? () {} : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.buttonColor ?? AppColors.PRIMARY_COLOR,
        surfaceTintColor: widget.isLoading ? AppColors.PRIMARY_COLOR : null,
        elevation: 4,
        shadowColor: AppColors.WHITE_COLOR.withOpacity(0.7),
        fixedSize: widget.fixedSize ?? Size(context.isPortrait ? 84.w : 50.w, context.isPortrait ? 5.h : 9.h),
        shape: widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
      ),
      child: widget.isLoading
          ? SizedBox(
              height: context.isPortrait ? 5.w : 5.h,
              width: context.isPortrait ? 5.w : 5.h,
              child: CircularProgressIndicator(
                color: AppColors.WHITE_COLOR,
                strokeWidth: 1.6,
              ),
            )
          : widget.child ??
              Text(
                widget.buttonTitle,
                style: TextStyle(
                  color: AppColors.WHITE_COLOR,
                  fontSize: context.isPortrait ? 12.sp : 6.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
    );
  }
}
