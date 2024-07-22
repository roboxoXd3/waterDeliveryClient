import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final selectedLanguage = 'en'.obs;

  String get currentLanguage => selectedLanguage.value;
  final isExpanded = false.obs;
  final List<String> languages = ['en', 'hi'];
  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  void changeLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
    updateLocale();
    saveLanguage();
  }

  void updateLocale() {
    Get.updateLocale(Locale(selectedLanguage.value, 'IN'));
  }

  void loadSavedLanguage() {
    final box = GetStorage();
    final savedLanguage = box.read('language') ?? 'en';
    changeLanguage(savedLanguage);
  }

  void saveLanguage() {
    final box = GetStorage();
    box.write('language', selectedLanguage.value);
  }
}
