import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends GetxService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<String>> getAddressFields() async {
    try {
      final response = await _supabaseClient.rpc('get_address_fields').select();

      final List<String> fields = (response as List)
          .map((field) => field['column_name'] as String)
          .where((field) =>
              field != 'id' && field != 'latitude' && field != 'longitude')
          .toList();

      return fields;
    } catch (e) {
      print('Error fetching address fields: $e');
      rethrow;
    }
  }

  Future<void> saveAddress(Map<String, dynamic> addressData) async {
    try {
      await _supabaseClient.from('addresses').insert(addressData);

      print('Address saved successfully');
    } catch (e) {
      print('Error saving address: $e');
      rethrow;
    }
  }

  Future<bool> deleteAddress(String id) async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        print('Error: User not authenticated');
        throw Exception('User not authenticated');
      }

      print('Attempting to delete address with id: $id for user: ${user.id}');

      final response = await _supabaseClient
          .from('addresses')
          .delete()
          .match({'id': id, 'profile_id': user.id});

      print('Delete response: $response');

      // If we reach here without an exception, assume success
      print('Address deleted successfully');
      return true;
    } catch (e) {
      print('Error deleting address: $e');
      return false;
    }
  }
}
