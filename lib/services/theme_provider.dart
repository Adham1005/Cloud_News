import 'package:cloud_news/Widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;
  bool _darkMode = false;

  ThemeProvider() {
    loadTheme();
  }

  ThemeData get currentTheme => _currentTheme;
  bool get darkMode => _darkMode;

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    _currentTheme = _darkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  void toggleDarkMode() async {
    _darkMode = !_darkMode;
    _currentTheme = _darkMode ? darkTheme : lightTheme;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
  }
}
