import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/addressFormController.dart';

class AddressFormScreen extends GetView<AddressFormController> {
  const AddressFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLocationButton(),
                    const SizedBox(height: 16),
                    ...controller.formFields.map((field) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextFormField(
                            controller: controller.fieldControllers[field],
                            decoration: InputDecoration(
                              labelText: field.capitalize,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: controller.submitForm,
                      child: const Text('Save Address'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildLocationButton() {
    return Obx(() {
      if (controller.locationPermissionGranted.value) {
        return ElevatedButton.icon(
          icon: const Icon(Icons.my_location),
          label: const Text('Use Current Location'),
          onPressed: controller.useCurrentLocation,
        );
      } else {
        return ElevatedButton.icon(
          icon: const Icon(Icons.location_off),
          label: const Text('Enable Location Services'),
          onPressed: controller.requestLocationPermission,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
        );
      }
    });
  }
}
