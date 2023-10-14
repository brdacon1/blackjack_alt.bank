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


  filterNotify(TypePopupEnum popupEnum, BuildContext context, Game game) async {
    switch (popupEnum) {
      case TypePopupEnum.CONGRATULATIONS:
         await notificationCongratulations(context, popupEnum.description, game);
         break;
      case TypePopupEnum.LOSE:
          await notificationLose(context, popupEnum.description);
          break;
      case TypePopupEnum.TIED:
           await notificationTied(context, popupEnum.description);
           break;
      case TypePopupEnum.ERROR:
           await notificationError(context, popupEnum.description);
           break;
      case TypePopupEnum.WAIT:
           await notificationWait(context, popupEnum.description);
           break;
      default:
        return await notificationWait(context, popupEnum.description);
    }
  }

  Future<void> notificationCongratulations(BuildContext context, String? message, Game game) async {
    if (context.mounted) {
      final buttonHeight = game.calculateButtonHeight(context);
      await Dialogs.materialDialog(
          color: Colors.white,
          msg: 'Parabéns, você venceu!',
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

  Future<void> notificationLose(BuildContext context, String? message) async {
    if (context.mounted) {

    }

  }

  Future<void> notificationTied(BuildContext context, String? message) async {
    if (context.mounted) {

    }

  }

  Future<void> notificationError(BuildContext context, String? message)async {
    if (context.mounted) {

    }
  }

  Future<void> notificationWait(BuildContext context, String? message) async {
    if (context.mounted) {

    }

  }
}