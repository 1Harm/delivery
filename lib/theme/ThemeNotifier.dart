import 'package:flutter/material.dart';
import 'package:deliveat/theme/CustomTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = CustomTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;
  late SharedPreferences _prefs;
  late ThemeData _themeData;
  ThemeNotifier() {
    _themeData = ThemeData.light(); // Set the default theme
    _loadSavedTheme();
  }
  ThemeData get themeData => _themeData;

  get theme => null;

  Future<void> _loadSavedTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _themeData = _currentTheme;
    notifyListeners();
  }

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }

}
