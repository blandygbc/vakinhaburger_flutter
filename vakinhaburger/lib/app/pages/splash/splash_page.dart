import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/config/env/env.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: Column(children: [
        DeliveryButton(
          onPressed: () {},
          label: Env.backendBaseUrl,
          height: 100,
          width: 150,
        ),
        TextFormField(),
      ]),
    );
  }
}
