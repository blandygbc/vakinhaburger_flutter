import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinhaburger/app/core/constants/app_assets.dart';
import 'package:vakinhaburger/app/core/extensions/formatter_extension.dart';
import 'package:vakinhaburger/app/core/routes/routes_names.dart';
import 'package:vakinhaburger/app/core/ui/base_state/base_state.dart';
import 'package:vakinhaburger/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinhaburger/app/dto/order_dto.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';
import 'package:vakinhaburger/app/models/payment_type_model.dart';
import 'package:vakinhaburger/app/pages/order/order_controller.dart';
import 'package:vakinhaburger/app/pages/order/order_state.dart';
import 'package:vakinhaburger/app/pages/order/widget/order_field.dart';
import 'package:vakinhaburger/app/pages/order/widget/order_product_tile.dart';
import 'package:vakinhaburger/app/pages/order/widget/payment_types_field.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final formKey = GlobalKey<FormState>();
  final _adressEC = TextEditingController();
  final _cpfEC = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);
  @override
  void onReady() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja excluir o ${state.orderProduct.product.name}?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.cancelDeleteProcess();
                },
                child: Text(
                  'Cancelar',
                  style: context.textStyles.textMedium,
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.decrementProduct(state.index);
                },
                child: Text(
                  'Confirmar',
                  style: context.textStyles.textExtraBold
                      .copyWith(color: Colors.red),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage ?? 'Erro não previsto');
          },
          confirmRemoveProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmProductDialog(state);
            }
          },
          emptyBag: () {
            showInfo(
                'Sua sacola está vazia, por favor adicione um produto para realizar seu pedido.');
            Navigator.pop(context, <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            Navigator.of(context).popAndPushNamed(RoutesNames.orderCompleted,
                result: <OrderProductDto>[]);
          },
        );
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: Form(
            key: formKey,
            child: CustomScrollView(slivers: [
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
                        onPressed: () => controller.emptyBag(),
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do Pedido:',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 16),
                            ),
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, totalOrder) {
                                return Text(
                                  totalOrder.currencyPTBR,
                                  style: context.textStyles.textExtraBold
                                      .copyWith(fontSize: 22),
                                );
                              },
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
                        controller: _adressEC,
                        validator:
                            Validatorless.required('Endereço é obrigatório'),
                      ),
                      const SizedBox(height: 15),
                      OrderField(
                        title: 'CPF',
                        hintText: 'Digite o seu CPF',
                        controller: _cpfEC,
                        validator: Validatorless.required('CPF é obrigatório'),
                      ),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypeModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                              valueListenable: paymentTypeValid,
                              builder: (context, paymentTypeValidValue, child) {
                                return PaymentTypesField(
                                  paymentTypes: paymentTypes,
                                  valueChanged: (value) {
                                    paymentTypeId = value;
                                  },
                                  valid: paymentTypeValidValue,
                                  valueSelected: paymentTypeId.toString(),
                                );
                              });
                        },
                      ),
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
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          final paymentTypeSelected = paymentTypeId != null;
                          paymentTypeValid.value = paymentTypeSelected;
                          if (valid && paymentTypeSelected) {
                            controller.saveOrder(
                              address: _adressEC.text,
                              cpf: _cpfEC.text,
                              paymentMethodId: paymentTypeId!,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
