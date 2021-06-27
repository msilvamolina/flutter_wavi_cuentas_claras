import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/expenses_controller.dart';
import '../../../controllers/helpers/helpers.dart';
import '../../../controllers/main_controller.dart';
import '../../global_widgets/text/price_text.dart';
import '../../theme/palettes/palette_button.dart';

class CustomBottomNavigationBar extends GetView<ExpensesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 6),
          )
        ],
      ),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GetBuilder<MainController>(
              id: 'bottomTotal',
              builder: (_c) {
                return Obx(() {
                  double total = Helpers.getExpensesTotal(_c.listExpenses);
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          PriceText(price: total),
                        ],
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: PaletteButton.generalButton(),
                          onPressed: (total > 0 &&
                                  _c.listExpenses.length > 1 &&
                                  _c.listExpenses.length > 1)
                              ? controller.calculate
                              : null,
                          child: Text('CALCULAR'),
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
