import 'package:blackjack/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/atoms/container_button.dart';
import '../components/atoms/custom_text_size.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    deck = Provider.of<Deck>(context, listen: false);
    game = Provider.of<Game>(context, listen: false);
    super.didChangeDependencies();
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

    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
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
              child: isWebButton
                  ? Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                   ContainerButton(
                    width: 300,
                    height: buttonHeight,
                    borderRadius: 50,
                    backgroundColor: kGreenDarkColor,
                    borderColor: kColorWhite,
                    onTap: () async {
                      game.selectCardPlayer.add(await deck.getBuyCards(game.deckGame?.deckId));
                      game.calculatePointCards(false);
                      setState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: kColorWhite,
                          size: 60,
                        ),
                        SizedBox(width: 5),
                        CustomTextSize(
                          'Comprar carta',
                          textStyle: TextStylesEnum.sizeNo18Responsive,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: kColorWhite,
                        ),
                      ],
                    ),
                  ),
                   ContainerButton(
                    width: 300,
                    height: buttonHeight,
                    borderRadius: 50,
                    backgroundColor: kRedColor,
                    borderColor: kColorWhite,
                    onTap: () async {
                      game.selectCardMachine.add(await deck.getBuyCards(game.deckGame?.deckId));
                      game.calculatePointCards(true);
                      setState(() {});
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.back_hand,
                          color: kColorWhite,
                          size: 25,
                        ),
                        SizedBox(width: 8),
                        CustomTextSize(
                          'Passar a vez',
                          textStyle: TextStylesEnum.sizeNo18Responsive,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: kColorWhite,
                        ),
                      ],
                     ),
                   ),
                  ],
                 ) : Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                   Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ContainerButton(
                        width: double.infinity,
                        height: buttonHeight,
                        borderRadius: 50,
                        backgroundColor: kGreenDarkColor,
                        borderColor: kColorWhite,
                        onTap: () async {
                          game.selectCardPlayer.add(await deck.getBuyCards(game.deckGame?.deckId));
                          game.calculatePointCards(false);
                          setState(() {});
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.arrow_drop_down_sharp,
                              color: kColorWhite,
                              size: 60,
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
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ContainerButton(
                        width: double.infinity,
                        height: buttonHeight,
                        borderRadius: 50,
                        backgroundColor: kRedColor,
                        borderColor: kColorWhite,
                        onTap: () async {
                          game.selectCardMachine.add(await deck.getBuyCards(game.deckGame?.deckId));
                          game.calculatePointCards(true);
                          setState(() {});
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.back_hand,
                              color: kColorWhite,
                            ),
                            SizedBox(width: 8),
                            CustomTextSize(
                              'Passar a vez',
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
                ],
              )
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
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    final cardWidth = (MediaQuery.of(context).size.width) * 0.25;
    final selectCardPlayer = game.selectCardPlayer.toList();
    final selectCardMachine = game.selectCardMachine.toList();
    final mobileLayout = game.isMobileLayout(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: cardWidth * selectCardMachine.length,
                child: Stack(
                  children: List.generate(selectCardMachine.length, (index) {
                    final card = selectCardMachine[index]?.cards[0];
                    return Positioned(
                      left: index * (cardWidth * 0.2),
                      child: Image.network(card?.image ?? '', width: cardWidth),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 40,
                    height: 40,
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
              const SizedBox(height: 20,),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.network('https://www.deckofcardsapi.com/static/img/back.png', width: cardWidth),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 40,
                    height: 40,
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
        const SizedBox(height: 20,),
        _buildLabel(
          mobileLayout ? TextStylesEnum.sizeNo18Responsive : TextStylesEnum.sizeNo18Responsive,
          FontWeight.w700,
          kColorWhite,
          game.playerName ?? '',
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: cardWidth * selectCardPlayer.length,
                child: Stack(
                  children: List.generate(selectCardPlayer.length, (index) {
                    final card = selectCardPlayer[index]?.cards[0];
                    return Positioned(
                      left: index * (cardWidth * 0.2),
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

