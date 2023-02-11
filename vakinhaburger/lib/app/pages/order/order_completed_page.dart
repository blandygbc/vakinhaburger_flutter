import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/constants/app_assets.dart';
import 'package:vakinhaburger/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_button.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentWidth(.3),
              ),
              Image.asset(AppAssets.imagesLogoRounded),
              SizedBox(
                height: context.percentWidth(.05),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido!',
                  textAlign: TextAlign.center,
                  style: context.textStyles.textBold.copyWith(fontSize: 18),
                ),
              ),
              SizedBox(
                height: context.percentWidth(.05),
              ),
              DeliveryButton(
                width: context.percentWidth(.8),
                height: 48,
                label: 'FECHAR',
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
