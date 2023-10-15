import 'package:blackjack/components/atoms/popup_game.dart';
import 'package:blackjack/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/atoms/animation_card.dart';
import '../components/atoms/button_game_screen.dart';
import '../components/atoms/custom_text_size.dart';
import '../enums/animations_unum.dart';
import '../providers/deck.dart';
import '../providers/game.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game-screen';
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() {
    return _GameScreen();
  }
}

class _GameScreen extends State<GameScreen> {
  late Deck deck;
  late Game game;
  late double widthSizeBox = 0;
  late PopupGame showPopup;

  @override
  void initState() {
    deck = Provider.of<Deck>(context, listen: false);
    game = Provider.of<Game>(context, listen: false);
    showPopup = PopupGame();
    startScreen();
    showPopup.closeLoading(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void updateParentState() {
    setState(() {});
  }

  startScreen() async {
    if(game.deckGame != null) {
      game.deckGame = await deck.getReshuffleCards(game.deckGame?.deckId);
      game.startGame(deck, updateParentState);
      game.isRestartButton = false;
    } else {
      game.isRestartButton = true;
    }
  }

  showPopupFunction() async {
    showPopup.filterNotify(game.typePopupEnum, context, game);
  }

  Widget _buildLabel(TextStylesEnum localTextStyle,
      FontWeight localFontWeight,
      Color localColor,
      String localText) {
    return CustomTextSize(
      localText,
      textStyle: localTextStyle,
      textAlign: TextAlign.center,
      fontWeight: localFontWeight,
      color: localColor,
      wrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 1100;
    final isWebButton = MediaQuery.of(context).size.width > 598;
    final screenHeight = MediaQuery.of(context).size.height;
    final barHeight = screenHeight * 0.10;
    final buttonHeight = game.calculateButtonHeight(context);
    final cardWidth = (MediaQuery.of(context).size.width) * 0.25;

    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Visibility(
            child: Center(
            child: AnimatedAlignExample(
              deck: deck,
              game: game,
              cardWidth: cardWidth,
            ),
          )),

          isWeb ? _buildWebLayout() : _buildMobileLayout(),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: barHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.transparent,
              ),
              child: GameScreenButton(
                showPopup: showPopupFunction,
                startScreen: startScreen,
                updateParentState: updateParentState,
                barHeight: barHeight,
                screenHeight: screenHeight,
                game: game,
                deck: deck,
                isWebButton: isWebButton,
                buttonHeight: buttonHeight,
                isWeb: isWeb,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildWebLayout() {
    final selectCardPlayer = game.selectCardPlayer.reversed.toList();
    final selectCardMachine = game.selectCardMachine.reversed.toList();
    final cardWidth = (MediaQuery.of(context).size.width) * 0.25;
    final listCard = (MediaQuery.of(context).size.height);

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: _buildLabel(
                          TextStylesEnum.sizeNo18Responsive,
                          FontWeight.w700,
                          kColorWhite,
                          game.playerPoint.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: listCard + cardWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(selectCardPlayer.length, (index) {
                        final card = selectCardPlayer[index]?.cards[0];
                        final topOffset = index * (cardWidth * 0.20);
                        return Positioned(
                          top: topOffset,
                          child: Image.network(card?.image ?? '', height: cardWidth),
                        );
                      }).reversed.toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://www.deckofcardsapi.com/static/img/back.png'),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: _buildLabel(
                          TextStylesEnum.sizeNo18Responsive,
                          FontWeight.w700,
                          kColorWhite,
                          game.machinePoint.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: listCard + cardWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(selectCardMachine.length, (index) {
                        final card = selectCardMachine[index]?.cards[0];
                        final topOffset = index * (cardWidth * 0.20);
                        return Positioned(
                          top: topOffset,
                          child: Image.network(card?.image ?? '', height: cardWidth),
                        );
                      }).reversed.toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    final cardWidth = (MediaQuery.of(context).size.width) * 0.25;
    final totalWidth = MediaQuery.of(context).size.width;
    final selectCardPlayer = game.selectCardPlayer.toList();
    final selectCardMachine = game.selectCardMachine.toList();
    final mobileLayout = game.isMobileLayout(context);
    widthSizeBox += cardWidth * selectCardPlayer.length;

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            width: totalWidth + (cardWidth * selectCardMachine.length),
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: totalWidth + (cardWidth * selectCardMachine.length),
                child: Stack(
                  children: List.generate(selectCardMachine.length, (index) {
                    final card = selectCardMachine[index]?.cards[0];
                    return Positioned(
                      left: (selectCardMachine.length - 1 - index) * (cardWidth * 0.2),
                      child: Image.network(card?.image ?? '', width: cardWidth),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: _buildLabel(
                        mobileLayout ? TextStylesEnum.sizeNo18Responsive : TextStylesEnum.sizeNo18Responsive,
                        FontWeight.w700,
                        kColorWhite,
                        game.machinePoint.toString(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.network('https://www.deckofcardsapi.com/static/img/back.png', width: cardWidth),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: _buildLabel(
                        mobileLayout ? TextStylesEnum.sizeNo18Responsive : TextStylesEnum.sizeNo18Responsive,
                        FontWeight.w700,
                        kColorWhite,
                        game.playerPoint.toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            width: totalWidth + (cardWidth * selectCardPlayer.length),
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: totalWidth + (cardWidth * selectCardPlayer.length),
                child: Stack(
                  children: List.generate(selectCardPlayer.length, (index) {
                    final card = selectCardPlayer[index]?.cards[0];
                    return Positioned(
                      left: (selectCardPlayer.length - 1 - index) * (cardWidth * 0.2),
                      child: Image.network(card?.image ?? '', width: cardWidth),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

