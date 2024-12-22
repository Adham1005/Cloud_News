import 'package:cloud_news/Screens/bookmarks_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/locale_provider.dart';
import 'Screens/news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;

  final List<Widget> _tabs = [
    const NewsPage(),
    const BookmarksPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      body: _tabs[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (index) {
            setState(() {
              _currentTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
                size: 28,
              ),
              label: localizationProvider.locale.languageCode == 'en'
                  ? 'Home Page'
                  : 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.library_books, size: 28.0),
              label: localizationProvider.locale.languageCode == 'en'
                  ? 'Bookmarks Page'
                  : 'الإشارات المرجعية',
            ),
          ]),
    );
  }
}
