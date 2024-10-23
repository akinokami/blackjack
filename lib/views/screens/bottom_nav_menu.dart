import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blackjack/utils/enum.dart';
import 'package:blackjack/views/screens/match/match_screen.dart';
import 'package:blackjack/views/screens/settings/setting_screen.dart';
import 'package:blackjack/views/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/bottom_nav_controller.dart';
import '../../services/local_storage.dart';
import '../../utils/color_const.dart';
import '../../utils/dimen_const.dart';
import '../../utils/global.dart';
import '../widgets/custom_button.dart';

class BottomNavMenu extends StatefulWidget {
  const BottomNavMenu({super.key});

  @override
  State<BottomNavMenu> createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavMenu> {
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

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 10.sp);

  final TextStyle selectedLabelStyle = TextStyle(
      color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 10.sp);

  buildBottomNavigationMenu(context, bottomNavController) {
    return Obx(() => BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: bottomNavController.changeTabIndex,
          currentIndex: bottomNavController.tabIndex.value,
          backgroundColor: whiteColor,
          unselectedItemColor: Colors.black54,
          selectedItemColor: secondaryColor,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.gamepad,
                size: 18.sp,
              ),
              label: 'matches'.tr,
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 18.sp,
              ),
              label: 'settings'.tr,
              backgroundColor: primaryColor,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController(), permanent: false);
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar:
          buildBottomNavigationMenu(context, bottomNavController),
      body: Obx(() => IndexedStack(
            index: bottomNavController.tabIndex.value,
            children: const [
              MatchScreen(),
              SettingScreen(),
            ],
          )),
    );
  }
}
