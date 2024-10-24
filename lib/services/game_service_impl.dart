import 'package:blackjack/services/card_service_impl.dart';
import 'package:blackjack/services/game_service.dart';
import 'package:blackjack/services/local_storage.dart';
import 'package:blackjack/utils/color_const.dart';
import 'package:blackjack/utils/constants.dart';
import 'package:blackjack/utils/dimen_const.dart';
import 'package:blackjack/utils/enum.dart';
import 'package:blackjack/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playing_cards/playing_cards.dart';

import '../models/player_model.dart';
import 'card_service.dart';

const HIGHES_SCORE_VALUE = 21;
const int DEALER_MIN_SCORE = 17;

class GameServiceImpl extends GameService {
  late Player player;
  late Player dealer;
  GameState gameState = GameState.equal;

  GameServiceImpl() {
    dealer = Player(_cardService.drawCards(2));
    player = Player(_cardService.drawCards(2));
  }

  final CardService _cardService = CardServiceImpl();

  @override
  void startNewGame() {
    player.hand = _cardService.drawCards(2);
    dealer.hand = _cardService.drawCards(2);
    _cardService.new52Deck();
    gameState = GameState.playerActive;
  }

  @override
  PlayingCard drawCard() {
    final drwanCard = _cardService.drawCard();
    player.hand.add(drwanCard);
    if (getScore(player) >= HIGHES_SCORE_VALUE) {
      endTurn();
    }
    return drwanCard;
  }

  @override
  void endTurn() {
    // Dealer turn
    int dealerScore = getScore(dealer);
    while (dealerScore < DEALER_MIN_SCORE) {
      dealer.hand.add(_cardService.drawCard());
      dealerScore = getScore(dealer);
    }

    // Get burnt players
    final playerScore = getScore(player);
    final bool burntDealer = (dealerScore > HIGHES_SCORE_VALUE);
    final bool burntPlayer = (playerScore > HIGHES_SCORE_VALUE);

    // Find game result
    if (burntDealer && burntPlayer) {
      gameState = GameState.equal;
      drawDialog();
    } else if (dealerScore == playerScore) {
      gameState = GameState.equal;
      drawDialog();
    } else if (burntDealer && playerScore <= HIGHES_SCORE_VALUE) {
      playerWon();
    } else if (burntPlayer && dealerScore <= HIGHES_SCORE_VALUE) {
      dealerWon();
    } else if (dealerScore < playerScore) {
      playerWon();
    } else if (dealerScore > playerScore) {
      dealerWon();
    }
  }

  void drawDialog() {
    updateHistory('draw');
    constants.showDialog(
      title: 'draw'.tr,
      desc: '',
      widget: SizedBox(
        height: 40.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "${'dealer_score'.tr} : ${getScore(getDealer())}",
            ),
            CustomText(
              text: "${'your_score'.tr} : ${getScore(getPlayer())}",
            ),
          ],
        ),
      ),
    );
  }

  void playerWon() {
    gameState = GameState.playerWon;
    player.won += 1;
    dealer.lose += 1;
    player.wonBet();
    updateHistory('win');
    constants.showDialog(
      title: 'you_win'.tr,
      titleColor: secondaryColor,
      desc: '',
      widget: SizedBox(
        height: 55.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "+ ${player.bet}",
              color: secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            kSizedBoxH5,
            CustomText(
              text: "${'dealer_score'.tr} : ${getScore(getDealer())}",
            ),
            CustomText(
              text: "${'your_score'.tr} : ${getScore(getPlayer())}",
            ),
          ],
        ),
      ),
    );
  }

  void dealerWon() {
    gameState = GameState.dealerWon;
    dealer.won += 1;
    player.lose += 1;
    player.lostBet();
    updateHistory('lose');
    constants.showDialog(
      title: 'you_lose'.tr,
      titleColor: red,
      desc: '',
      widget: SizedBox(
        height: 55.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "- ${player.bet}",
              color: red,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
            kSizedBoxH5,
            CustomText(
              text: "${'dealer_score'.tr} : ${getScore(getDealer())}",
            ),
            CustomText(
              text: "${'your_score'.tr} : ${getScore(getPlayer())}",
            ),
          ],
        ),
      ),
    );
  }

  void updateHistory(String type) {
    List<Map<String, dynamic>> history = [];
    history = List<Map<String, dynamic>>.from(
        LocalStorage.instance.read(StorageKey.history.name) ?? []);
    history.add({
      "type": type,
      "bet_amt": player.bet,
      "dealer_score": getScore(getDealer()),
      "player_score": getScore(getPlayer())
    });
    LocalStorage.instance.write(StorageKey.history.name, history);
  }

  @override
  Player getPlayer() {
    return player;
  }

  @override
  Player getDealer() {
    return dealer;
  }

  @override
  int getScore(Player player) {
    return mapCardValueRules(player.hand);
  }

  @override
  GameState getGameState() {
    return gameState;
  }

  @override
  String getWinner() {
    if (GameState.dealerWon == gameState) {
      return "Dealer";
    }
    if (GameState.playerWon == gameState) {
      return "You";
    }
    return "Nobody";
  }
}

/// Map blackjack rules for card values to the PlayingCard enum
int mapCardValueRules(List<PlayingCard> cards) {
  List<PlayingCard> standardCards = cards
      .where((card) => (0 <= card.value.index && card.value.index <= 11))
      .toList();

  final sumStandardCards = getSumOfStandardCards(standardCards);

  int acesAmount = cards.length - standardCards.length;
  if (acesAmount == 0) {
    return sumStandardCards;
  }

  // Special case: Ace could be value 1 or 11
  final pointsLeft = HIGHES_SCORE_VALUE - sumStandardCards;
  final oneAceIsEleven = 11 + (acesAmount - 1);

  // One Ace with value 11 fits
  if (pointsLeft >= oneAceIsEleven) {
    return sumStandardCards + oneAceIsEleven;
  }

  return sumStandardCards + acesAmount;
}

int getSumOfStandardCards(List<PlayingCard> standardCards) {
  return standardCards.fold<int>(
      0, (sum, card) => sum + mapStandardCardValue(card.value.index));
}

int mapStandardCardValue(int cardEnumIdex) {
  // ignore: constant_identifier_names
  const GAP_BETWEEN_INDEX_AND_VALUE = 2;

  // Card value 2-10 -> index between 0 and 8
  if (0 <= cardEnumIdex && cardEnumIdex <= 8) {
    return cardEnumIdex + GAP_BETWEEN_INDEX_AND_VALUE;
  }

  // Card is jack, queen, king -> index between90 and 11
  if (9 <= cardEnumIdex && cardEnumIdex <= 11) {
    return 10;
  }

  return 0;
}
