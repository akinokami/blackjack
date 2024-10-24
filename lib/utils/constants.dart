import 'package:blackjack/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../views/widgets/custom_button.dart';
import '../views/widgets/custom_text.dart';

Constants constants = Constants();

class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();
  void showSnackBar(
      {String? title, String? msg, Color? bgColor, Color? textColor}) {
    Get.snackbar(
      title ?? "",
      msg ?? "",
      colorText: textColor ?? Colors.black,
      backgroundColor: bgColor ?? Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  void showDialog({
    required String title,
    required String desc,
    IconData? icon,
    Color? iconColor,
    double? iconSize,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        title: Column(children: [
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              color: iconColor ?? secondaryColor,
              size: iconSize ?? 20.sp,
            ),
          ),
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ]),
        content: CustomText(
          text: desc,
          maxLines: 5,
        ),
        actions: [
          CustomButton(
            width: 65.w,
            height: 30.h,
            text: 'cancel'.tr,
            outlineColor: Colors.red,
            bgColor: Colors.red,
            txtColor: Colors.white,
            onTap: onCancel ??
                () {
                  Get.back();
                },
          ),
          CustomButton(
            width: 65.w,
            height: 30.h,
            text: 'confirm'.tr,
            outlineColor: secondaryColor,
            txtColor: Colors.white,
            onTap: onConfirm ??
                () {
                  Get.back();
                },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void showConglaturationDialog({
    required String title,
    required String desc,
    required String image,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
        title: Column(children: [
          Image.asset(
            image,
            width: 1.sw * 0.70,
          ),
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ]),
        content: CustomText(
          text: desc,
          maxLines: 5,
        ),
        actions: [
          CustomButton(
            width: 65.w,
            height: 30.h,
            text: 'ok'.tr,
            outlineColor: secondaryColor,
            txtColor: Colors.white,
            onTap: onConfirm ??
                () {
                  Get.back();
                },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}

//LocalStorage
String language = 'language';
