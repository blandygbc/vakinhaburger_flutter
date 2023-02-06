import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/constants/app_assets.dart';
import 'package:vakinhaburger/app/core/extensions/formatter_extension.dart';
import 'package:vakinhaburger/app/core/ui/styles/colors_app.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto orderProductDto;
  const OrderProductTile({
    super.key,
    required this.index,
    required this.orderProductDto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.network(
            orderProductDto.product.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderProductDto.product.name,
                    style: context.textStyles.textMedium.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (orderProductDto.amount * orderProductDto.product.price)
                            .currencyPTBR,
                        style: context.textStyles.textBold.copyWith(
                            fontSize: 14, color: context.colors.secondary),
                      ),
                      DeliveryIncrementDecrementButton.compact(
                        amount: orderProductDto.amount,
                        incrementOnTap: () {},
                        decrementOnTap: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
