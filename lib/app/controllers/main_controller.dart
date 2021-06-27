import 'dart:collection';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../data/models/category/category.dart';
import '../data/models/expense/expense.dart';
import '../data/models/person/person.dart';
import '../data/provider/local/local_storage.dart';

import 'helpers/globals_snackbars.dart';
import 'helpers/helpers.dart';

class MainController extends GetxController {
  final LocalStorage localStorage = Get.find<LocalStorage>();

  final listParticipants = <Person>[].obs;
  final listCategories = <Category>[].obs;
  final listExpenses = <Expense>[].obs;

  bool _viewFullResume = false;
  bool get viewFullResume => _viewFullResume;

  void viewResume() {
    _viewFullResume = !_viewFullResume;
    update(['viewFullResumeController']);
  }

  Map<String, Category>? mapCategories;

  @override
  void onInit() async {
    await getListPerson();
    await getListCategories();
    await getListExpenses();

    mapCategories = Helpers.listCategoriesToMap(listCategories);
    super.onInit();
  }

  Future<void> getListPerson() async {
    try {
      final _list = await localStorage.getListPerson();
      if (_list != null) {
        List<Person> listReady = Helpers.mapToListPerson(_list);
        listParticipants.addAll(listReady);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getListCategories() async {
    try {
      final _list = await localStorage.getListCategory();

      if (_list != null) {
        List<Category> listReady = Helpers.mapToListCategory(_list);
        listCategories.addAll(listReady);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getListExpenses() async {
    try {
      final _list = await localStorage.getListExpenses();
      if (_list != null) {
        List<Expense> listReady = Helpers.mapToListExpense(_list);
        listExpenses.addAll(listReady);
      }
    } catch (e) {
      print(e);
    }
  }

  void addPerson(Person person) {
    listParticipants.add(person);
    saveListPerson();
  }

  void addCategory(Category category) {
    listCategories.add(category);
    saveListCategory();
  }

  void addExpense(Expense expense) {
    listExpenses.add(expense);
    saveListExpense();
  }

  void updateExpense(Expense oldExpense, Expense newExpense) {
    int index = listExpenses.indexOf(oldExpense);

    listExpenses.removeAt(index);
    listExpenses.insert(index, newExpense);
    saveListExpense();
  }

  void saveListPerson() async {
    await localStorage.saveListPerson(Helpers.listToMap(listParticipants));
  }

  void saveListCategory() async {
    await localStorage.saveListCategory(Helpers.listToMap(listCategories));
  }

  void saveListExpense() async {
    await localStorage.saveListExpenses(Helpers.listToMap(listExpenses));
  }

  void updatePerson(Person person, int i) {
    listParticipants.removeAt(i);
    listParticipants.insert(i, person);
    saveListPerson();
  }

  void deleteAllOption() async {
    final result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: "¿Estás seguro de querer borrar todo?",
        message:
            "Esta acción borrá todos los datos guardados hasta el momento.",
        isDestructiveAction: true,
        okLabel: "BORRAR",
        cancelLabel: "Cancelar");

    if (result == OkCancelResult.ok) {
      deleteAllAction();
    }
  }

  void deleteAllAction() async {
    await localStorage.deleteAllData();
    listParticipants.clear();
    listCategories.clear();
    listExpenses.clear();
  }

  void deleteExpense(int i) {
    listExpenses.removeAt(i);
    saveListExpense();
  }

  Future<void> deletePerson(int i) async {
    Person _person = listParticipants[i];

    if (listExpenses.length > 0) {
      for (var i = 0; i < listExpenses.length; i++) {
        Expense _expense = listExpenses[i];
        bool contain = _expense.persons.contains(_person.id);

        if (contain) {
          listExpenses.removeAt(i);
        }
      }
    }
    listParticipants.removeAt(i);
    saveListPerson();
  }

  Future<String?> addPersonDialog({Person? person, int? index}) async {
    String? _return;

    final result = await showTextInputDialog(
      title: person == null ? "Nueva persona" : "Editar persona",
      context: Get.context!,
      okLabel: "Aceptar",
      cancelLabel: "Cancelar",
      textFields: [
        DialogTextField(
          hintText: 'Nombre',
          initialText: person != null ? person.name : null,
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
      String personName = result[0].trim();
      String _uuid = Uuid().v4();

      if (person != null) {
        _uuid = person.id;
      }

      String _newName = Helpers.capitalize(personName);

      Person newPerson = Person(
        amountPersons: 1,
        id: _uuid,
        name: _newName,
      );

      bool add = true;
      if (listParticipants.length > 0) {
        for (var i = 0; i < listParticipants.length; i++) {
          String _n = listParticipants[i].name;
          if (_n == _newName) {
            add = false;
          }
        }
      }

      if (add) {
        if (person != null && index != null) {
          updatePerson(newPerson, index);
        } else {
          addPerson(newPerson);
        }
        _return = _uuid;
      } else {
        GlobalSnackbars()
            .showSnackBarError('Ya existe una persona con ese nombre');
      }
    }
    return _return;
  }

  Future<String?> addGroupDialog({Person? person, int? index}) async {
    String? _return;
    final result = await showTextInputDialog(
      title: person == null ? "Nuevo Grupo" : "Editar grupo",
      context: Get.context!,
      okLabel: "Aceptar",
      cancelLabel: "Cancelar",
      textFields: [
        DialogTextField(
          hintText: 'Cantidad de personas',
          initialText: person != null ? person.amountPersons.toString() : null,
          keyboardType: TextInputType.number,
          validator: (s) {
            if (s != null)
              try {
                int _n = int.parse(s);
                if (_n < 1) {
                  return 'Ingresá un número válido';
                }
              } catch (e) {
                return 'Ingresá un número válido';
              }
            else
              return 'Necesitás escribir una cantidad';
          },
        ),
        DialogTextField(
          hintText: 'Nombre',
          initialText: person != null ? person.name : null,
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
      String _amount = result[0].trim();

      String personName = result[1].trim();
      int _amountPerson = 1;

      try {
        _amountPerson = int.parse(_amount);
      } catch (e) {
        print(e);
      }

      String _uuid = Uuid().v4();

      if (person != null) {
        _uuid = person.id;
      }
      String _newName = Helpers.capitalize(personName);

      Person newPerson = Person(
        amountPersons: _amountPerson,
        id: _uuid,
        name: _newName,
      );

      bool add = true;
      if (listParticipants.length > 0) {
        for (var i = 0; i < listParticipants.length; i++) {
          String _n = listParticipants[i].name;
          if (_n == _newName) {
            if (person != null) {
              if (person.id != _uuid) {
                add = false;
              }
            } else {
              add = false;
            }
          }
        }
      }

      if (add) {
        if (person != null && index != null) {
          updatePerson(newPerson, index);
        } else {
          addPerson(newPerson);
        }
        _return = _uuid;
      } else {
        GlobalSnackbars()
            .showSnackBarError('Ya existe una persona con ese nombre');
      }
    }
    return _return;
  }
}
