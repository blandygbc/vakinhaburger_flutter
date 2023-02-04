import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/constants/app_assets.dart';
import 'package:vakinhaburger/app/core/routes/routes_names.dart';
import 'package:vakinhaburger/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinhaburger/app/core/ui/styles/colors_app.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: ColorsApp.instance.splashBackground,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWith,
                child: Image.asset(
                  AppAssets.imagesLanche,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imagesLogo,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  DeliveryButton(
                    width: context.percentWidth(.6),
                    height: 35,
                    label: 'Acessar',
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(RoutesNames.homePage),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
