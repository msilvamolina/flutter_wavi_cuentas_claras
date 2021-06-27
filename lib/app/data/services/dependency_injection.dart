import '../provider/local/local_storage.dart';

import '../../controllers/main_controller.dart';
import 'package:get/get.dart';

class DependecyInjection {
  static void init() {
    Get.put<LocalStorage>(LocalStorage());
    Get.put<MainController>(MainController());
  }
}
