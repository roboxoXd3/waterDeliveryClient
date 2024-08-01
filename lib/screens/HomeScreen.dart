import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';

import '../controllers/HomePageControllert.dart';
import '../widgets/buildProductCard.dart';
import '../widgets/languageChangeFab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: SvgPicture.asset(
                'assets/logo.svg',
                fit: BoxFit.cover,
                height: 80,
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                      onPressed: () => Get.toNamed(Routes.cartPage),
                    ),
                    controller.cartController.cartItems.isEmpty
                        ? const IgnorePointer()
                        : Positioned(
                            child: Container(
                              height: 16,
                              width: 16,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: Text(
                                '${controller.cartController.cartItems.length}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    controller.loginController.logout();
                  },
                ),
              ],
            ),
            body: Obx(() {
              if (controller.products.isEmpty) {
                return const Center(
                    child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('No products available.'),
                  ],
                ));
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return BuildProductCard(product, controller.cartController);
                  },
                );
              }
            }),
            floatingActionButton:
                LanguageChangeFAB(controller: controller.languageController),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        });
  }
}
