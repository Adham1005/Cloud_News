import 'package:cloud_news/Screens/locale_provider.dart';
import 'package:cloud_news/services/bookmarks_provider.dart';
import 'package:cloud_news/services/services.dart';
import 'package:cloud_news/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localizationProvider = LocalizationProvider();
  await localizationProvider.loadLocale(const Locale('ar'));
  NewsServices().getNews();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(
          create: (_) => BookmarkProvider()..loadBookmarks()),
      ChangeNotifierProvider(create: (_) => LocalizationProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return MaterialApp(
      title: 'Cloud News',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      locale: localizationProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        // Adjust directionality based on locale
        return Directionality(
          textDirection: localizationProvider.locale.languageCode == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          child: child!,
        );
      },
      home: const HomePage(),
    );
  }
}
