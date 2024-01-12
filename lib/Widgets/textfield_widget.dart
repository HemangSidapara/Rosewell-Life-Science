import 'package:flutter/material.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String? hintText;
  final int? maxLength;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDisable;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixIcon;
  final void Function(String value)? onFieldSubmitted;

  const TextFieldWidget({
    super.key,
    this.title,
    this.controller,
    this.validator,
    this.hintText,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.suffixIcon,
    this.contentPadding,
    this.isDisable = false,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.onTap,
    this.prefixIconConstraints,
    this.prefixIcon,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Text(
              title!,
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        SizedBox(height: 1.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          style: TextStyle(
            color: AppColors.SECONDARY_COLOR,
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
          ),
          obscureText: obscureText ?? false,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          maxLength: maxLength,
          cursorColor: AppColors.PRIMARY_COLOR,
          enabled: isDisable == false,
          onTap: onTap,
          onChanged: onChanged,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            counter: const SizedBox(),
            counterStyle: TextStyle(color: AppColors.PRIMARY_COLOR),
            filled: true,
            enabled: true,
            prefixIconConstraints: prefixIconConstraints,
            prefixIcon: prefixIcon,
            fillColor: AppColors.WHITE_COLOR,
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
              color: AppColors.SECONDARY_COLOR.withOpacity(0.5),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
            errorStyle: TextStyle(
              color: AppColors.ERROR_COLOR,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.ERROR_COLOR,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.ERROR_COLOR,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.PRIMARY_COLOR,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.PRIMARY_COLOR,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.PRIMARY_COLOR,
                width: 1,
              ),
            ),
            errorMaxLines: 2,
            isDense: true,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h).copyWith(right: 1.5.w),
          ),
        ),
      ],
    );
  }
}
