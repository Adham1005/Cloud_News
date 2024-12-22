import 'package:cloud_news/Widgets/list_tile_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locale_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationProvider.locale.languageCode == 'en'
              ? 'Settings'
              : 'الإعدادات',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          children: [
            listTileItem(
              title: localizationProvider.locale.languageCode == 'en'
                  ? 'Language'
                  : 'اللغه',
              subtitle: localizationProvider.locale.languageCode == 'en'
                  ? 'Change app language'
                  : 'تغيير لغة التطبيق',
              icon: Icons.language,
              onTap: () {
                localizationProvider.toggleLanguage();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
            switchListTileItem(context: context),
          ],
        ),
      ),
    );
  }
}
