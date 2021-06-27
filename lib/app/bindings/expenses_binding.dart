import 'package:get/get.dart';
import '../controllers/expenses_controller.dart';

class ExpensesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ExpensesController>(ExpensesController());
  }
}
