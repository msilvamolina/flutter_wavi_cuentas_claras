import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/expense/expense.dart';
import '../routes/app_routes.dart';
import '../ui/global_widgets/dialogs/custom_categories_dialog.dart';
import '../ui/global_widgets/dialogs/custom_options_dialog.dart';

import 'main_controller.dart';

class ExpensesController extends GetxController {
  final mainController = Get.find<MainController>();

  void onExpensesClickHandler(Expense expense, int i) async {
    await showDialog<List>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomOptionsDialog(
          onEdit: () => onExpenseEdit(expense),
          onDelete: () => onExpenseDelete(i),
        );
      },
    );
  }

  void onExpenseEdit(Expense expense) {
    Get.back();
    Get.toNamed(AppRoutes.NEW_EXPENSE, arguments: expense);
  }

  void onExpenseDelete(int i) async {
    Get.back();

    final result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: "¿Estás seguro de querer borrar este elemento?",
        message: "Esta acción no se puede deshacer.",
        isDestructiveAction: true,
        okLabel: "BORRAR",
        cancelLabel: "Cancelar");

    if (result == OkCancelResult.ok) {
      deleteAllAction(i);
    }
  }

  void deleteAllAction(int i) async {
    mainController.deleteExpense(i);
  }

  void calculate() {
    Get.toNamed(AppRoutes.CALCULATE);
  }
}
