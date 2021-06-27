import 'dart:collection';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'helpers/helpers.dart';
import '../data/models/category/category.dart';
import '../data/models/expense/expense.dart';
import '../data/models/person/person.dart';
import '../ui/global_widgets/dialogs/custom_categories_dialog.dart';
import '../ui/global_widgets/dialogs/custom_checkbox_categories_dialog.dart';
import '../ui/global_widgets/dialogs/custom_checkbox_persons_dialog.dart';

import 'helpers/globals_snackbars.dart';
import 'main_controller.dart';

class NewExpenseController extends GetxController {
  final mainController = Get.find<MainController>();
  Map<String, bool> _mapPersons = HashMap();
  Map<String, bool> get mapPersons => _mapPersons;

  Category? _categorySelected;
  Category? get categorySelected => _categorySelected;

  double? _price;
  double? get price => _price;
  Expense? _expense;

  @override
  void onInit() {
    if (Get.arguments != null) {
      _expense = Get.arguments as Expense;
      initValues();
    }

    super.onInit();
  }

  void initValues() {
    if (mainController.mapCategories != null) {
      _categorySelected = mainController.mapCategories![_expense!.categoryId];
    }

    _price = _expense!.mount;

    _mapPersons = Helpers.listToMapBool(_expense!.persons);
  }

  void whoPayHandler() async {
    await showDialog<List>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomCheckBoxPersonsDialog();
      },
    );
  }

  void personDialogOnChanged(String id, bool value) {
    _mapPersons[id] = value;
    update(['personDialog', 'personList', 'saveButton']);
  }

  void whichCategoryHandler() async {
    if (mainController.listCategories.length == 0) {
      addCategory(back: false);
    } else {
      whichCategoryHandlerDialog();
    }
  }

  void whichCategoryHandlerDialog() async {
    await showDialog<List>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomCategoriesDialog();
      },
    );
  }

  void categoryClickHandler(Category category) {
    _categorySelected = category;
    Get.back();
    update(['categoryItem', 'saveButton']);
  }

  void howMuchHandler() async {
    final result = await showTextInputDialog(
      title: "¿Cuánto gastó?",
      context: Get.context!,
      okLabel: "Aceptar",
      cancelLabel: "Cancelar",
      textFields: [
        DialogTextField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          hintText: 'Monto',
          initialText: (_price ?? '').toString(),
          validator: (s) {
            if (s != null)
              try {
                double _n = double.parse(s);
                if (_n < 1) {
                  return 'Ingresá un número válido';
                }
              } catch (e) {
                return 'Ingresá un número válido';
              }
            else
              return 'Necesitás escribir un monto';
          },
        )
      ],
    );

    if (result != null) {
      String _p = result[0].trim();

      try {
        _price = double.parse(_p);
        update(['priceItem', 'saveButton']);
      } catch (e) {
        print(e);
      }
    }
  }

  void saveExpense() {
    if (_expense != null) {
      updateExpense();
    } else {
      createNewExpense();
    }
  }

  void updateExpense() {
    Expense newExpense = _expense!.copyWith(
      persons: Helpers.getPersonsList(_mapPersons),
      categoryId: _categorySelected!.id,
      mount: _price!,
    );

    mainController.updateExpense(_expense!, newExpense);
    Get.back();
  }

  void createNewExpense() {
    String _uuid = Uuid().v4();

    Expense newExpense = Expense(
      id: _uuid,
      persons: Helpers.getPersonsList(_mapPersons),
      categoryId: _categorySelected!.id,
      mount: _price!,
    );

    mainController.addExpense(newExpense);
    Get.back();
  }

  void addPersonFromDialog() async {
    await addPerson(back: true);
  }

  Future<void> addPerson({bool back = false}) async {
    String? personId = await mainController.addPersonDialog();
    if (personId != null) {
      _mapPersons[personId] = true;
      update(['personDialog', 'personList', 'saveButton']);
      if (back) {
        Get.back();
      }
    }
  }

  void addGroup() async {
    String? personId = await mainController.addGroupDialog();
    if (personId != null) {
      _mapPersons[personId] = false;
      update(['personDialog', 'personList', 'saveButton']);
    }
  }

  void addCategory({bool back = true}) async {
    final result = await showTextInputDialog(
      title: "Nueva categoría",
      context: Get.context!,
      okLabel: "Aceptar",
      cancelLabel: "Cancelar",
      textFields: [
        DialogTextField(
          hintText: 'Nombre',
          validator: (s) {
            if (s != null)
              return s.length < 3
                  ? 'Tenés que escribir 3 letras como mínimo'
                  : null;
            else
              return 'Necesitás escribir un nombre';
          },
        )
      ],
    );

    if (result != null) {
      String categoryName = result[0].trim();
      String _uuid = Uuid().v4();

      String _newName = Helpers.capitalize(categoryName);

      Category newCategory = Category(
        id: _uuid,
        name: _newName,
      );

      bool add = true;
      if (mainController.listCategories.length > 0) {
        for (var i = 0; i < mainController.listCategories.length; i++) {
          String _n = mainController.listCategories[i].name;
          if (_n == _newName) {
            add = false;
          }
        }
      }

      if (add) {
        mainController.addCategory(newCategory);
        _categorySelected = newCategory;
        if (back) {
          Get.back();
        }

        update(['categoryItem', 'saveButton']);
      } else {
        GlobalSnackbars()
            .showSnackBarError('Ya existe una categoría con ese nombre');
      }
    }
  }
}
