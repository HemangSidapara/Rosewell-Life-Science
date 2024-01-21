import 'package:flutter/material.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class CustomScaffoldWidget extends StatelessWidget {
  final Widget child;
  final bool isPadded;
  final EdgeInsetsGeometry? scaffoldPadding;
  final Widget? bottomSheet;

  const CustomScaffoldWidget({
    super.key,
    required this.child,
    this.isPadded = false,
    this.scaffoldPadding,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: bottomSheet != null,
        bottomSheet: Material(
          color: AppColors.WHITE_COLOR,
          borderRadius: BorderRadius.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: keyboardPadding != 0 ? 0.h : 3.h, horizontal: 5.w).copyWith(top: 0),
            child: bottomSheet,
          ),
        ),
        body: isPadded
            ? Padding(
                padding: scaffoldPadding ?? EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                child: child,
              )
            : child,
      ),
    );
  }
}
