import 'dart:collection';

import '../../data/models/category/category.dart';
import '../../data/models/expense/expense.dart';
import '../../data/models/person/person.dart';

class Helpers {
  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  static Map<String, Category> listCategoriesToMap(list) {
    Map<String, Category> map = new HashMap();

    if (list.length > 0) {
      for (var i = 0; i < list.length; i++) {
        map[list[i].id] = list[i];
      }
    }
    return map;
  }

  static Map<String, dynamic> listToMap(list) {
    Map<String, dynamic> map = new HashMap();

    if (list.length > 0) {
      for (var i = 0; i < list.length; i++) {
        map[list[i].id] = list[i].toJson();
      }
    }

    return map;
  }

  static Map<String, bool> listToMapBool(list) {
    Map<String, bool> map = new HashMap();

    if (list.length > 0) {
      for (var i = 0; i < list.length; i++) {
        map[list[i]] = true;
      }
    }

    return map;
  }

  static List<Person> mapToListPerson(Map<String, dynamic> map) {
    List<Person> list = [];

    if (map.length > 0) {
      map.forEach((key, value) {
        Person _person = Person.fromJson(value);
        list.add(_person);
      });
    }

    return list.reversed.toList();
  }

  static List<Category> mapToListCategory(Map<String, dynamic> map) {
    List<Category> list = [];

    if (map.length > 0) {
      map.forEach((key, value) {
        Category _item = Category.fromJson(value);
        list.add(_item);
      });
    }

    return list.reversed.toList();
  }

  static List<Expense> mapToListExpense(Map<String, dynamic> map) {
    List<Expense> list = [];

    if (map.length > 0) {
      map.forEach((key, value) {
        Expense _item = Expense.fromJson(value);
        list.add(_item);
      });
    }

    return list.reversed.toList();
  }

  static Map<String, bool> getCategories(
      Person person, List<Category>? listCategories) {
    Map<String, bool> map = new HashMap();
    if (listCategories != null) {
      for (var i = 0; i < listCategories.length; i++) {
        map[listCategories[i].id] = true;
      }
    }

    Map<String, bool>? mapPersonCategories = person.categories;

    if (mapPersonCategories != null) {
      mapPersonCategories.forEach((key, value) {
        map[key] = value;
      });
    }

    return map;
  }

  static String? getPersonCategories(
      Person person, List<Category>? listCategories) {
    String? _result;
    String? _allCategories;

    Map<String, String> map = new HashMap();

    if (listCategories != null) {
      final newList = listCategories.reversed.toList();
      for (var i = 0; i < newList.length; i++) {
        map[newList[i].id] = newList[i].name;
        if (_allCategories != null) {
          _allCategories = _allCategories + ", " + newList[i].name;
        } else {
          _allCategories = newList[i].name;
        }
      }

      Map<String, bool>? mapPersonCategories = person.categories;

      if (mapPersonCategories != null) {
        mapPersonCategories.forEach((key, value) {
          if (value) {
            if (map[key] != null) {
              String _categoryName = map[key]!;
              if (_result != null) {
                _result = _result! + ", " + _categoryName;
              } else {
                _result = _categoryName;
              }
            }
          }
        });
      } else {
        _result = _allCategories;
      }
    }

    return _result;
  }

  static String? getPersonsString(
      Map<String, bool> personsSelected, List<Person> persons) {
    String? _return;
    Map<String, String> map = new HashMap();

    if (persons.length > 0) {
      for (var i = 0; i < persons.length; i++) {
        Person _p = persons[i];

        if (_p.amountPersons > 1) {
          map[_p.id] = _p.name + " (" + _p.amountPersons.toString() + ")";
        } else {
          map[_p.id] = _p.name;
        }
      }

      personsSelected.forEach((key, value) {
        if (value) {
          if (_return != null) {
            _return = _return! + ', ' + map[key]!;
          } else {
            _return = map[key]!;
          }
        }
      });
    }

    return _return;
  }

  static List<String> getPersonsList(Map<String, bool> map) {
    List<String> list = [];
    map.forEach((key, value) {
      if (value) {
        list.add(key);
      }
    });

    return list;
  }

  static String getCategoryName(String id, List<Category>? listCategories) {
    String _return = '';
    Map<String, String> map = new HashMap();
    if (listCategories != null) {
      for (var i = 0; i < listCategories.length; i++) {
        map[listCategories[i].id] = listCategories[i].name;
      }
    }

    if (map[id] != null) {
      _return = map[id]!;
    }

    return _return;
  }

  static String? getPersonsName(
      List<String> persons, List<Person>? listPersons) {
    String? _return;

    Map<String, String> map = new HashMap();
    if (listPersons != null) {
      for (var i = 0; i < listPersons.length; i++) {
        map[listPersons[i].id] = listPersons[i].name;
      }
    }

    if (persons.length > 0) {
      for (var i = 0; i < persons.length; i++) {
        String _id = persons[i];
        String _name = map[_id]!;

        if (_return != null) {
          _return = _return + ', ' + _name;
        } else {
          _return = _name;
        }
      }
    }

    return _return;
  }

  static double getExpensesTotal(List<Expense>? listExpense) {
    double _return = 0;

    if (listExpense != null) {
      for (var i = 0; i < listExpense.length; i++) {
        _return = _return + listExpense[i].mount;
      }
    }
    return _return;
  }
}
