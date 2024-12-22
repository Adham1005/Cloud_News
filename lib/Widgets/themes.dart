import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 5,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.grey,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
    foregroundColor: Colors.white,
    iconSize: 28,
    shape: CircleBorder(),
  ),
  useMaterial3: true,
  brightness: Brightness.light,
);
final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(color: Colors.black),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 5,
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.grey,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
    foregroundColor: Colors.black,
    iconSize: 28,
    shape: CircleBorder(),
  ),
  useMaterial3: true,
  brightness: Brightness.dark,
);
