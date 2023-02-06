import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';
import 'package:vakinhaburger/app/pages/order/order_state.dart';

class OrderController extends Cubit<OrderState> {
  OrderController() : super(OrderState.initial());

  void load(List<OrderProductDto> products) {
    emit(state.copyWith(orderProducts: products));
  }
}
