import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sheetal_raj_jal/Binding/splash_binding.dart';
import 'package:sheetal_raj_jal/controllers/languageController.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';
import 'package:sheetal_raj_jal/services/supabaseServices.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Supabase.initialize(
    url: 'https://bpkjymbjhcfbeofkptok.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJwa2p5bWJqaGNmYmVvZmtwdG9rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA0NDQ3NzQsImV4cCI6MjAzNjAyMDc3NH0.yzHdccAnbQsziuODGalDSrbsZ4u509jGMWXQ18IdiNA',
  );
  Get.put(SupabaseService());
  runApp(const MyApp());
}

LanguageController languageController = LanguageController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Raj Sheetal Jal',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      initialBinding: SplashBinding(),
      locale: Locale(languageController.currentLanguage, 'IN'),
      fallbackLocale: const Locale('en', 'IN'),
      getPages: AppPages.pages,
      initialRoute: AppPages.initial,
    );
  }
}