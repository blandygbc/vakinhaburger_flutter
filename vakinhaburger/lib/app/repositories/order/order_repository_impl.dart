import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinhaburger/app/core/constants/api_endpoints.dart';
import 'package:vakinhaburger/app/core/exceptions/repository_exception.dart';
import 'package:vakinhaburger/app/core/rest_client/custom_dio.dart';
import 'package:vakinhaburger/app/dto/order_dto.dart';
import 'package:vakinhaburger/app/models/payment_type_model.dart';
import 'package:vakinhaburger/app/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get(ApiEndpoints.paymentTypes);
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post(ApiEndpoints.orders, data: {
        'products': order.products
            .map((e) => {
                  'id': e.product.id,
                  'amount': e.amount,
                  'total_price': e.totalPrice
                })
            .toList(),
        'user_id': '#userAuthRef',
        'address': order.address,
        'CPF': order.cpf,
        'payment_method_id': order.paymentMethodId
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar o pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar o pedido');
    }
  }
}
