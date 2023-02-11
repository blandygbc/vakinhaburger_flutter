import 'package:vakinhaburger/app/dto/order_product_dto.dart';

class OrderDto {
  List<OrderProductDto> products;
  String address;
  String cpf;
  int paymentMethodId;
  OrderDto({
    required this.products,
    required this.address,
    required this.cpf,
    required this.paymentMethodId,
  });
}
