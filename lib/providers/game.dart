import 'package:flutter/material.dart';

import '../models/card_models.dart';
import '../models/deck_cards_models.dart';
import 'base/base_provider.dart';

class Game extends BaseProvider {
  String? playerName = '';
  late DeckCards? deckGame;
  List<CardModels?> selectCardPlayer = [];
  List<CardModels?> selectCardMachine = [];

  bool isFieldEmpty(String? value) {
    return value == null || value.isEmpty;
  }
  bool isMobileLayout(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  double calculateButtonHeight(BuildContext context) {
    return isMobileLayout(context) ? 60.0 : 60.0;
  }


  @override
  void cleanProvider() {
    playerName = null;
  }
}