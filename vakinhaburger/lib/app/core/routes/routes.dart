import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/pages/home/home_router.dart';
import 'package:vakinhaburger/app/pages/splash/splash_page.dart';
import 'package:vakinhaburger/app/core/constants/app_constants.dart';

Map<String, WidgetBuilder> appRoutes = {
  AppConstants.routeSplashPage: (context) => const SplashPage(),
  AppConstants.routeHomePage: (context) => HomeRouter.page,
};
