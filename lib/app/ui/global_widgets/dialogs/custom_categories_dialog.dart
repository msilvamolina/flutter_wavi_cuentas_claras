import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/new_expense_controller.dart';

class CustomCategoriesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Elegí una categoría'),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.all(0),
          child: GetBuilder<NewExpenseController>(
            id: 'personDialog',
            builder: (controller) {
              return ListBody(
                children: [
                  for (var i = 0;
                      i < controller.mainController.listCategories.length;
                      i++) ...[
                    ListTile(
                      onTap: () => controller.categoryClickHandler(
                          controller.mainController.listCategories[i]),
                      title: Text(
                          controller.mainController.listCategories[i].name),
                    ),
                  ],
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: controller.addCategory,
                    child: Text('NUEVA CATEGORIA'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
