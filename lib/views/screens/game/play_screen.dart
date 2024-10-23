import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controller/sound_controller.dart';
import '../../../services/local_storage.dart';
import '../../../utils/color_const.dart';
import '../../../utils/dimen_const.dart';
import '../../../utils/enum.dart';
import '../../../utils/global.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_game_button.dart';
import '../../widgets/custom_text.dart';
import '../settings/game_setting_screen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  String first = '';

  @override
  void initState() {
    super.initState();

    first = LocalStorage.instance.read(StorageKey.first.name) ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        if (first == '') {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      surfaceTintColor: whiteColor,
                      backgroundColor: whiteColor,
                      content: SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: WebViewWidget(
                                  controller: WebViewController()
                                    ..loadHtmlString(Global.language ==
                                            Language.zh.name
                                        ? Global.policyZh
                                        : Global.language == Language.vi.name
                                            ? Global.policyVi
                                            : Global.language ==
                                                    Language.ko.name
                                                ? Global.policyKo
                                                : Global.language ==
                                                        Language.hi.name
                                                    ? Global.policyHi
                                                    : Global.policyEn)),
                            ),
                            kSizedBoxH5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: secondaryColor,
                                  side: BorderSide(
                                    width: 1.5,
                                    color: isChecked
                                        ? secondaryColor
                                        : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                Expanded(
                                  child: CustomText(
                                    text: 'agree'.tr,
                                    color: secondaryColor,
                                    fontSize: 11.sp,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            kSizedBoxH5,
                            CustomButton(
                              text: 'accept'.tr,
                              size: 11.sp,
                              width: 100.w,
                              height: 25.h,
                              isRounded: true,
                              outlineColor:
                                  isAccepted ? secondaryColor : greyColor,
                              bgColor: isAccepted ? secondaryColor : greyColor,
                              onTap: isAccepted
                                  ? () async {
                                      LocalStorage.instance.write(
                                          StorageKey.first.name, 'notfirst');
                                      Navigator.pop(context);
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        // print("Error fetching SharedPreferences: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final soundController = Get.put(SoundController());
    soundController.playSound();

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
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomGameButton(
                //       onTap: () {
                //         exit(0);
                //       },
                //       height: 35.w,
                //       width: 35.w,
                //       icon: Icons.close,
                //       iconColor: Colors.white,
                //       color1: Colors.red,
                //       color2: Colors.red.shade300,
                //       color3: Colors.red,
                //     ),
                //     CustomGameButton(
                //       onTap: () {
                //         Get.to(() => const SettingScreen());
                //       },
                //       height: 35.w,
                //       width: 35.w,
                //       icon: Icons.settings,
                //       iconColor: Colors.white,
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 120.h,
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    'assets/logo.webp',
                    width: 100.h,
                  ),
                ),
                // SizedBox(
                //   height: 40.h,
                // ),
                CustomGameButton(
                  onTap: () {
                    //Get.to(() => const SlotGameScreen());
                  },
                  width: 0.2.sh,
                  text: 'play'.tr,
                  textColor: Colors.white,
                ),
                kSizedBoxH10,
                CustomGameButton(
                  onTap: () {
                    Get.to(() => const GameSettingScreen());
                  },
                  width: 0.2.sh,
                  text: 'settings'.tr,
                  textColor: Colors.white,
                ),
                kSizedBoxH10,
                CustomGameButton(
                  onTap: () {
                    exit(0);
                  },
                  width: 0.2.sh,
                  text: 'exit'.tr,
                  textColor: Colors.white,
                  color1: const Color.fromARGB(255, 196, 84, 76),
                  color2: const Color.fromARGB(255, 202, 143, 140),
                  color3: const Color.fromARGB(255, 196, 84, 76),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
