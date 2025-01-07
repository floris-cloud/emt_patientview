import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("themeMode")) {
      String mode = prefs.getString("themeMode")!;
      
      switch (mode) {
        case 'ThemeMode.dark':
          return ThemeMode.dark;
        case 'ThemeMode.light':
          return ThemeMode.light;
        case 'ThemeMode.system':
        default:
          return ThemeMode.system;
      }
    }
    
    return ThemeMode.system;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeMode", theme.toString());
  }

  /// Loads the User's preferred Locale from local or remote storage.
  Future<Locale> loadLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("locale")) {
      String locale = prefs.getString("locale")!;
      switch (locale) {
        case 'de':
          return Locale('de');
        case 'en':
        default:
          return Locale('en');
      }
    }
    return Locale('en'); // Default to English if no preference is found
  }

  /// Persists the user's preferred Locale to local or remote storage.
  Future<void> updateLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("locale", locale.languageCode);
  }
}
