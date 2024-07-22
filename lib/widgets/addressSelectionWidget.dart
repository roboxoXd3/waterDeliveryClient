// // address_selection_widget.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/checkoutController.dart';
//
// class AddressSelectionWidget extends GetWidget<CheckoutController> {
//   const AddressSelectionWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'delivery_address'.tr,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: controller.addressTextController,
//                   decoration: InputDecoration(
//                     hintText: 'enter_your_address'.tr,
//                     border: const OutlineInputBorder(),
//                   ),
//                   onChanged: controller.editAddressManually,
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: controller.selectAddressFromMap,
//                         child: Text('select_on_map'.tr),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     // Expanded(
//                     //   child: ElevatedButton(
//                     //     onPressed: () => _showAddressDetailsDialog(context),
//                     //     child: Text('add_details'.tr),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Obx(() => controller.selectedLocation.value != null
//                     ? Text(
//                         'map_location_selected'.tr,
//                         style: const TextStyle(color: Colors.green),
//                       )
//                     : const SizedBox.shrink()),
//               ],
//             ),
//           )),
//     );
//   }
// }
