import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/constants/colors.dart';
import '../controllers/addressListController.dart';
import '../widgets/addressCardWidget.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListController>(
        init: AddressListController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Addresse'),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.addresses.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          controller.navigateToAddAddress();
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "+ Add New address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            itemCount: controller.addresses.length,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final address = controller.addresses[index];
                              final String? id = address['id'] as String?;

                              if (id == null || id.isEmpty) {
                                print(
                                    'Error: Invalid address ID for address: $address');
                                return const SizedBox.shrink();
                              }

                              return InkWell(
                                onTap: () =>
                                    controller.selectAddress(address),
                                child: AddressCard(
                                  address: address,
                                  onEdit: () => controller.editAddress(id),
                                  onDelete: () =>
                                      controller.deleteAddress(id),
                                  isSelected: address['is_default'] == true,
                                ),
                              );
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.navigateToAddAddress();
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Add another address",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
          );
        });
  }
}
