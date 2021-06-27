import 'dart:collection';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'helpers/helpers.dart';
import '../data/models/expense/expense.dart';
import '../data/models/person/person.dart';
import '../ui/global_widgets/dialogs/custom_categories_dialog.dart';
import '../ui/global_widgets/dialogs/custom_checkbox_categories_dialog.dart';
import '../ui/global_widgets/dialogs/custom_group_options_dialog.dart';
import '../ui/global_widgets/dialogs/custom_options_dialog.dart';

import 'helpers/globals_snackbars.dart';
import 'main_controller.dart';

class CalculateController extends GetxController {
  final mainController = Get.find<MainController>();
  Map<String, dynamic> _mapPersonsCategories = HashMap();
  Map<String, dynamic> get mapPersonsCategories => _mapPersonsCategories;

  Map<String, double> mapCategoriesAmount = HashMap();
  Map<String, double> mapPersonsPutMoneyAmount = HashMap();
  Map<String, bool> mapParticipantsCategories = HashMap();
  Map<String, int> mapCategoriesParticipants = HashMap();
  Map<String, double> mapCategoriesEachAmount = HashMap();
  Map<String, double> mapParticipantsEachAmount = HashMap();
  Map<String, double> mapParticipantsTotalAmount = HashMap();

  @override
  void onInit() {
    calculate();
    super.onInit();
  }

  void recalculate() {
    mapCategoriesAmount.clear();
    mapPersonsPutMoneyAmount.clear();
    mapParticipantsCategories.clear();
    mapCategoriesParticipants.clear();
    mapCategoriesEachAmount.clear();
    mapParticipantsEachAmount.clear();
    mapParticipantsTotalAmount.clear();
    calculate();
  }

  void calculate() {
    if (mainController.listExpenses.length > 0) {
      for (var i = 0; i < mainController.listExpenses.length; i++) {
        Expense expense = mainController.listExpenses[i];
        double _categoryMount = 0;

        if (mapCategoriesAmount[expense.categoryId] != null) {
          _categoryMount = mapCategoriesAmount[expense.categoryId]!;
        }
        mapCategoriesAmount[expense.categoryId] =
            _categoryMount + expense.mount;

        double partialMount = expense.mount / expense.persons.length;
        for (var i = 0; i < expense.persons.length; i++) {
          if (mapPersonsPutMoneyAmount[expense.persons[i]] != null) {
            mapPersonsPutMoneyAmount[expense.persons[i]] =
                mapPersonsPutMoneyAmount[expense.persons[i]]! + partialMount;
          } else {
            mapPersonsPutMoneyAmount[expense.persons[i]] = partialMount;
          }
        }
      }
    }

    if (mainController.listParticipants.length > 0) {
      for (var i = 0; i < mainController.listParticipants.length; i++) {
        Person person = mainController.listParticipants[i];
        Map<String, bool>? participansCategories = person.categories;

        if (participansCategories != null) {
          participansCategories.forEach((key, value) {
            if (value) {
              if (mapCategoriesParticipants[key] != null) {
                mapCategoriesParticipants[key] =
                    mapCategoriesParticipants[key]! + 1;
              } else {
                mapCategoriesParticipants[key] = 1;
              }
              mapParticipantsCategories[person.id + '&&' + key] = true;
            }
          });
        } else {
          for (var i = 0; i < mainController.listCategories.length; i++) {
            String key = mainController.listCategories[i].id;
            if (mapCategoriesParticipants[key] != null) {
              mapCategoriesParticipants[key] =
                  mapCategoriesParticipants[key]! + 1;
            } else {
              mapCategoriesParticipants[key] = 1;
            }
            mapParticipantsCategories[person.id + '&&' + key] = true;
          }
        }
      }
    }

    mapCategoriesAmount.forEach((key, value) {
      int amountParticipants = mapCategoriesParticipants[key]!;
      if (mapCategoriesAmount[key] != null) {
        double _categoryAmount = mapCategoriesAmount[key]! / amountParticipants;
        mapCategoriesEachAmount[key] = _categoryAmount;
      }
    });

    mapParticipantsCategories.forEach((key, value) {
      if (value) {
        final variablesSplit = key.split('&&');
        String personId = variablesSplit[0];
        String categoryId = variablesSplit[1];

        if (mapCategoriesEachAmount[categoryId] != null) {
          double amount = mapCategoriesEachAmount[categoryId]!;
          if (mapParticipantsEachAmount[personId] != null) {
            mapParticipantsEachAmount[personId] =
                mapParticipantsEachAmount[personId]! + amount;
          } else {
            mapParticipantsEachAmount[personId] = amount;
          }
        }
      }
    });
  }

  void personClickHandler(int i) async {
    Person person = mainController.listParticipants[i];
    final categorieslist = mainController.listCategories;

    if (_mapPersonsCategories[person.id] == null) {
      Map<String, bool> personCategories =
          Helpers.getCategories(person, categorieslist);

      _mapPersonsCategories[person.id] = personCategories;
    }

    await showDialog<List>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomCheckBoxDialog(
          person: person,
        );
      },
    );

    Person newPerson =
        person.copyWith(categories: _mapPersonsCategories[person.id]);
    mainController.updatePerson(newPerson, i);
    recalculate();
  }

  void personDialogOnChanged(bool value, Person person, String categoryId) {
    final personCategories = _mapPersonsCategories[person.id];
    personCategories[categoryId] = value;
    _mapPersonsCategories[person.id] = personCategories;
    update(['personDialog']);
  }

  void addPerson() async {
    await mainController.addPersonDialog();
    recalculate();
  }

  void addGroup() async {
    await mainController.addGroupDialog();
    recalculate();
  }

  void addPersonOrGroup() async {
    await showDialog<List>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomGroupOptionsDialog(
          onAddPerson: () {
            Get.back();
            addPerson();
          },
          onAddGroup: () {
            Get.back();
            addGroup();
          },
        );
      },
    );
  }

  void personsOptions(int i) async {
    Person person = mainController.listParticipants[i];

    await showDialog<List>(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomOptionsDialog(
          onEdit: () {
            Get.back();
            updatePerson(person, i);
          },
          onDelete: () => onPersonDelete(i),
        );
      },
    );
  }

  void updatePerson(Person person, int i) async {
    if (person.amountPersons > 1) {
      await mainController.addGroupDialog(person: person, index: i);
    } else {
      await mainController.addPersonDialog(person: person, index: i);
    }
    recalculate();
  }

  void onPersonDelete(int i) async {
    Get.back();

    final result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: "¿Estás seguro de querer borrar este elemento?",
        message: "Esta acción no se puede deshacer.",
        isDestructiveAction: true,
        okLabel: "BORRAR",
        cancelLabel: "Cancelar");

    if (result == OkCancelResult.ok) {
      onPersonDelete2(i);
    }
  }

  void onPersonDelete2(int i) async {
    final result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: "Atención!",
        message: "También se borrarán los gastos que hizo esta persona",
        isDestructiveAction: true,
        okLabel: "BORRAR",
        cancelLabel: "Cancelar");

    if (result == OkCancelResult.ok) {
      deleteAllAction(i);
    }
  }

  void deleteAllAction(int i) async {
    await mainController.deletePerson(i);
    recalculate();
  }
}
