import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalSnackbars {
  void showSnackBarError(String message) {
    Get.snackbar(
      'Error!',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.red[700],
      colorText: Colors.white,
    );
  }

  void showSnackBarSuccess(String message) {
    Get.snackbar(
      'Genial!',
      message,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green[700],
      colorText: Colors.white,
    );
  }
}
