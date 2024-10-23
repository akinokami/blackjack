import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

  void showDialog(String title, String desc, VoidCallback? onTap) {
    Get.defaultDialog(
        titlePadding: EdgeInsets.all(10.w),
        contentPadding: EdgeInsets.all(10.w),
        title: title,
        middleText: desc,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.black, fontSize: 15.sp),
        middleTextStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
        textConfirm: 'yes'.tr,
        textCancel: 'no'.tr,
        cancelTextColor: Colors.black,
        confirmTextColor: Colors.white,
        buttonColor: const Color(0xff8f7a66),
        barrierDismissible: false,
        radius: 10.r,
        onConfirm: onTap);
  }
}

//LocalStorage
String language = 'language';
