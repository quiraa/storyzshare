import 'package:flutter/material.dart';
import 'package:flutter_story_app/features/story/data/preferences/user_preference.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    final bool? isDarkMode = await UserPreference.getTheme();
    if (isDarkMode != null) {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    UserPreference.setTheme(isDarkMode);
    notifyListeners();
  }
}
