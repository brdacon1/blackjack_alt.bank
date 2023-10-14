import 'package:blackjack/enums/enums.dart';
import 'package:blackjack/providers/game.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../../constants/colors.dart';
import 'container_button.dart';
import 'custom_text_size.dart';


class PopupGame {
  bool _isLoading = false;

  filterNotify(TypePopupEnum popupEnum, BuildContext context, Game game) async {
    switch (popupEnum) {
      case TypePopupEnum.CONGRATULATIONS:
          notificationCongratulations(context, game);
         break;
      case TypePopupEnum.LOSE:
           notificationLose(context, game);
          break;
      case TypePopupEnum.TIED:
            notificationTied(context, game);
           break;
      case TypePopupEnum.ERROR:
            notificationError(context, game);
           break;
      case TypePopupEnum.WAIT:
            notificationWait(context, game);
           break;
      case TypePopupEnum.CLOSE_WAIT:
           closeLoading(context);
           break;
      default:
        return notificationWait(context, game);
    }
  }

  Future<void> notificationCongratulations(BuildContext context, Game game) async {
    if (context.mounted) {
      final buttonHeight = game.calculateButtonHeight(context);
      await Dialogs.materialDialog(
          dialogWidth: 20,
          color: Colors.white,
          msg: 'Parabéns, você venceu a partida!',
          title: 'Parabéns!',
          lottieBuilder: Lottie.asset(
            'assets/cong_example.json',
            fit: BoxFit.contain,
          ),
          customViewPosition: CustomViewPosition.BEFORE_ACTION,
          context: context,
          actions: [
            ContainerButton(
              width: 250,
              height: buttonHeight,
              borderRadius: 50,
              backgroundColor: kColorGreen,
              borderColor: kColorWhite,
              onTap: () async {
                Navigator.pop(context, true);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: kColorWhite,
                    size: 25,
                  ),
                  SizedBox(width: 8),
                  CustomTextSize(
                    'OK',
                    textStyle: TextStylesEnum.sizeNo18Responsive,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: kColorWhite,
                  ),
                ],
              ),
            ),
      ]);
    }
  }

  Future<void> notificationLose(BuildContext context, Game game) async {
    if (context.mounted) {
      final buttonHeight = game.calculateButtonHeight(context);
       Dialogs.materialDialog(
          dialogWidth: 20,
          color: Colors.white,
          msg: 'Não foi desta vez, você perdeu a partida!',
          title: 'Você perdeu a partida!',
          customViewPosition: CustomViewPosition.BEFORE_ACTION,
          context: context,
          actions: [
            Column(children: [
              Image.asset(
                'assets/ops.png',
                fit: BoxFit.contain,
                width: 120,
              ),
              ContainerButton(
                width: 250,
                height: buttonHeight,
                borderRadius: 50,
                backgroundColor: kRedColor,
                borderColor: kColorWhite,
                onTap: () async {
                  Navigator.pop(context, true);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: kColorWhite,
                      size: 25,
                    ),
                    SizedBox(width: 8),
                    CustomTextSize(
                      'OK',
                      textStyle: TextStylesEnum.sizeNo18Responsive,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      color: kColorWhite,
                    ),
                  ],
                ),
              ),
            ],
         )
       ]);
    }
  }

  Future<void> notificationTied(BuildContext context, Game game) async {
    if (context.mounted) {
      final buttonHeight = game.calculateButtonHeight(context);
      Dialogs.materialDialog(
          dialogWidth: 20,
          color: kColorWhite,
          msg: 'Empate, a partida foi empatada!',
          title: 'Empata na partida!',
          customViewPosition: CustomViewPosition.BEFORE_ACTION,
          context: context,
          actions: [
            Column(children: [
              ContainerButton(
                width: 250,
                height: buttonHeight,
                borderRadius: 50,
                backgroundColor: kColorOrange,
                borderColor: kColorOrange,
                onTap: () async {
                  Navigator.pop(context, true);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: kColorWhite,
                      size: 25,
                    ),
                    SizedBox(width: 8),
                    CustomTextSize(
                      'OK',
                      textStyle: TextStylesEnum.sizeNo18Responsive,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      color: kColorWhite,
                    ),
                  ],
                ),
              ),
             ],
            )
          ]
      );
    }
  }

  Future<void> notificationError(BuildContext context, Game game)async {
    if (context.mounted) {
      final buttonHeight = game.calculateButtonHeight(context);
      Dialogs.materialDialog(
          dialogWidth: 20,
          color: Colors.white,
          msg: 'Algo deu erro!',
          title: 'Tente novamente!',
          customViewPosition: CustomViewPosition.BEFORE_ACTION,
          context: context,
          actions: [
            Column(children: [
              ContainerButton(
                width: 250,
                height: buttonHeight,
                borderRadius: 50,
                backgroundColor: kRedColor,
                borderColor: kColorWhite,
                onTap: () async {
                  Navigator.pop(context, true);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: kColorWhite,
                      size: 25,
                    ),
                    SizedBox(width: 8),
                    CustomTextSize(
                      'OK',
                      textStyle: TextStylesEnum.sizeNo18Responsive,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      color: kColorWhite,
                    ),
                  ],
                ),
              ),
            ])
          ]
      );
    }
  }

  Future<void> notificationWait(BuildContext context, Game game) async {
    _isLoading = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    color: kColorGreyDark,
                    strokeWidth: 5,
                  ),
                  SizedBox(height: 16),
                  CustomTextSize(
                    'Aguarde...',
                    textStyle: TextStylesEnum.size36bold,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: kColorGreyDark,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      _isLoading = false;
    });
  }

  void  closeLoading(BuildContext context) {
    if (_isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}