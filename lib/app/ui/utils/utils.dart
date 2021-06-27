import 'package:intl/intl.dart';

class Utils {
  static String convertMoneyString(double price) {
    // bool withDecimal = price.round() != price;

    final oCcy = new NumberFormat("#,##0.00", "es_AR");
    // final oCcy = new NumberFormat(withDecimal ? "#,##0.00" : "#,##0", "es_AR");

    String finalPrice = oCcy.format(price);
    return '\$' + finalPrice;
  }
}
