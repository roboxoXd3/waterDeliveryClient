

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapController extends GetxController {
  final Rx<LatLng> selectedLocation = const LatLng(25.9864, 84.8155).obs; // Default to Mairwa, Siwan, Bihar
  final RxString selectedAddress = ''.obs;
  final RxBool isLoading = false.obs;
  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await getCurrentLocation();
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied, we cannot request permissions.';
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

  void updateSelectedLocation(LatLng location) {
    selectedLocation.value = location;
    getAddressFromLatLng(location);
  }

  Future<void> getAddressFromLatLng(LatLng location) async {
    isLoading.value = true;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        selectedAddress.value = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      }
    } catch (e) {
      print('Error: $e');
      selectedAddress.value = 'Error fetching address';
    } finally {
      isLoading.value = false;
    }
  }

  // void confirmLocation() {
  //   Get.back(result: {
  //     'location': selectedLocation.value,
  //     'address': selectedAddress.value,
  //   });
  // }
   void confirmLocation() {
    Get.back(result: {
      'location': selectedLocation.value,
      'address': selectedAddress.value,
    });
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      Position? position = await _determinePosition();
      if (position != null) {
        LatLng currentLocation = LatLng(position.latitude, position.longitude);
        updateSelectedLocation(currentLocation);
        mapController.value?.animateCamera(CameraUpdate.newLatLng(currentLocation));
      } else {
        throw 'Unable to get current location';
      }
    } catch (e) {
      print('Error getting current location: $e');
      Get.snackbar('Error', 'Failed to get current location. Using default.');
    } finally {
      isLoading.value = false;
    }
  }
}