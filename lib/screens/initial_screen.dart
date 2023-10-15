import 'package:blackjack/enums/enums.dart';
import 'package:blackjack/utils/calculate_height.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/atoms/container_button.dart';
import '../components/atoms/custom_text_size.dart';
import '../components/atoms/popup_game.dart';
import '../constants/colors.dart';
import '../providers/deck.dart';
import '../providers/game.dart';
import 'game_screen.dart';

class InitialScreen extends StatefulWidget {
  static const routeName = '/initial-screen';
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() {
    return _InitialScreen();
  }
}

class _InitialScreen extends State<InitialScreen> {
  late Deck deck;
  late Game game;
  late PopupGame showPopup;

  @override
  void initState() {
    deck = Provider.of<Deck>(context, listen: false);
    game = Provider.of<Game>(context, listen: false);
    game.cleanProvider();
    deck.cleanProvider();
    showPopup = PopupGame();
    super.initState();
  }

  @override
  void didChangeDependencies() {
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

  Widget _buildImage() {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        height: 500,
        child: Image.asset(
          'assets/blackjack.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildButton() {
    final mobileLayout = game.isMobileLayout(context);
    final buttonHeight = game.calculateButtonHeight(context);

    return Center(
      child: mobileLayout
          ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ContainerButton(
            width: double.infinity,
            height: buttonHeight,
            borderRadius: 50,
            backgroundColor: kPrimaryColor,
            borderColor: kColorWhite,
            child: _buildLabel(
              TextStylesEnum.sizeNo18Responsive,
              FontWeight.w700,
              kColorWhite,
              "Iniciar jogo",
            ),
            onTap: () {
              showPopup.filterNotify(TypePopupEnum.WAIT, context, game);
              deck.getNewDeck().then((result) {
                game.deckGame = result;
                Navigator.of(context).pushNamed(GameScreen.routeName);
              });
            },
          ),
        ],
      ) : Row(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ContainerButton(
            width: 200,
            height: buttonHeight,
            borderRadius: 50,
            backgroundColor: kPrimaryColor,
            borderColor: kColorWhite,
            child: const CustomTextSize(
              'Iniciar Jogo',
              textStyle: TextStylesEnum.size18Medium,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              color: kColorWhite,
            ),
            onTap: () async {
              showPopup.filterNotify(TypePopupEnum.WAIT, context, game);
              deck.getNewDeck().then((value) => {
                game.deckGame = value,
                showPopup.filterNotify(TypePopupEnum.CLOSE_WAIT, context, game),
                Navigator.of(context).pushNamed(GameScreen.routeName)
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = isPortrait ? screenWidth * 0.9 : screenWidth * 0.5;
    final mobileLayout = game.isMobileLayout(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.5),
              ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: calculateHeight(100, context)),
                      _buildLabel(
                        mobileLayout ? TextStylesEnum.sizeNo36Responsive : TextStylesEnum.size28Medium,
                        FontWeight.w700,
                        kColorWhite,
                        "Bem-vindo ao",
                      ),
                      _buildLabel(
                        mobileLayout ? TextStylesEnum.sizeNo24Responsive : TextStylesEnum.size24Medium,
                        FontWeight.w200,
                        kColorWhite,
                        "Blackjack",
                      ),
                    ],
                  ),
                ),
              ),
              _buildImage(),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: calculateHeight(100, context)),
                      SizedBox(
                        width: cardWidth,
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Column(
                              children: <Widget>[
                                _buildLabel(
                                  mobileLayout ? TextStylesEnum.sizeNo20Responsive : TextStylesEnum.size20Medium,
                                  FontWeight.w800,
                                  kColorGray,
                                  "Vamos começar?",
                                ),
                                SizedBox(height: calculateHeight(150, context)),
                                _buildButton(),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
