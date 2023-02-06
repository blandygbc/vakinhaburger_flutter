import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/constants/app_assets.dart';
import 'package:vakinhaburger/app/core/ui/base_state/base_state.dart';
import 'package:vakinhaburger/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';
import 'package:vakinhaburger/app/models/product_model.dart';
import 'package:vakinhaburger/app/pages/order/order_controller.dart';
import 'package:vakinhaburger/app/pages/order/order_state.dart';
import 'package:vakinhaburger/app/pages/order/widget/order_field.dart';
import 'package:vakinhaburger/app/pages/order/widget/order_product_tile.dart';
import 'package:vakinhaburger/app/pages/order/widget/payment_types_field.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  @override
  void onReady() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Text(
                  'Carrinho',
                  style: context.textStyles.textTitle,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppAssets.imagesTrashRegular),
                ),
              ],
            ),
          ),
        ),
        BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
          selector: (state) => state.orderProducts,
          builder: (context, orderProducts) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: orderProducts.length,
                (context, index) {
                  final orderProduct = orderProducts[index];
                  return Column(
                    children: [
                      OrderProductTile(
                        index: index,
                        orderProductDto: orderProduct,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total do Pedido:',
                    style:
                        context.textStyles.textExtraBold.copyWith(fontSize: 16),
                  ),
                  Text(
                    'R\$ 124',
                    style:
                        context.textStyles.textExtraBold.copyWith(fontSize: 22),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            OrderField(
              title: 'Endereço de Entrega',
              hintText: 'Digite o endereço',
              controller: TextEditingController(),
              validator: Validatorless.required('m'),
            ),
            const SizedBox(height: 15),
            OrderField(
              title: 'CPF',
              hintText: 'Digite o seu CPF',
              controller: TextEditingController(),
              validator: Validatorless.required('m'),
            ),
            const PaymentTypesField(),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DeliveryButton(
                  label: 'FINALIZAR',
                  width: context.screenWith,
                  height: 48,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
