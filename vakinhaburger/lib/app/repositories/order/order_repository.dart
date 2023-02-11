import 'package:vakinhaburger/app/dto/order_dto.dart';
import 'package:vakinhaburger/app/models/payment_type_model.dart';

abstract class OrderRepository {
  Future<List<PaymentTypeModel>> getAllPaymentsTypes();
  Future<void> saveOrder(OrderDto order);
}
