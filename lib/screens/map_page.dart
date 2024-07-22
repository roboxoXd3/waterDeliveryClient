// // map_page.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../controllers/checkoutController.dart';
// import '../controllers/map_controller.dart';

// class MapPage extends GetView<MapController> {
//   MapPage({super.key});
//   final CheckoutController checkoutController = Get.find<CheckoutController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Address on Map'),
//       ),
//       body: Stack(
//         children: [
//           Obx(() => GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: controller.selectedLocation.value,
//                   zoom: 15,
//                 ),
//                 onMapCreated: (GoogleMapController mapController) {
//                   controller.mapController.value = mapController;
//                 },
//                 onTap: controller.updateSelectedLocation,
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId('selected_location'),
//                     position: controller.selectedLocation.value,
//                   ),
//                 },
//               )),
//           Positioned(
//             top: 16,
//             right: 16,
//             child: FloatingActionButton(
//               onPressed: controller.getCurrentLocation,
//               child: const Icon(Icons.my_location),
//             ),
//           ),
//           Positioned(
//             top: 100,
//             right: 16,
//             child: FloatingActionButton(
//               onPressed: () => _showAddressDetailsDialog(context),
//               child: const Icon(Icons.add_location_alt_rounded),
//             ),
//           ),
//           Positioned(
//             bottom: 16,
//             left: 16,
//             right: 16,
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   color: Colors.white,
//                   child: Obx(() => controller.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : Text(controller.selectedAddress.value)),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: controller.confirmLocation,
//                   child: const Text('Confirm Location'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddressDetailsDialog(BuildContext context) {
//     final TextEditingController detailsController = TextEditingController();
//     final TextEditingController cityController = TextEditingController();
//     final TextEditingController stateController = TextEditingController();
//     final TextEditingController zipController = TextEditingController();
//     final TextEditingController countryController = TextEditingController();
//     final TextEditingController streetController = TextEditingController();

//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Enter Address Details',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: streetController,
//                   decoration: const InputDecoration(
//                     labelText: 'Street',
//                     hintText: 'Enter street',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: cityController,
//                   decoration: const InputDecoration(
//                     labelText: 'City',
//                     hintText: 'Enter city',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: stateController,
//                   decoration: const InputDecoration(
//                     labelText: 'State',
//                     hintText: 'Enter state',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: zipController,
//                   decoration: const InputDecoration(
//                     labelText: 'ZIP',
//                     hintText: 'Enter ZIP',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: countryController,
//                   decoration: const InputDecoration(
//                     labelText: 'Country',
//                     hintText: 'Enter country',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     String currentAddress =
//                         checkoutController.addressTextController.text;
//                     String additionalDetails = detailsController.text;
//                     String city = cityController.text;
//                     String state = stateController.text;
//                     String zip = zipController.text;
//                     String country = countryController.text;
//                     String phone = streetController.text;

//                     String newAddress =
//                         '$currentAddress\n$additionalDetails\n$city, $state $zip\n$country\n$phone';
//                     checkoutController.editAddressManually(newAddress);
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Save'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
