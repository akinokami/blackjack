import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/language_controller.dart';

import '../../../utils/color_const.dart';
import '../../../utils/dimen_const.dart';
import '../../../utils/enum.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_game_button.dart';
import '../../widgets/custom_text.dart';

class GameLanguageScreen extends StatelessWidget {
  const GameLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/bg.webp",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomGameButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      height: 35.w,
                      width: 35.w,
                      icon: Icons.arrow_back,
                      iconColor: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: 'change_language'.tr,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                kSizedBoxH15,
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("en", "US");
                    },
                    child: CustomCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/usa.webp",
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const CustomText(
                                text: "English",
                              )
                            ],
                          ),
                          Icon(
                            languageController.language.value ==
                                    Language.en.name
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: languageController.language.value ==
                                    Language.en.name
                                ? secondaryColor
                                : grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("vi", "VN");
                    },
                    child: CustomCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/vietnam.webp",
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const CustomText(
                                text: "Tiếng Việt",
                              )
                            ],
                          ),
                          Icon(
                            languageController.language.value ==
                                    Language.vi.name
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: languageController.language.value ==
                                    Language.vi.name
                                ? secondaryColor
                                : grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("ko", "KR");
                    },
                    child: CustomCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/korea.webp",
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const CustomText(
                                text: "한국인",
                              )
                            ],
                          ),
                          Icon(
                            languageController.language.value ==
                                    Language.ko.name
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: languageController.language.value ==
                                    Language.ko.name
                                ? secondaryColor
                                : grey,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      languageController.changeLanguage("hi", "IN");
                    },
                    child: CustomCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/india.webp",
                                width: 20.w,
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const CustomText(
                                text: "हिन्दी",
                              )
                            ],
                          ),
                          Icon(
                            languageController.language.value ==
                                    Language.hi.name
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: languageController.language.value ==
                                    Language.hi.name
                                ? secondaryColor
                                : grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
