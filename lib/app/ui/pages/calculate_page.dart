import '../../controllers/helpers/helpers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import '../global_widgets/listTile/custom_list_full_price_tile.dart';

import '../../controllers/calculate_controller.dart';

class CalculatePage extends GetView<CalculateController> {
  @override
  Widget build(BuildContext context) {
    double toolbarSize = 400;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.addPersonOrGroup,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.purple[700],
              foregroundColor: Colors.orange,
              pinned: true,
              expandedHeight: toolbarSize,
              actions: [
                GetBuilder<MainController>(
                  id: 'viewFullResumeController',
                  builder: (_c) {
                    return Tooltip(
                      message: "Ver detalle",
                      child: IconButton(
                        icon: Icon(_c.viewFullResume
                            ? Icons.receipt
                            : Icons.receipt_long),
                        onPressed: _c.viewResume,
                      ),
                    );
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Resumen'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 0.8,
                      colors: [
                        Colors.lightBlueAccent[100]!,
                        Colors.blue[900]!,
                      ],
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/calculate.png',
                  ),
                ),
              ),
            ),
            GetX<MainController>(
              builder: (_c) {
                return SliverPadding(
                  padding: EdgeInsets.only(bottom: 80),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return CustomListFullPriceTile(
                          onTap: () => controller.personClickHandler(i),
                          onLongPress: () => controller.personsOptions(i),
                          price: controller.mapParticipantsEachAmount[
                                  _c.listParticipants[i].id] ??
                              0,
                          putMoney: controller.mapPersonsPutMoneyAmount[
                                  _c.listParticipants[i].id] ??
                              0,
                          title: _c.listParticipants[i].name,
                          amountPersons: _c.listParticipants[i].amountPersons,
                          subtitle: Helpers.getPersonCategories(
                                  _c.listParticipants[i], _c.listCategories) ??
                              "Ninguna",
                        );
                      },
                      childCount: _c.listParticipants.length,
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}
