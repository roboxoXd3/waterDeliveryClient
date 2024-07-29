import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart' as userModel;
import '../provider/auth_providers.dart';

class AuthRepository {
  final AuthProvider authProvider;
  final supabase = Supabase.instance.client;

  AuthRepository(this.authProvider);


  Future<userModel.User?> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      print("AuthRepository: Attempting to register user"); // Debug print
      final supabaseUser = await authProvider.registerUser(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      if (supabaseUser != null) {
        print(
            "AuthRepository: User registered, inserting profile"); // Debug print
        final response = await supabase.from('profiles').insert({
          'id': supabaseUser.id,
          'full_name': fullName,
          'phone_number': phoneNumber,
          'email': email,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        if (response.error == null) {
          print("AuthRepository: Profile inserted successfully"); // Debug print
          return userModel.User(
            id: supabaseUser.id,
            fullName: fullName,
            phoneNumber: phoneNumber,
            email: email,
          );
        } else {
          print(
              "AuthRepository: Failed to insert profile: ${response.error!.message}"); // Debug print
          throw Exception(
              'Failed to save profile information: ${response.error!.message}');
        }
      } else {
        print(
            "AuthRepository: Supabase user is null after registration"); // Debug print
      }
    } catch (e) {
      print("AuthRepository: Error occurred: $e"); // Debug print
      rethrow;
    }
    return null;
  }
}
