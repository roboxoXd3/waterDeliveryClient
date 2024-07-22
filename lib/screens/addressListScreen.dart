import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addressListController.dart';
import '../widgets/addressCardWidget.dart';

class AddressListScreen extends GetView<AddressListController> {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.addresses.isEmpty) {
          return const Center(child: Text('No addresses found'));
        } else {
          return ListView.builder(
            itemCount: controller.addresses.length,
            itemBuilder: (context, index) {
              final address = controller.addresses[index];
              final String? id = address['id'] as String?;

              if (id == null || id.isEmpty) {
                print('Error: Invalid address ID for address: $address');
                return const SizedBox.shrink();
              }

              return Dismissible(
                key: Key(id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteAddress(id);
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you want to delete this address?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("CANCEL"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("DELETE"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: InkWell(
                  onTap: () => controller.selectAddress(address),
                  child: AddressCard(
                    address: address,
                    onEdit: () => controller.editAddress(id),
                    onDelete: () => controller.deleteAddress(id),
                    isSelected: address['is_default'] == true,
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddAddress,
        tooltip: 'Add New Address',
        child: const Icon(Icons.add),
      ),
    );
  }
}
