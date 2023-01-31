import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  double get screenWith => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double percentWidth(double percent) => screenWith * percent;
  double percentHeight(double percent) => screenHeight * percent;
}
