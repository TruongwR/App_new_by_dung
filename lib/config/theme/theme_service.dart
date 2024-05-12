import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  static ThemeService get to => Get.find();
  final themeMode = ThemeMode.light.obs;

  Future<ThemeService> init() async {
    final data = GetStorage().read('theme_mode');
    if (data != null) {
      themeMode.value = GetStorage().read('theme_mode') == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    return this;
  }

  void changeTheme() {
    GetStorage().write('theme_mode', Get.isDarkMode ? 'light' : 'dark');
    final theme = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    themeMode.value = theme;
    Get.changeThemeMode(theme);
  }
}
