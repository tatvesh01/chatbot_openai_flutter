import 'package:flutter/material.dart';

import 'helper.dart';
import 'storage_manager.dart';

class ThemeNotifier with ChangeNotifier {

  ThemeMode _mode;
  ThemeMode get mode => _mode;

  ThemeNotifier() : _mode = Helper.tempMode == null ? ThemeMode.light : Helper.tempMode! {
    StorageManager.readData('isLightMode').then((value) {
      if (value) {
        _mode = ThemeMode.light;
        Helper.tempMode = _mode;
      } else {
        _mode = ThemeMode.dark;
        Helper.tempMode = _mode;
      }
      notifyListeners();
    });
  }


  void setLightMode() {
    _mode = ThemeMode.light;
    StorageManager.saveData('isLightMode', true);
    Helper.tempMode = _mode;
    notifyListeners();
  }
  void setDarkMode() {
    _mode = ThemeMode.dark;
    StorageManager.saveData('isLightMode', false);
    Helper.tempMode = _mode;
    notifyListeners();
  }

}