import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/main_controller.dart';
import '../text/price_text.dart';

class CustomListFullPriceTile extends StatelessWidget {
  final String title;
  final int amountPersons;
  final String subtitle;
  final double price;
  final double putMoney;
  final Function() onTap;
  final Function() onLongPress;

  const CustomListFullPriceTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.amountPersons,
    required this.price,
    required this.putMoney,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double subtotal = putMoney - price;
    double total = subtotal / amountPersons;

    String _newTitle = title;
    String _stringTotal = total > 0 ? 'Le devuelven' : "Tiene que poner";
    String _gasto = 'gastó';
    String _tendriaQuePoner = 'tendría que poner';
    if (amountPersons > 1) {
      _newTitle = _newTitle + ' (' + amountPersons.toString() + ')';
      _stringTotal =
          total > 0 ? 'A cada uno le devuelven' : "Cada uno tienen que poner";
      _gasto = 'gastaron';
      _tendriaQuePoner = 'tendrían que poner en total';
    }

    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _newTitle,
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
                  GetBuilder<MainController>(
                    id: 'viewFullResumeController',
                    builder: (_c) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (_c.viewFullResume) ...[
                            if (putMoney > 0) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Text(
                                      _gasto,
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  PriceText(
                                    color: Colors.grey,
                                    price: putMoney,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Text(
                                      _tendriaQuePoner,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  PriceText(
                                    color: Colors.grey,
                                    price: price,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                            if (amountPersons > 1)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2),
                                    child: Text(
                                      total > 0
                                          ? 'En total le devuelven'
                                          : "En total tienen que poner",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  PriceText(
                                    color: Colors.grey,
                                    price: subtotal,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                          ],
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  _stringTotal,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        total > 0 ? Colors.green : Colors.red,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                color: total > 0 ? Colors.green : Colors.red,
                                child: PriceText(
                                  color: Colors.white,
                                  price: total,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).dividerColor,
            )
          ],
        ),
      ),
    );
  }
}
