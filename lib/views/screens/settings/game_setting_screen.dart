import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:blackjack/views/screens/settings/game_privacy_policy_screen.dart';

import '../../../controller/sound_controller.dart';
import '../../../utils/dimen_const.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_game_button.dart';
import '../../widgets/custom_text.dart';
import 'game_language_screen.dart';

class GameSettingScreen extends StatelessWidget {
  const GameSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final soundController = Get.put(SoundController());
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
          child: ListView(
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
                    text: 'settings'.tr,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )
                ],
              ),
              kSizedBoxH15,
              CustomText(
                text: 'general'.tr,
                color: Colors.white,
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const GameLanguageScreen());
                },
                child: CustomCard(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            size: 18.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'language'.tr)
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'lang'.tr,
                            fontSize: 12.sp,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => CustomCard(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.music_note,
                            size: 18.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'sound'.tr)
                        ],
                      ),
                      FlutterSwitch(
                        padding: 1.5,
                        height: 23,
                        width: 44,
                        inactiveColor: Colors.grey,
                        activeColor: Colors.green,
                        value: soundController.isMuted.value,
                        onToggle: (val) {
                          soundController.isMuted.value = val;
                          soundController.muteUnmute();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Obx(
              //   () => Switch(
              //     value: settingController.currentTheme.value == ThemeMode.dark,
              //     onChanged: (value) {
              //       settingController.switchTheme();
              //       Get.changeThemeMode(settingController.currentTheme.value);
              //     },
              //     activeColor: CustomTheme.white,
              //   ),
              // ),
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                text: 'other'.tr,
                color: Colors.white,
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () {
                  Get.to(() => const GamePrivacyPolicyScreen());
                },
                child: CustomCard(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.policy_outlined,
                            size: 18.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(text: 'policy'.tr)
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
              CustomCard(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 18.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(text: 'version'.tr),
                      ],
                    ),
                    const CustomText(text: '1.0.0'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
