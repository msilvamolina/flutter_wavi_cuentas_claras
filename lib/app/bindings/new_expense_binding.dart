import 'package:get/get.dart';

import '../controllers/new_expense_controller.dart';

class NewExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NewExpenseController>(NewExpenseController());
  }
}
