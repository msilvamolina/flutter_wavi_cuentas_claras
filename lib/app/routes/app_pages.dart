import '../bindings/calculate_binding.dart';
import '../ui/pages/calculate_page.dart';
import '../bindings/new_expense_binding.dart';
import '../ui/pages/new_expense_page.dart';
import '../bindings/expenses_binding.dart';
import '../ui/pages/home_page.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app_routes.dart';

final _defaultTransition = Transition.native;

class AppPages {
  static final homePage = GetPage(
    name: AppRoutes.HOME,
    page: () => ExpensesPage(),
    binding: ExpensesBinding(),
    transition: _defaultTransition,
  );

  static final List<GetPage> pages = [
    homePage,
    GetPage(
      name: AppRoutes.NEW_EXPENSE,
      page: () => NewExpensePage(),
      binding: NewExpenseBinding(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.CALCULATE,
      page: () => CalculatePage(),
      binding: CalculateBinding(),
      transition: _defaultTransition,
    ),
  ];
}
