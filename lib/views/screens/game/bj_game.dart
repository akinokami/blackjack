import 'package:blackjack/services/game_service.dart';
import 'package:blackjack/services/game_service_impl.dart';
import 'package:blackjack/utils/dimen_const.dart';
import 'package:blackjack/views/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../../utils/color_const.dart';
import '../../widgets/card.dart';
import '../../widgets/custom_game_button.dart';

GameService _gameService = GameServiceImpl();

class BlackJackGame extends StatefulWidget {
  const BlackJackGame({super.key});

  @override
  State<BlackJackGame> createState() => _BlackJackGameState();
}

class _BlackJackGameState extends State<BlackJackGame> {
  PlayingCard deckTopCard = PlayingCard(Suit.joker, CardValue.joker_1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[800],
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       "assets/bg.png",
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              height: 150.h,
              width: _gameService.getDealer().hand.length * 90,
              child: FlatCardFan(
                children: [
                  for (var card in _gameService.getDealer().hand) ...[
                    CardAnimatedWidget(
                        card,
                        (_gameService.getGameState() == GameState.playerActive),
                        3.0)
                  ]
                ],
              ),
            ),
            kSizedBoxH5,
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: GestureDetector(
                      onTap: () {
                        if (_gameService.getGameState() ==
                            GameState.playerActive) {
                          _gameService.drawCard();
                          setState(() {});
                        }
                      },
                      child: SizedBox(
                        width: 130.w,
                        child: FlatCardFan(
                          children: [
                            cardWidget(
                                PlayingCard(Suit.joker, CardValue.joker_1),
                                true),
                            cardWidget(
                                PlayingCard(Suit.joker, CardValue.joker_2),
                                true),
                            cardWidget(
                                PlayingCard(Suit.joker, CardValue.joker_2),
                                true),
                            cardWidget(
                                PlayingCard(Suit.joker, CardValue.joker_2),
                                true),
                            cardWidget(
                                PlayingCard(Suit.joker, CardValue.joker_2),
                                true),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container())
                  // Expanded(
                  //   child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         CustomGameButton(
                  //           width: 100.w,
                  //           text: _gameService.getGameState() !=
                  //                   GameState.playerActive
                  //               ? 'new_bet'.tr
                  //               : 'finish'.tr,
                  //           textColor: Colors.white,
                  //           onTap: () {
                  //             if (_gameService.getGameState() ==
                  //                 GameState.playerActive) {
                  //               _gameService.endTurn();
                  //             } else {
                  //               _gameService.startNewGame();
                  //             }
                  //             setState(() {});
                  //           },
                  //         ),
                  //         Container(
                  //             margin: EdgeInsets.only(top: 15.h),
                  //             child: Column(
                  //               children: [
                  //                 if (_gameService.getGameState() !=
                  //                     GameState.playerActive) ...[
                  //                   Text("Winner: ${_gameService.getWinner()}"),
                  //                   Text(
                  //                       "Dealer score: ${_gameService.getScore(_gameService.getDealer())}"),
                  //                   Text(
                  //                       "Player  score: ${_gameService.getScore(_gameService.getPlayer())}"),
                  //                 ],
                  //               ],
                  //             )),
                  //       ]),
                  // ),
                ],
              ),
            ),
            kSizedBoxH5,
            SizedBox(
              height: 150.h,
              width: _gameService.getPlayer().hand.length * 90,
              child: FlatCardFan(
                children: [
                  for (var card in _gameService.getPlayer().hand) ...[
                    CardAnimatedWidget(card, false, 3.0)
                  ]
                ],
              ),
            ),
            // kSizedBoxH15,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: EdgeInsets.only(left: 25.w),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       CustomText(
                //         text: "${'win'.tr}: ${_gameService.getPlayer().won}",
                //         color: Colors.white,
                //         fontSize: 14.sp,
                //       ),
                //       CustomText(
                //         text: "${'loss'.tr}: ${_gameService.getPlayer().lose}",
                //         color: Colors.white,
                //         fontSize: 14.sp,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(width: 30.w),
                Center(
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 40.sp,
                        color: Colors.white,
                        onPressed: _gameService.getGameState() !=
                                GameState.playerActive
                            ? () {
                                _gameService.getPlayer().setBeLower();
                                setState(() {});
                              }
                            : null,
                        icon: const Icon(Icons.arrow_left),
                      ),
                      CustomText(
                        text: _gameService.getPlayer().bet.toString(),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                      IconButton(
                        iconSize: 40.sp,
                        color: Colors.white,
                        onPressed: _gameService.getGameState() !=
                                GameState.playerActive
                            ? () {
                                _gameService.getPlayer().setBetHigher();
                                setState(() {});
                              }
                            : null,
                        icon: const Icon(Icons.arrow_right),
                      )
                    ],
                  ),
                ),
              ],
            ),
            kSizedBoxH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 20.sp,
                ),
                kSizedBoxW5,
                CustomText(
                  text: _gameService.getPlayer().wallet.toString(),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ],
            ),
            kSizedBoxH15,
            _gameService.getGameState() != GameState.playerActive
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomGameButton(
                        width: 100.w,
                        text: 'new_bet'.tr,
                        textColor: Colors.white,
                        onTap: () {
                          // if (_gameService.getGameState() ==
                          //     GameState.playerActive) {
                          //   _gameService.endTurn();
                          // } else {
                          _gameService.startNewGame();
                          //}
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomGameButton(
                        width: 100.w,
                        icon: CupertinoIcons.hand_raised,
                        text: 'stand'.tr,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        onTap: () {
                          // if (_gameService.getGameState() ==
                          //     GameState.playerActive) {
                          _gameService.endTurn();
                          // } else {
                          //   _gameService.startNewGame();
                          // }
                          setState(() {});
                        },
                      ),
                      kSizedBoxW10,
                      CustomGameButton(
                        width: 100.w,
                        icon: CupertinoIcons.arrowtriangle_down_circle,
                        text: 'hit'.tr,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        onTap: () {
                          if (_gameService.getGameState() ==
                              GameState.playerActive) {
                            _gameService.drawCard();
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
