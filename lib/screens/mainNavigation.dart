// screens/main_navigation.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/HomePageControllert.dart';
import '../widgets/customBottomNavBar.dart';
// import '../controllers/home_page_controller.dart';
// import '../widgets/custom_bottom_nav_bar.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) {
        return Scaffold(
          body: Obx(() => controller.currentPage),
          bottomNavigationBar: Obx(
            () => CustomBottomNavBar(
              selectedIndex: controller.selectedIndex,
              onItemTapped: controller.changeIndex,
            ),
          ),
        );
      }
    );
  }
}
