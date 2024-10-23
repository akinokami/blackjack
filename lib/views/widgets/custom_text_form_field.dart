import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/color_const.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;
  final String? requiredText;
  final bool? obscureText;
  final void Function(String)? onChange;
  final void Function()? onPress;
  final int? maxlines;
  final Color? textColor;
  final bool? readonly;
  final bool? isValidate;
  final TextInputType? keyBoardType;
  final String? initialValue;
  final Color? borderColor;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomTextFormField(
      {super.key,
      this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.requiredText,
      this.obscureText,
      this.onChange,
      this.onPress,
      this.maxlines,
      this.textColor,
      this.readonly,
      required this.isValidate,
      this.keyBoardType,
      this.initialValue,
      this.borderColor,
      this.focusNode,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      cursorColor: grey,
      initialValue: initialValue,
      onTap: onPress,
      maxLines: maxlines ?? 1,
      readOnly: readonly ?? false,
      autofocus: false,
      controller: controller,
      obscureText: obscureText ?? false,
      onChanged: onChange,
      keyboardType: keyBoardType ?? TextInputType.text,
      style: TextStyle(color: textColor ?? Colors.black, fontSize: 12),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          errorStyle: TextStyle(color: red),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? grey, width: 1.5.w),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? grey, width: 1.5.w),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: grey, width: 1.5.w),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: red, width: 1.5.w),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          hintText: hintText,
          hintStyle: TextStyle(color: grey, fontSize: 12),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon),
      validator: (value) {
        if (isValidate == true) {
          if (value!.isEmpty) {
            return requiredText ?? "This field is required.";
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
