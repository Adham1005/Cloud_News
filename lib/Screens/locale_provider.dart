import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class LocalizationProvider extends ChangeNotifier {
//   Locale _locale = const Locale('en');
//   Locale get locale => _locale;
//
//   void setLocale(Locale locale) {
//     if (!['en', 'ar'].contains(locale.languageCode)) return;
//     _locale = locale;
//     notifyListeners();
//   }
//
//   void toggleLang() {
//     _locale =
//         _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
//     notifyListeners();
//   }
// }

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar');
  Map<String, String>? _localizedStrings;
  Locale get locale => _locale;

  Future<void> loadLocale(Locale locale) async {
    _locale = locale;

    // Load the JSON file for the selected language
    final jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    _localizedStrings = Map<String, String>.from(json.decode(jsonString));
    notifyListeners();
  }

  String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }

  void toggleLanguage() async {
    final newLocale =
        _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    await loadLocale(newLocale);
  }
}
