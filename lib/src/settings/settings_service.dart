import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
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
}
