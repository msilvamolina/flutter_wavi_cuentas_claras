import 'package:get/get.dart';
import '../controllers/calculate_controller.dart';

class CalculateBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CalculateController>(CalculateController());
  }
}
