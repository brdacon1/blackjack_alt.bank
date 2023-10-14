import 'package:blackjack/enums/animations_unum.dart';
import 'package:flutter/material.dart';
import '../../providers/deck.dart';
import '../../providers/game.dart';


class AnimatedAlignExample extends StatelessWidget {
  final Deck? deck;
  final Game game;
  final AnimationsEnum animationsEnum;
  const AnimatedAlignExample({super.key,
    this.deck,
    required this.game,
    required  this.animationsEnum});

  @override
  Widget build(BuildContext context) {
    switch (animationsEnum) {
      case AnimationsEnum.PLAYER_MOBILE:
        return Center(
          child: AnimatedAlign(
            alignment: game.startAnimation ? Alignment.bottomLeft : Alignment.center,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Image.network('https://www.deckofcardsapi.com/static/img/back.png', width: 150),
          ),
        );
      case AnimationsEnum.PLAYER_WEB:
        return Center(
          child: AnimatedAlign(
            alignment: game.startAnimation ? Alignment.centerLeft : Alignment.center,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Image.network('https://www.deckofcardsapi.com/static/img/back.png', width: 150),
          ),
        );
      case AnimationsEnum.MACHINE_MOBILE:
        return Center(
          child: AnimatedAlign(
            alignment: game.startAnimation ? Alignment.topLeft : Alignment.center,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Image.network('https://www.deckofcardsapi.com/static/img/back.png', width: 150),
          ),
        );
      case AnimationsEnum.MACHINE_WEB:
        return Center(
          child: AnimatedAlign(
            alignment: game.startAnimation ? Alignment.centerRight : Alignment.center,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: Image.network('https://www.deckofcardsapi.com/static/img/back.png', width: 150),
          ),
        );
      default:
        return Container();
    }
  }
}


