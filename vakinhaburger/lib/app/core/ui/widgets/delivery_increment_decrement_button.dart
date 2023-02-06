import 'package:flutter/material.dart';
import 'package:vakinhaburger/app/core/ui/styles/colors_app.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final bool _compact;
  final int amount;
  final VoidCallback incrementOnTap;
  final VoidCallback decrementOnTap;

  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amount,
    required this.incrementOnTap,
    required this.decrementOnTap,
  }) : _compact = false;

  const DeliveryIncrementDecrementButton.compact({
    super.key,
    required this.amount,
    required this.incrementOnTap,
    required this.decrementOnTap,
  }) : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(4) : null,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrementOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '-',
                style: context.textStyles.textMedium.copyWith(
                  fontSize: _compact ? 16 : 22,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(amount.toString(),
                style: context.textStyles.textMedium.copyWith(
                  fontSize: _compact ? 14 : 22,
                  color: context.colors.secondary,
                )),
          ),
          InkWell(
            onTap: incrementOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('+',
                  style: context.textStyles.textMedium.copyWith(
                    fontSize: _compact ? 16 : 22,
                    color: Colors.grey,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
