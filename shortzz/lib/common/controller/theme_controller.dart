import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage('shortzz');
  final _key = 'themeMode';

  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    themeMode.value = _loadThemeFromBox();
  }

  ThemeMode _loadThemeFromBox() {
    String? theme = _box.read(_key);
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light;
    }
  }

  void toggleTheme(bool isDark) {
    themeMode.value =
        isDark ? ThemeMode.dark : ThemeMode.light;
    _box.write(_key, isDark ? 'dark' : 'light');
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}
