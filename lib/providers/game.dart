import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enums/animations_unum.dart';
import '../enums/type_popup.dart';
import '../models/card_models.dart';
import '../models/deck_cards_models.dart';
import 'base/base_provider.dart';
import 'deck.dart';

class Game extends BaseProvider {
  late int playerPoint = 0;
  late int machinePoint = 0;
  late bool playerWinner = false;
  late bool machineWinner = false;
  late bool isRestartButton = false;
  late bool startAnimation = true;
  late bool isAnimationVisible = true;
  late DeckCards? deckGame;
  late TypePopupEnum typePopupEnum;
  late AnimationsEnum animationsEnum = AnimationsEnum.DEFAULT;


  List<CardModels?> selectCardPlayer = [];
  List<CardModels?> selectCardMachine = [];

  bool isFieldEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  bool isMobileLayout(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  double calculateButtonHeight(BuildContext context) {
    return isMobileLayout(context) ? 50.0 : 60.0;
  }

  void calculateWinner(VoidCallback showPopup) {
    if (playerPoint <= 21 && machinePoint > 21) {
      playerWinner = true;
      machineWinner = false;
    } else if (machinePoint <= 21 && playerPoint > 21) {
      playerWinner = false;
      machineWinner = true;
    } else if (machinePoint == 21) {
      playerWinner = false;
      machineWinner = true;
    } else if (playerPoint == 21) {
      playerWinner = true;
      machineWinner = false;
    } else {
      playerWinner = false;
      machineWinner = false;
      isRestartButton = false;
    }

    if (machineWinner) {
      typePopupEnum = TypePopupEnum.LOSE;
      isRestartButton = true;
      showPopup();
    } else if (playerWinner) {
      typePopupEnum = TypePopupEnum.CONGRATULATIONS;
      isRestartButton = true;
      showPopup();
    }
  }

  Future<void> machinePlaying(Deck deck, VoidCallback updateParentState, VoidCallback showPopup) async {
    if (!playerWinner && !machineWinner) {
      animationsEnum = AnimationsEnum.MACHINE_MOBILE;
      isAnimationVisible = true;
      startAnimation = true;
      updateParentState();

      selectCardMachine.add(await deck.getBuyCards(deckGame?.deckId));
      calculatePointCards(true);
      calculateWinner(showPopup);
      updateParentState();
    }
  }

  Future<void> playerPlaying(Deck deck, VoidCallback updateParentState, VoidCallback showPopup) async {
    if (!playerWinner && !machineWinner) {
      animationsEnum = AnimationsEnum.PLAYER_MOBILE;
      isAnimationVisible = true;
      startAnimation = true;
      updateParentState();

      selectCardPlayer.add(await deck.getBuyCards(deckGame?.deckId));
      calculatePointCards(false);
      calculateWinner(showPopup);
      updateParentState();
    }
  }

  Future<void> restartGame(Deck deck, VoidCallback updateParentState, BuildContext context, VoidCallback startScreen) async {
    deck = Provider.of<Deck>(context, listen: false);
    cleanProvider();
    deck.cleanProvider();
    animationsEnum = AnimationsEnum.MACHINE_MOBILE;
    isAnimationVisible = true;
    startAnimation = true;
    updateParentState();

    await deck.getNewDeck().then((result) {
      deckGame = result;
    });
    startScreen();
    updateParentState();
  }

  Future<void> startGame(Deck deck, VoidCallback updateParentState) async {
    animationsEnum = AnimationsEnum.MACHINE_MOBILE;
    isAnimationVisible = true;
    startAnimation = true;
    updateParentState();

    selectCardMachine.add(await deck.getBuyCards(deckGame?.deckId));
    calculatePointCards(true);
    updateParentState();
  }

  calculatePointCards(bool isMachine) {
    if(isMachine) {
      machinePoint = 0;
      for (var element in selectCardMachine) {
          if(element?.cards[0].value  == 'KING' ||
             element?.cards[0].value == 'QUEEN' ||
             element?.cards[0].value == 'JACK' ||
             element?.cards[0].value == '10'){
             machinePoint += 10;
          } else if (element?.cards[0].value  == 'ACE') {
            machinePoint += 1;
          } else {
            machinePoint += int.tryParse(element?.cards[0].value ?? '0') ?? 0;
          }
      }
    } else {
      playerPoint = 0;
      for (var element in selectCardPlayer) {
        if(element?.cards[0].value  == 'KING' ||
            element?.cards[0].value == 'QUEEN' ||
            element?.cards[0].value == 'JACK' ||
            element?.cards[0].value == '10'){
          playerPoint += 10;
        } else if (element?.cards[0].value  == 'ACE') {
          playerPoint += 1;
        } else {
          playerPoint += int.tryParse(element?.cards[0].value ?? '0') ?? 0;
        }
      }
    }
  }


  @override
  void cleanProvider() {
    deckGame = null;
    playerPoint = 0;
    machinePoint = 0;
    playerWinner = false;
    machineWinner = false;
    isRestartButton = false;
    selectCardPlayer = [];
    selectCardMachine = [];
  }
}