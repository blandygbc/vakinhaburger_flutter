import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/provider/application_binding.dart';
import 'package:vakinhaburger/app/core/theme/theme_config.dart';
import 'package:vakinhaburger/app/core/routes/routes.dart';

class VakinhaBurgerApp extends StatelessWidget {
  const VakinhaBurgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'VakinhaBurger',
        theme: ThemeConfig.theme,
        routes: appRoutes,
      ),
    );
  }
}
