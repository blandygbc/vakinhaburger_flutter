import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/routes/routes_names.dart';
import 'package:vakinhaburger/app/pages/auth/login/login_page.dart';
import 'package:vakinhaburger/app/pages/auth/register/register_page.dart';
import 'package:vakinhaburger/app/pages/home/home_router.dart';
import 'package:vakinhaburger/app/pages/product_detail/product_detail_router.dart';
import 'package:vakinhaburger/app/pages/splash/splash_page.dart';

Map<String, WidgetBuilder> appRoutes = {
  RoutesNames.splashPage: (context) => const SplashPage(),
  RoutesNames.homePage: (context) => HomeRouter.page,
  RoutesNames.productDetailPage: (context) => ProductDetailRouter.page,
  RoutesNames.loginPage: (context) => const LoginPage(),
  RoutesNames.registerPage: (context) => const RegisterPage(),
};
