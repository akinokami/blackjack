import 'package:blackjack/services/local_storage.dart';
import 'package:blackjack/utils/enum.dart';
import 'package:playing_cards/playing_cards.dart';

const START_MONEY = 50000;
const BET_STEPS = 500;
const BET_MULTIPLICATOR = 2;

class Player {
  List<PlayingCard> hand;
  int won = 0;
  int lose = 0;

  int wallet =
      LocalStorage.instance.read(StorageKey.balance.name) ?? START_MONEY;

  int bet = 500;

  Player(this.hand);

  int setBetHigher() {
    final newBet = bet + BET_STEPS;
    if (newBet > wallet) {
      return bet;
    }
    bet = newBet;
    return newBet;
  }

  int setBeLower() {
    final newBet = bet - BET_STEPS;
    if (newBet <= 0) {
      return BET_STEPS;
    }
    bet = newBet;
    return newBet;
  }

  void wonBet() {
    wallet += bet * BET_MULTIPLICATOR;
    LocalStorage.instance.write(StorageKey.balance.name, wallet);
  }

  void lostBet() {
    final newWallet = wallet -= bet;
    if (newWallet <= 0) {
      // wallet = START_MONEY;
    } else {
      wallet = newWallet;
    }
    LocalStorage.instance.write(StorageKey.balance.name, wallet);
  }
}
