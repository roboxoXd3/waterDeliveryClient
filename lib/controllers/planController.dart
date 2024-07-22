// ignore_for_file: file_names

import 'package:get/get.dart';
import '../models/planModel.dart';
import 'languageController.dart';

class PlansController extends GetxController {
  late RxList<Plan> plans;
LanguageController languageController = LanguageController();

  @override
  void onInit() {
    super.onInit();
    plans = getPlans().obs;

    ever(languageController.selectedLanguage, (_) {
      plans.value = getPlans();
    });
  }

  List<Plan> getPlans() {
    return [
      Plan(
        name: 'basic_hydration'.tr,
        description: 'basic_hydration_desc'.tr,
        quantity: '2 x 15L',
        price: 300,
        duration: 'per_week'.tr,
      ),
      Plan(
        name: 'family_essentials'.tr,
        description: 'family_essentials_desc'.tr,
        quantity: '2 x 25L',
        price: 450,
        duration: 'per_week'.tr,
        isPopular: true,
      ),
      Plan(
        name: 'large_family'.tr,
        description: 'large_family_desc'.tr,
        quantity: '3 x 25L',
        price: 650,
        duration: 'per_week'.tr,
      ),
      Plan(
        name: 'flexible_hydration'.tr,
        description: 'flexible_hydration_desc'.tr,
        quantity: '4 x (15L or 25L)',
        price: 700,
        duration: 'per_week'.tr,
      ),
    ];
  }

  final selectedPlan = Rx<Plan?>(null);

  void selectPlan(Plan plan) {
    selectedPlan.value = plan;
  }
}
