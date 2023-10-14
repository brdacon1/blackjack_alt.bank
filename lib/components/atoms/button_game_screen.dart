import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../providers/deck.dart';
import '../../providers/game.dart';
import 'container_button.dart';
import 'custom_text_size.dart';

class GameScreenButton extends StatelessWidget {
  final Deck deck;
  final Game game;
  final bool? isWeb;
  final bool isWebButton;
  final double? screenHeight;
  final double? barHeight;
  final double? buttonHeight;
  final VoidCallback updateParentState;
  final VoidCallback startScreen;
  final VoidCallback showPopup;

  const GameScreenButton({
        required this.startScreen,
        required this.updateParentState,
        required this.showPopup,
        this.isWeb,
        required this.isWebButton,
        this.screenHeight,
        this.barHeight,
        this.buttonHeight,
        required this.game,
        required this.deck,
        super.key});

  @override
  Widget build(BuildContext context) {
    return isWebButton
        ? Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Visibility(
             visible: !game.isRestartButton,
             child: Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 5),
                 child: ContainerButton(
                   width: 300,
                   height: buttonHeight,
                   borderRadius: 50,
                   backgroundColor: kGreenDarkColor,
                   borderColor: kColorWhite,
                   onTap: () async {
                     await game.playerPlaying(deck, updateParentState, showPopup);
                   },
                   child: const Row(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(
                         Icons.arrow_drop_down_circle_rounded,
                         color: kColorWhite,
                       ),
                       SizedBox(width: 8),
                       CustomTextSize(
                         'Comprar carta',
                         textStyle: TextStylesEnum.size28Medium,
                         textAlign: TextAlign.center,
                         fontWeight: FontWeight.w700,
                         color: kColorWhite,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
           Visibility(
             visible: game.isRestartButton,
             child: Expanded(
               flex: 7,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 5),
                 child: ContainerButton(
                   width: 300,
                   height: buttonHeight,
                   borderRadius: 50,
                   backgroundColor: kGreenDarkColor,
                   borderColor: kColorWhite,
                   onTap: () async {
                     await game.restartGame(deck, updateParentState, context, startScreen);
                   },
                   child: const Row(
                     mainAxisSize: MainAxisSize.min,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(
                         Icons.play_arrow,
                         color: kColorWhite,
                         size: 25,
                       ),
                       SizedBox(width: 8),
                       CustomTextSize(
                         'Recomeçar',
                         textStyle: TextStylesEnum.sizeNo18Responsive,
                         textAlign: TextAlign.center,
                         fontWeight: FontWeight.w700,
                         color: kColorWhite,
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
      ]) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Visibility(
          visible: !game.isRestartButton,
          child: Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ContainerButton(
                width: 300,
                height: buttonHeight,
                borderRadius: 50,
                backgroundColor: kGreenDarkColor,
                borderColor: kColorWhite,
                onTap: () async {
                  await game.playerPlaying(deck, updateParentState, showPopup);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: kColorWhite,
                    ),
                    SizedBox(width: 8),
                    CustomTextSize(
                      'Comprar carta',
                      textStyle: TextStylesEnum.size28Medium,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      color: kColorWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: game.isRestartButton,
          child: Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ContainerButton(
                width: 300,
                height: buttonHeight,
                borderRadius: 50,
                backgroundColor: kGreenDarkColor,
                borderColor: kColorWhite,
                onTap: () async {
                  await game.restartGame(deck, updateParentState, context, startScreen);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: kColorWhite,
                      size: 25,
                    ),
                    SizedBox(width: 8),
                    CustomTextSize(
                      'Recomeçar',
                      textStyle: TextStylesEnum.sizeNo18Responsive,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      color: kColorWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}