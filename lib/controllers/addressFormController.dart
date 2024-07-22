import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/locationService.dart';
import '../services/supabaseServices.dart';

class AddressFormController extends GetxController {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final LocationService locationService = LocationService();

  final RxBool isLoading = true.obs;
  final RxList<String> formFields = <String>[].obs;
  final RxMap<String, TextEditingController> fieldControllers =
      <String, TextEditingController>{}.obs;

  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxBool locationPermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeForm();
    requestLocationPermission();
  }

  Future<void> initializeForm() async {
    try {
      final fields = await supabaseService.getAddressFields();
      formFields.value = fields;
      for (var field in fields) {
        fieldControllers[field] = TextEditingController();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to initialize form. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestLocationPermission() async {
    locationPermissionGranted.value =
        await locationService.requestLocationPermission();
    if (locationPermissionGranted.value) {
      await getCurrentLocation();
    } else {
      Get.snackbar('Permission Denied',
          'Location permission is required to use automatic address filling.');
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final position = await locationService.getCurrentLocation();
      if (position != null) {
        currentPosition.value = position;
      }
    } catch (e) {
      Get.snackbar('Error',
          'Failed to get current location. You can still enter address manually.');
    }
  }

  Future<void> useCurrentLocation() async {
    if (currentPosition.value == null) {
      Get.snackbar('Error',
          'Location not available. Please try again or enter address manually.');
      return;
    }

    try {
      isLoading.value = true;
      final address = await locationService.getAddressFromCoordinates(
          currentPosition.value!.latitude, currentPosition.value!.longitude);
      address.forEach((key, value) {
        if (fieldControllers.containsKey(key)) {
          fieldControllers[key]!.text = value;
        }
      });
    } catch (e) {
      Get.snackbar('Error',
          'Failed to populate address fields. Please enter address manually.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitForm() async {
    try {
      isLoading.value = true;

      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        print('Error: User is not authenticated');
        throw Exception('User not authenticated');
      }

      print('Authenticated User ID: ${user.id}');

      final addressData = <String, dynamic>{};
      fieldControllers.forEach((key, controller) {
        addressData[key] = controller.text;
      });

// Include latitude and longitude if available
      if (currentPosition.value != null) {
        addressData['latitude'] = currentPosition.value!.latitude;
        addressData['longitude'] = currentPosition.value!.longitude;
      }

      // Add profile_id (this should match the user's auth.uid())
      addressData['profile_id'] = user.id;

      // Add created_at timestamp
      addressData['created_at'] = DateTime.now().toIso8601String();

      print('Submitting address data: $addressData');

      await supabaseService.saveAddress(addressData);
      Get.back(result: true);
      Get.snackbar('Success', 'Address saved successfully');
    } catch (e) {
      print('Error submitting form: $e');
      Get.snackbar('Error', 'Failed to save address. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fieldControllers.forEach((_, controller) => controller.dispose());
    super.onClose();
  }
}
