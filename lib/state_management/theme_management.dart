import 'package:flutter/cupertino.dart';

class ThemeManagement extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  void set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}