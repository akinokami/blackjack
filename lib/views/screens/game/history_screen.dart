import 'package:blackjack/controller/history_controller.dart';
import 'package:blackjack/utils/color_const.dart';
import 'package:blackjack/views/widgets/custom_card.dart';
import 'package:blackjack/views/widgets/custom_loading.dart';
import 'package:blackjack/views/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/dimen_const.dart';
import '../../widgets/custom_game_button.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyController = Get.put(HistoryController());
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
                      color: Colors.white,
                    )
                  ],
                ),
                kSizedBoxH15,
                Obx(
                  () => Expanded(
                    child: historyController.isLoading.value == true
                        ? const CustomLoading()
                        : historyController.history.isEmpty
                            ? Center(
                                child: CustomText(
                                  text: 'no_data'.tr,
                                  color: Colors.white,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: historyController.history.length,
                                itemBuilder: (context, index) {
                                  return CustomCard(
                                      widget: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: historyController
                                                            .history[index]
                                                        ['type'] ==
                                                    'win'
                                                ? 'you_win'.tr
                                                : historyController
                                                                .history[index]
                                                            ['type'] ==
                                                        'lose'
                                                    ? 'you_lose'.tr
                                                    : 'draw'.tr,
                                            fontWeight: FontWeight.bold,
                                            color: historyController
                                                            .history[index]
                                                        ['type'] ==
                                                    'win'
                                                ? secondaryColor
                                                : historyController
                                                                .history[index]
                                                            ['type'] ==
                                                        'lose'
                                                    ? red
                                                    : Colors.black,
                                          ),
                                          CustomText(
                                            text: historyController
                                                            .history[index]
                                                        ['type'] ==
                                                    'win'
                                                ? "+ ${historyController.history[index]['bet_amt'] ?? 0}"
                                                : historyController
                                                                .history[index]
                                                            ['type'] ==
                                                        'lose'
                                                    ? "- ${historyController.history[index]['bet_amt'] ?? 0}"
                                                    : "${historyController.history[index]['bet_amt'] ?? 0}",
                                            fontWeight: FontWeight.bold,
                                            color: historyController
                                                            .history[index]
                                                        ['type'] ==
                                                    'win'
                                                ? secondaryColor
                                                : historyController
                                                                .history[index]
                                                            ['type'] ==
                                                        'lose'
                                                    ? red
                                                    : Colors.black,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: 'dealer_score'.tr),
                                          CustomText(
                                              text:
                                                  "${historyController.history[index]['dealer_score'] ?? 0}")
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: 'your_score'.tr),
                                          CustomText(
                                              text:
                                                  "${historyController.history[index]['player_score'] ?? 0}")
                                        ],
                                      ),
                                    ],
                                  ));
                                },
                              ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
