import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sheetal_raj_jal/constants/app_text_styles.dart';
import 'package:sheetal_raj_jal/constants/colors.dart';
import '../controllers/addressFormController.dart';

class AddressFormScreen extends StatelessWidget {
  const AddressFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressFormController>(
        init: AddressFormController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Address'),
              centerTitle: true,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        controller.hasPermission
                            ? GestureDetector(
                                onTap: () {
                                  EasyLoading.show(dismissOnTap: true);

                                  controller.getCurrentLocPosition();
                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.my_location,
                                          color: Colors.white),
                                      SizedBox(width: 10),
                                      Text('Use Current Location',
                                          style: AppTextStyles.white16TextStyle)
                                    ],
                                  ),
                                ),
                              )
                            : ElevatedButton.icon(
                                icon: const Icon(Icons.location_off),
                                label: const Text('Enable Location Services'),
                                onPressed: () async {
                                  controller.hasPermission = await controller
                                      .handleLocationPermission();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                              ),
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
                        MaterialButton(
                          onPressed: controller.submitForm,
                          minWidth: double.infinity,
                          height: 50,
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: const Text('Save Address',
                              style: AppTextStyles.white18TextStyle),
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
