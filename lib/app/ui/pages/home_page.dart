import '../../controllers/helpers/helpers.dart';
import '../../controllers/main_controller.dart';
import '../../data/services/theme_service.dart';
import '../../routes/app_routes.dart';
import '../global_widgets/containers/responsive_container.dart';
import '../global_widgets/listTile/custom_list_tile.dart';
import '../global_widgets/text/price_text.dart';
import '../theme/palettes/palette_button.dart';
import '../utils/utils.dart';

import '../layouts/main/widgets/main_layout_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/expenses_controller.dart';
import 'widgets/custom_bottom_navigation_bar.dart';

class ExpensesPage extends GetView<ExpensesController> {
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    double toolbarSize = 400;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.NEW_EXPENSE),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: GetX<MainController>(
        builder: (_c) => _c.listExpenses.length > 0
            ? CustomBottomNavigationBar()
            : SizedBox(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.purple[700],
            foregroundColor: Colors.orange,
            pinned: true,
            expandedHeight: toolbarSize,
            leading: Tooltip(
              message: "Cambiar Tema",
              child: IconButton(
                  icon: Icon(
                      Get.isDarkMode ? Icons.brightness_4 : Icons.brightness_2),
                  onPressed: () => ThemeService().changeThemeMode()),
            ),
            actions: [
              Tooltip(
                message: "Borrar todo",
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: controller.mainController.deleteAllOption,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Wavi Cuentas'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1.2,
                    colors: [
                      Colors.purple[400]!,
                      Colors.purple[900]!,
                    ],
                  ),
                ),
                child: Image.asset(
                  'assets/images/appmobile.png',
                ),
              ),
            ),
          ),
          GetX<MainController>(
            builder: (_c) {
              if (_c.listExpenses.length > 0)
                return SliverPadding(
                  padding: EdgeInsets.only(bottom: 80),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return CustomListTile(
                            onTap: () => controller.onExpensesClickHandler(
                                _c.listExpenses[i], i),
                            title: Helpers.getCategoryName(
                                _c.listExpenses[i].categoryId,
                                _c.listCategories),
                            subtitle: Helpers.getPersonsName(
                                    _c.listExpenses[i].persons,
                                    _c.listParticipants) ??
                                '',
                            price: _c.listExpenses[i].mount);
                      },
                      childCount: _c.listExpenses.length,
                    ),
                  ),
                );
              else
                return SliverToBoxAdapter(
                  child: Container(
                    height: (screenSize - toolbarSize) - 60,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/cards.png',
                              width: 120,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Hola! para comenzar\nagregá un gasto',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            // SizedBox(height: 20),
                            // SizedBox(
                            //   height: 40,
                            //   width: 200,
                            //   child: ElevatedButton(
                            //     style: PaletteButton.generalButton(),
                            //     onPressed: () =>
                            //         Get.toNamed(AppRoutes.NEW_EXPENSE),
                            //     child: Text('AGREGAR GASTO'),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            },
          )
        ],
      ),
    );
  }
}
