import 'package:flutter/material.dart';

double calculateWidth(double width, BuildContext context) {
  double guidelineBaseWidth = 1080.0;

  return (MediaQuery.of(context).size.width / guidelineBaseWidth) * width;
}