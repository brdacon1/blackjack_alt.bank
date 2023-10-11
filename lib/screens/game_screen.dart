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

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 1100;
    final isWebButton = MediaQuery.of(context).size.width > 598;
    final screenHeight = MediaQuery.of(context).size.height;
    final barHeight = screenHeight * 0.10;
    final buttonHeight = game.calculateButtonHeight(context);

    return Scaffold(
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
                    onTap: () {

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
                        onTap: () {

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
                        onTap: () {},
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
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Consumer<Game>(
                  builder: (context, provider, _) {
                    final reversedList = provider.selectCardPlayer.reversed.toList();
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: List.generate(reversedList.length, (index) {
                          final card = reversedList[index]?.cards[0];
                          if (card != null) {
                            return Image.network(card.image);
                          }
                          return Container();
                        }),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Container(color: Colors.red),
              ),
              Expanded(
                child: Container(color: Colors.green),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Container(color: Colors.blue),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(color: Colors.red),
              ),
              Expanded(
                child: Container(color: Colors.green),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: <Widget>[
                Consumer<Game>(
                  builder: (context, provider, _) {
                    final reversedList = provider.selectCardPlayer.reversed.toList();
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        alignment: WrapAlignment.start,
                        children: List.generate(reversedList.length, (index) {
                          final card = reversedList[index]?.cards[0];
                          if (card != null) {
                            return Image.network(card.image, scale: 800,);
                          }
                          return Container();
                        }),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

