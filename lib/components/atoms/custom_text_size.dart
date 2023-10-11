import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../utils/calcule_width.dart';

class CustomTextSize extends StatelessWidget {
  final String text;
  final Color? color;
  final bool wrap;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextStylesEnum textStyle;
  final double? width;
  final double widthBaseFontSize;
  final double heightBaseFontSize;
  final TextDecoration? decoration;
  final bool colorInvert;

  const CustomTextSize(this.text,
      {this.textStyle = TextStylesEnum.size12Medium,
        this.width,
        this.widthBaseFontSize = 1280.0,
        this.heightBaseFontSize = 800.0,
        this.color = kColorTextGrayT,
        this.wrap = false,
        this.overflow = TextOverflow.visible,
        this.textAlign = TextAlign.start,
        this.fontWeight = FontWeight.normal,
        this.decoration = TextDecoration.none,
        this.colorInvert = false,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color newColor =
    colorInvert ? kTextInverseWhite : color ?? kTextColorGray;
    return width != null
        ? SizedBox(
      width: width,
      child: Text(
        text,
        key: key,
        style: getTextStyle(textStyle, fontWeight, widthBaseFontSize,
            heightBaseFontSize, newColor, decoration, context)
            .copyWith(color: colorInvert ? kTextInverseWhite : newColor),
        textAlign: textAlign,
        overflow: overflow,
        softWrap: wrap,
      ),
    )
        : Text(
      text,
      key: key,
      style: getTextStyle(textStyle, fontWeight, widthBaseFontSize,
          heightBaseFontSize, newColor, decoration, context)
          .copyWith(color: newColor),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: wrap,
    );
  }
}

TextStyle getTextStyle(
    TextStylesEnum style,
    FontWeight? fontWeight,
    double? width,
    double? height,
    Color color,
    TextDecoration? decoration,
    BuildContext context) {
  switch (style) {
    case TextStylesEnum.size6Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(6.0, context), //6.0,
          height: 1.3,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size8Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(8.0, context), //8.0,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size10Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(10.0, context), //10.0, //
          height: 1.3,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size12Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(12.0, context), //12.0
          height: 1.3,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size14Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(14.0, context), //14.0,
          height: 1.3,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size16Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(16.0, context), //16.0,
          height: 1.2,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size18Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(16.0, context), //18.0,
          height: 1.2,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size20Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(20.0, context), //20.0,
          height: 1.5,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size22Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(22.0, context), //20.0,
          height: 1.5,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size24Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(24.0, context), //24.0,
          height: 1.6,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size28Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(28.0, context), //28.0,
          height: 1.6,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size30Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(30.0, context), //30.0,
          height: 1.5,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size32Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(32.0, context),
          height: 1.7,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size36Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(36.0, context),
          height: 1.7,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);

    case TextStylesEnum.size40Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(40.0, context),
          height: 1.7,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);

    case TextStylesEnum.size48Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(48.0, context),
          height: 1.7,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);

    case TextStylesEnum.size64Medium:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(64.0, context),
          height: 1.8,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size6bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(6.0, context),
          height: 1.3,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size8bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(8.0, context),
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size10bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(10.0, context),
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size12bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(12.0, context),
          height: 1.3,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size14bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(14.0, context),
          height: 1.4,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size16bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(16.0, context), //16.0,
          height: 1.5,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size20bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(20.0, context), //20.0,
          height: 1.5,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size22bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(22.0, context), //22.0,
          height: 1.5,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size24bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(24.0, context), //24.0,
          height: 1.6,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size26bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(26.0, context), //26.0,
          height: 1.6,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size28bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(28.0, context), //28.0,
          height: 1.6,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size32bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(32.0, context), //32.0,
          height: 1.7,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size36bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(36.0, context), //36.0,
          height: 1.7,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size42bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(42.0, context), //42.0,
          height: 1.7,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size48bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(48.0, context), //48.0,
          height: 1.7,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.size64bold:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(64.0, context), //64.0,
          height: 1.8,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
    case TextStylesEnum.sizeNo36Responsive:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: 32,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.sizeNo18Responsive:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: 15,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    case TextStylesEnum.sizeNo20Responsive:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: 20,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);

    case TextStylesEnum.sizeNo24Responsive:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: 24,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color,
          decoration: decoration);
    default:
      return TextStyle(
          fontFamily: montserrat,
          fontSize: calculateWidth(14.0, context), //14.0,
          height: 1.4,
          fontWeight: FontWeight.bold,
          color: color,
          decoration: decoration);
  }
}

enum TextStylesEnum {
  size6Medium,
  size6bold,
  size8bold,
  size10bold,
  size12bold,
  size14bold,
  size16bold,
  size20bold,
  size22bold,
  size24bold,
  size26bold,
  size28bold,
  size32bold,
  size36bold,
  size42bold,
  size48bold,
  size64bold,
  size8Medium,
  size10Medium,
  size12Medium,
  size14Medium,
  size20Medium,
  size16Medium,
  size18Medium,
  size22Medium,
  size24Medium,
  size28Medium,
  size30Medium,
  size32Medium,
  size36Medium,
  size40Medium,
  size48Medium,
  size64Medium,
  sizeNo36Responsive,
  sizeNo24Responsive,
  sizeNo18Responsive,
  sizeNo20Responsive,
}
