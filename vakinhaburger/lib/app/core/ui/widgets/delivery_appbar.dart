import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/constants/app_constants.dart';

class DeliveryAppbar extends AppBar {
  DeliveryAppbar({
    super.key,
    double elevation = 1,
  }) : super(
          elevation: elevation,
          title: Image.asset(
            AppConstants.imagesLogo,
            width: 80,
          ),
        );
}
