import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinhaburger/app/pages/order/order_controller.dart';
import 'package:vakinhaburger/app/pages/order/order_page.dart';
import 'package:vakinhaburger/app/repositories/order/order_repository.dart';
import 'package:vakinhaburger/app/repositories/order/order_repository_impl.dart';

class OrderRouter {
  OrderRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider<OrderController>(
            create: (context) => OrderController(context.read()),
          ),
        ],
        child: const OrderPage(),
      );
}
