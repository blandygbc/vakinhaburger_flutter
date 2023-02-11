import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/global/global_context.dart';
import 'package:vakinhaburger/app/core/provider/application_binding.dart';
import 'package:vakinhaburger/app/core/theme/theme_config.dart';
import 'package:vakinhaburger/app/core/routes/routes.dart';

class VakinhaBurgerApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();
  VakinhaBurgerApp({super.key}) {
    GlobalContext.instance.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'VakinhaBurger',
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        routes: appRoutes,
      ),
    );
  }
}
