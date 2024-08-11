import 'package:get/get.dart';
import 'package:sheetal_raj_jal/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabaseServices.dart';

class AddressListController extends GetxController {
  final RxList<Map<String, dynamic>> addresses = <Map<String, dynamic>>[].obs;
  bool isLoading = true;
  final SupabaseService _supabaseService = SupabaseService();
  String getLocation = '';
  final Rx<Map<String, dynamic>?> selectedAddress =
      Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

 
  Future<void> fetchAddresses() async {
    try {
      isLoading = true;
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        print('User not authenticated');
        throw Exception('User not authenticated');
      }
      print("Fetching addresses from the database");
      final response = await Supabase.instance.client
          .from('addresses')
          .select()
          .eq('profile_id', user.id);
      addresses.value =
          (response as List<dynamic>).cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error fetching addresses: $e');
      // Get.snackbar('Error', 'Failed to fetch addresses');
    } finally {
      isLoading = false;
    }
    update();
  }

  void navigateToAddAddress() async {
    final result = await Get.toNamed(Routes.addAddresses);
    if (result == true) {
      fetchAddresses();
    }
  }

  void editAddress(String id) {
    Get.toNamed('/edit-address', arguments: id);
  }

  Future<bool> deleteAddress(String id) async {
    try {
      isLoading = true;
      update();

      print('Controller: Attempting to delete address with id: $id');
      final deleted = await _supabaseService.deleteAddress(id);
      if (deleted) {
        print('Controller: Address deleted successfully');
        addresses.removeWhere((address) => address['id'] == id);
        Get.snackbar('Success', 'Address deleted successfully');
        return true;
      } else {
        print('Controller: Failed to delete address');
        throw Exception('Failed to delete address');
      }
    } catch (e) {
      print('Controller: Error deleting address: $e');
      Get.snackbar('Error', 'Failed to delete address: ${e.toString()}');
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }

  void selectAddress(Map<String, dynamic> address) {
    selectedAddress.value = address;
    Get.toNamed(Routes.checkoutPage);
  }

  @override
  void onClose() {
    selectedAddress.value = null;
    super.onClose();
  }
}
