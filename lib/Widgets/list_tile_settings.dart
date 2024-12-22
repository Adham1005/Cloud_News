import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/locale_provider.dart';
import '../services/theme_provider.dart';

ListTile listTileItem({
  required String title,
  required String subtitle,
  required Function() onTap,
  required IconData icon,
}) {
  return ListTile(
    leading: Icon(icon, size: 30.0),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(subtitle),
    onTap: onTap,
  );
}

SwitchListTile switchListTileItem({
  required BuildContext context,
}) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final localizationProvider = Provider.of<LocalizationProvider>(context);
  return SwitchListTile(
    secondary: const Icon(Icons.dark_mode),
    title: Text(
      localizationProvider.locale.languageCode == 'en'
          ? 'Dark Mode'
          : 'الوضع المظلم',
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(localizationProvider.locale.languageCode == 'en'
        ? 'Switch between light and dark mode'
        : 'التبديل بين وضع الضوء والظلام'),
    value: themeProvider.darkMode,
    activeColor: Colors.blueAccent,
    inactiveThumbColor: Colors.grey,
    onChanged: (value) {
      themeProvider.toggleDarkMode();
    },
  );
}
