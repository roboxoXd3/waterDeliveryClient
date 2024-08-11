import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/locationService.dart';
import '../services/supabaseServices.dart';

class AddressFormController extends GetxController {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final LocationService locationService = LocationService();
  bool hasPermission = false;
  bool isLoading = true;
  final RxList<String> formFields = <String>[].obs;
  final RxMap<String, TextEditingController> fieldControllers =
      <String, TextEditingController>{}.obs;
  Placemark? firstAddress;
  Position? position;
  User? user;
  @override
  void onInit() {
    super.onInit();

    user = Supabase.instance.client.auth.currentUser;

    initializeForm();
    handleLocationPermission();
  }

  Future<void> getCurrentLocPosition() async {
    hasPermission = await handleLocationPermission();

    if (!hasPermission) {
      EasyLoading.dismiss();

      return;
    }
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null) {
        List<Placemark> addresses = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);
        firstAddress = addresses.first;

        final street =
            "${firstAddress!.name ?? ""}, ${firstAddress!.subLocality ?? ""}";
        final city = firstAddress!.subLocality ?? "";
        final state = firstAddress!.locality ?? "";
        final postalCode = firstAddress!.postalCode ?? "";
        final country = firstAddress!.country ?? "";

        // Update controllers
        fieldControllers['street']?.text = street;
        fieldControllers['city']?.text = city;
        fieldControllers['state']?.text = state;
        fieldControllers['postal_code']?.text = postalCode;
        fieldControllers['country']?.text = country;
        if (user != null) {
          if (user!.userMetadata != null) {
            fieldControllers['nickname']?.text =
                user!.userMetadata!['full_name'];
          }
        }
      }

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();

      print(e.toString());
    }
    update();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    } else {
      hasPermission = true;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
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
      isLoading = false;
    }
    update();
  }

  Future<void> submitForm() async {
    try {
      isLoading = true;
      update();
      if (user == null) {
        print('Error: User is not authenticated');
        throw Exception('User not authenticated');
      }

      print('Authenticated User ID: ${user!.id}');

      final addressData = <String, dynamic>{};
      fieldControllers.forEach((key, controller) {
        addressData[key] = controller.text;
      });

      if (position != null) {
        addressData['latitude'] = position!.latitude;
        addressData['longitude'] = position!.longitude;
      }

      addressData['profile_id'] = user!.id;

      addressData['created_at'] = DateTime.now().toIso8601String();

      print('Submitting address data: $addressData');

      await supabaseService.saveAddress(addressData);
      Get.back(result: true);
      Get.snackbar('Success', 'Address saved successfully');
    } catch (e) {
      print('Error submitting form: $e');
      Get.snackbar('Error', 'Failed to save address. Please try again.');
    } finally {
      isLoading = false;
    }
    update();
  }

  @override
  void onClose() {
    fieldControllers.forEach((_, controller) => controller.dispose());
    super.onClose();
  }
}
