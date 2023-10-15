import 'package:blackjack/enums/animations_unum.dart';
import 'package:flutter/material.dart';
import '../../providers/deck.dart';
import '../../providers/game.dart';

class AnimatedAlignExample extends StatefulWidget {
  final Deck? deck;
  final Game game;
  final double cardWidth;

  const AnimatedAlignExample({
    Key? key,
    this.deck,
    required this.cardWidth,
    required this.game,
  }) : super(key: key);

  @override
  _AnimatedAlignExampleState createState() => _AnimatedAlignExampleState();
}

class _AnimatedAlignExampleState extends State<AnimatedAlignExample> {
  @override
  void initState() {
    super.initState();
  }

  Alignment getTargetAlignment(AnimationsEnum animationsEnum) {
    switch (animationsEnum) {
      case AnimationsEnum.PLAYER_MOBILE:
        return Alignment.bottomLeft;
      case AnimationsEnum.PLAYER_WEB:
        return Alignment.centerLeft;
      case AnimationsEnum.MACHINE_MOBILE:
        return Alignment.topLeft;
      case AnimationsEnum.MACHINE_WEB:
        return Alignment.centerRight;
      case AnimationsEnum.DEFAULT:
        return Alignment.center;
      default:
        return Alignment.center;
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {
      widget.game.startAnimation = true;
      widget.game.isAnimationVisible = true;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Alignment targetAlignment = getTargetAlignment(widget.game.animationsEnum);
    return Center(
      child: Visibility(
        visible: widget.game.isAnimationVisible,
        child: AnimatedAlign(
        alignment: widget.game.startAnimation ? targetAlignment : Alignment.center,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        onEnd: () async {
          setState(() {
            widget.game.isAnimationVisible = false;
          });
          await Future.delayed(const Duration(milliseconds: 1000));
          setState(() {
            widget.game.isAnimationVisible = true;
            widget.game.startAnimation = true;
            widget.game.animationsEnum = AnimationsEnum.DEFAULT;
          });
        },
        child: Image.network(
          'https://www.deckofcardsapi.com/static/img/back.png',
           width: widget.cardWidth,
        ),
      ),
    ));
  }
}
