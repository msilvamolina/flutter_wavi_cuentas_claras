import '../../controllers/helpers/helpers.dart';
import '../global_widgets/cards/element_card.dart';
import '../theme/palettes/palette_button.dart';
import '../utils/utils.dart';

import '../layouts/main/widgets/main_layout_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/new_expense_controller.dart';

class NewExpensePage extends GetView<NewExpenseController> {
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    double toolbarSize = 400;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.purple[700],
          foregroundColor: Colors.orange,
          pinned: true,
          expandedHeight: toolbarSize,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Nuevo gasto'),
            background: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 1.2,
                  colors: [
                    Colors.lightGreenAccent,
                    Colors.lightGreen[900]!,
                  ],
                ),
              ),
              child: Image.asset(
                'assets/images/spending.png',
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<NewExpenseController>(
                    id: 'personList',
                    builder: (_c) {
                      return ElementCard(
                        title: '¿Quién pagó?',
                        message: Helpers.getPersonsString(controller.mapPersons,
                                controller.mainController.listParticipants) ??
                            '(Apretá para cambiar)',
                        onTap: _c.whoPayHandler,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  GetBuilder<NewExpenseController>(
                    id: 'categoryItem',
                    builder: (_c) {
                      return ElementCard(
                        title: '¿Qué compró?',
                        message: _c.categorySelected != null
                            ? _c.categorySelected!.name
                            : '(Apretá para cambiar)',
                        onTap: controller.whichCategoryHandler,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  GetBuilder<NewExpenseController>(
                    id: 'priceItem',
                    builder: (_c) {
                      return ElementCard(
                        title: '¿Cuánto pagó?',
                        message: _c.price != null
                            ? Utils.convertMoneyString(_c.price!)
                            : '(Apretá para cambiar)',
                        onTap: _c.howMuchHandler,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  GetBuilder<NewExpenseController>(
                    id: 'saveButton',
                    builder: (_c) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: PaletteButton.generalButton(),
                            onPressed: (_c.price != null &&
                                    _c.categorySelected != null &&
                                    Helpers.getPersonsList(
                                                controller.mapPersons)
                                            .length >
                                        0)
                                ? controller.saveExpense
                                : null,
                            child: Text('GUARDAR'),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
