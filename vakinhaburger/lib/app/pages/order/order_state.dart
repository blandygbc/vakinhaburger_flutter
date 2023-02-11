import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:vakinhaburger/app/dto/order_product_dto.dart';
import 'package:vakinhaburger/app/models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
  updateOrder,
  confirmRemoveProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentTypes;
  final String? errorMessage;
  const OrderState({
    required this.status,
    required this.orderProducts,
    required this.paymentTypes,
    this.errorMessage,
  });
  const OrderState.initial()
      : status = OrderStatus.initial,
        paymentTypes = const [],
        orderProducts = const [],
        errorMessage = null;
  @override
  List<Object?> get props =>
      [status, orderProducts, paymentTypes, errorMessage];

  double get totalOrder => orderProducts.fold(
      0, (previousValue, element) => previousValue + element.totalPrice);

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto orderProduct;
  final int index;

  const OrderConfirmDeleteProductState({
    required super.status,
    required super.orderProducts,
    required super.paymentTypes,
    required this.orderProduct,
    required this.index,
    super.errorMessage,
  });
}
