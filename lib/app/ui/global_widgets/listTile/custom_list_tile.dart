import 'package:flutter/material.dart';
import '../text/price_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final Function() onTap;

  const CustomListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PriceText(
                    price: price,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).dividerColor,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
