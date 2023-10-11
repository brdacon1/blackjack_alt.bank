import 'package:flutter/material.dart';

double? calculateHeight(double height, BuildContext context) {
  double guidelineBaseHeight = 1920;
  double screenHeight = MediaQuery.of(context).size.height;
  return (screenHeight / guidelineBaseHeight) * height;
}