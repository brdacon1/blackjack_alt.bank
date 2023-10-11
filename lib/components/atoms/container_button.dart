import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';
import 'custom_text_size.dart';

class ContainerButton extends StatelessWidget {
  final Widget child;
  final TextStylesEnum labelTextStyle;
  final TextAlign labelTextAlign;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Function() onTap;
  final Color? borderColor;
  final Color? backgroundColor;
  final double width;
  final double? height;
  final double? borderRadius;
  const ContainerButton(
      {required this.child,
        this.labelTextStyle = TextStylesEnum.size28bold,
        this.labelTextAlign = TextAlign.center,
        this.prefixIcon,
        this.sufixIcon,
        required this.onTap,
        this.borderColor,
        this.backgroundColor,
        this.width = 499,
        this.height,
        this.borderRadius,
        super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 13),
          border: Border.all(
              width: kBorderButton, color: borderColor ?? kPrimaryColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
