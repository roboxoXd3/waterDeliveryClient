import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/constants/colors.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';

import '../controllers/HomePageControllert.dart';
import '../widgets/languageChangeFab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        init: HomePageController(),
        builder: (controller) {
          return Scaffold(
            // appBar: AppBar(
            // title: SvgPicture.asset(
            //   'assets/logo.svg',
            //   fit: BoxFit.cover,
            //   height: 80,
            // ),
            //   centerTitle: true,
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   actions: [
            //
            //   ],
            // ),

            body: controller.products.isEmpty
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.isLoading
                              ? const CircularProgressIndicator()
                              : const IgnorePointer(),
                          controller.isLoading
                              ? const SizedBox(height: 20)
                              : const IgnorePointer(),
                          Text('No products available.',
                              style: Theme.of(context).textTheme.titleLarge),
                        ]),
                  )
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 0, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/logo.svg',
                                fit: BoxFit.cover,
                                height: 80,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      color: AppColors.primaryColor),
                                  Text(controller.getLocation,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: AppColors.textColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.shopping_cart,
                                            color: Colors.blue),
                                        onPressed: () =>
                                            Get.toNamed(Routes.cartPage),
                                      ),
                                      controller
                                              .cartController.cartItems.isEmpty
                                          ? const IgnorePointer()
                                          : Container(
                                              height: 16,
                                              width: 16,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: Text(
                                                '${controller.cartController.cartItems.length}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                    ],
                                  ),
                                  GestureDetector(
                                    child: const Icon(
                                      Icons.logout,
                                      color: Colors.blue,
                                    ),
                                    onTap: () {
                                      controller.loginController.logout();
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                  controller.currentGreeting == "morn"
                                      ? "morning".tr
                                      : controller.currentGreeting == "after"
                                          ? "afternoon".tr
                                          : controller.currentGreeting == "even"
                                              ? "evening".tr
                                              : "night".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppColors.textColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                              const SizedBox(width: 3),
                              Text("Tushar",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 10),
                           Center(
                             child: CachedNetworkImage(
                                      imageUrl: controller.products[controller.productIndex].imageUrl,
                                      fit: BoxFit.cover,
                                      height: 300,
                                      placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                           )
                              
                          ,
                          const SizedBox(height: 20),
                          Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              itemCount: controller.products.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                
                                return Row(
                                  children: [
                                    SizedBox(width: 10),
                                    MaterialButton(
                                  onPressed: () {
                                controller.productIndex = index;
                                 controller.update();
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: AppColors.primaryColor,
                                  child: Text(controller.products[index].nameKey,style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 16)),
                                )
                                  ],
                                );
                              },
                            ),
                          ),
                                const SizedBox(height: 20),

                          Center(
                            child: Column(
                              children: [
                                Text(
                                    "₹${controller.products[controller.productIndex].price}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.textColor,
                                            fontSize: 16)),
                                const SizedBox(height: 6),
                               Text(
                                    controller.products[controller.productIndex].nameKey,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.textColor,
                                            fontSize: 16)),
                                const SizedBox(height: 4),

                                Text(
                                    controller.products[controller.productIndex]
                                        .description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                            onPressed: () {
                              controller.cartController.addToCart(
                                  controller.products[controller.productIndex]);
                              Get.snackbar(
                                'Added to Cart',
                                'has been added to your cart',
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                            },
                            minWidth: double.infinity,
                            height: 45,
                            color: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Buy Now",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
            floatingActionButton:
                LanguageChangeFAB(controller: controller.languageController),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        });
  }
}
