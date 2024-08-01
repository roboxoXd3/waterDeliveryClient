import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

//   Future<User?> registerUser({
//     required String email,
//     required String password,
//     required String fullName,
//     required String phoneNumber,
//   }) async {
//     final response = await _supabaseClient.auth.signUp(
//       email: email,
//       password: password,
//       data: {
//         'full_name': fullName,
//         'phone_number': phoneNumber,
//       },
//     );
//     return response.user;
//   }
// }
// New----------------code
  Future<AuthResponse> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
        },
      );
      return response;
    } on AuthException catch (e) {
      // Handle Supabase auth-specific errors
      print('AuthProvider: Supabase AuthException: ${e.message}');
      throw Exception('Registration failed: ${e.message}');
    } catch (e) {
      // Handle other errors
      print('AuthProvider: Unexpected error: $e');
      throw Exception('An unexpected error occurred during registration');
    }
  }
}
// End----------------code