import 'package:flutter/material.dart';

final themeController = ValueNotifier<ThemeMode>(ThemeMode.light);

bool get isDarkMode => themeController.value == ThemeMode.dark;

void toggleTheme() {
  themeController.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
}
