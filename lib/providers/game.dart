import 'package:flutter/material.dart';
import '../models/card_models.dart';
import '../models/deck_cards_models.dart';
import 'base/base_provider.dart';

class Game extends BaseProvider {
  String? playerName = '';
  late DeckCards? deckGame;
  List<CardModels?> selectCardPlayer = [];
  List<CardModels?> selectCardMachine = [];
  late int playerPoint = 0;
  late int machinePoint = 0;

  bool isFieldEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  bool isMobileLayout(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  double calculateButtonHeight(BuildContext context) {
    return isMobileLayout(context) ? 50.0 : 60.0;
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
    machinePoint = 0;
    playerPoint = 0;
    playerName = null;
    selectCardPlayer = [];
    selectCardMachine = [];
    playerName = null;
    deckGame = null;
  }
}