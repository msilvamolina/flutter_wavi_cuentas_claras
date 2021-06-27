import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _getStorage = GetStorage();
  static const LIST_PERSON_KEY = 'LIST_PERSON_KEY';
  static const LIST_CATEGORY_KEY = 'LIST_CATEGORY_KEY';
  static const LIST_EXPENSE_KEY = 'LIST_EXPENSE_KEY';

  Future<dynamic> getListPerson() async {
    final _data = await _getStorage.read(LIST_PERSON_KEY);
    return _data;
  }

  Future<void> deleteAllData() {
    return _getStorage.erase();
  }

  Future<void> saveListPerson(Map<String, dynamic> list) async {
    try {
      await _getStorage.write(LIST_PERSON_KEY, list);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getListCategory() async {
    final _data = await _getStorage.read(LIST_CATEGORY_KEY);
    return _data;
  }

  Future<void> saveListCategory(Map<String, dynamic> list) async {
    try {
      await _getStorage.write(LIST_CATEGORY_KEY, list);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getListExpenses() async {
    final _data = await _getStorage.read(LIST_EXPENSE_KEY);
    return _data;
  }

  Future<void> saveListExpenses(Map<String, dynamic> list) async {
    try {
      await _getStorage.write(LIST_EXPENSE_KEY, list);
    } catch (e) {
      print(e);
    }
  }
}
