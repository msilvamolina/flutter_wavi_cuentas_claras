import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class PriceText extends StatelessWidget {
  final double fontSize;
  final double price;
  final Color? color;
  const PriceText({
    Key? key,
    required this.price,
    this.fontSize = 20,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _newPrice = price;
    if (price < 0) {
      _newPrice = price * -1;
    }

    String total = Utils.convertMoneyString(_newPrice);
    final totalSplited = total.split(',');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          totalSplited[0],
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        if (totalSplited.length > 1) ...[
          Padding(
            padding: EdgeInsets.only(left: fontSize / 8),
            child: Opacity(
              opacity: 0.5,
              child: Text(
                totalSplited[1],
                style: TextStyle(
                  fontSize: fontSize / 1.6,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
