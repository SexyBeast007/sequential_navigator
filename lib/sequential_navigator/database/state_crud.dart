import 'package:hive_flutter/hive_flutter.dart';
import 'package:sequential_navigator/sequential_navigator/constants/database_constants.dart';

class StateCRUD {
  // String names
  static const String boxName = DatabaseStrings.hivePageStateIndex;
  static const String key = DatabaseStrings.hivePageStateIndexKey;

  /// Create new page state index
  Future<void> createPageStateIndex(int pageIndex) async {
    Box<int> pageStateBox = await Hive.openBox(boxName);
    if (pageStateBox.isEmpty) await pageStateBox.put(key, pageIndex);
  }

  /// Read page state index
  Future<int?> readPageStateIndex() async {
    Box<int> pageStateBox = await Hive.openBox(boxName);
    return pageStateBox.get(key, defaultValue: 1);
  }

  /// Update page state index
  Future<void> updatePageStateIndex(int pageIndex) async {
    Box<int> pageStateBox = await Hive.openBox(boxName);
    if (pageStateBox.isNotEmpty) await pageStateBox.put(key, pageIndex);
  }

  /// Delete page state index
  ///
  /// Cal this to ensure page index is reset to 1 for next load
  Future<void> deletePageStateIndex() async {
    Box<int> pageStateBox = await Hive.openBox(boxName);
    if (pageStateBox.isNotEmpty) await pageStateBox.delete(key);
  }
}
