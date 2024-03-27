import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String _language = 'en'; // Default language
  SharedPreferences? _prefs;

  SettingsProvider() {
    _loadFromPrefs();
  }

  // Getter for language
  String get language => _language;

  // Setter for language that also persists the change
  void setLanguage(String language) async {
    _language = language;
    await _saveToPrefs();
    notifyListeners();
  }

  // Load language setting from SharedPreferences
  Future<void> _loadFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _language = _prefs?.getString('language') ?? 'it'; // Use 'en' if no value is stored
    notifyListeners(); // Notify listeners in case the value changed
  }

  // Save language setting to SharedPreferences
  Future<void> _saveToPrefs() async {
    if (_prefs == null) return;
    await _prefs?.setString('language', _language);
  }
}
