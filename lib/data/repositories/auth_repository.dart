// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../models/user_model.dart' as userModel;
// import '../provider/auth_providers.dart';

// class AuthRepository {
//   final AuthProvider authProvider;
//   final supabase = Supabase.instance.client;

//   AuthRepository(this.authProvider);

//   Future<userModel.User?> registerUser({
//     required String email,
//     required String password,
//     required String fullName,
//     required String phoneNumber,
//   }) async {
//     try {
//       print("AuthRepository: Attempting to register user"); // Debug print
//       final supabaseUser = await authProvider.registerUser(
//         email: email,
//         password: password,
//         fullName: fullName,
//         phoneNumber: phoneNumber,
//       );

//       if (supabaseUser != null) {
//         print(
//             "AuthRepository: User registered, inserting profile"); // Debug print
//         final response = await supabase.from('profiles').insert({
//           'id': supabaseUser.id,
//           'full_name': fullName,
//           'phone_number': phoneNumber,
//           'email': email,
//           'created_at': DateTime.now().toIso8601String(),
//           'updated_at': DateTime.now().toIso8601String(),
//         });

// ignore_for_file: avoid_print

//         if (response.error == null) {
//           print("AuthRepository: Profile inserted successfully"); // Debug print
//           return userModel.User(
//             id: supabaseUser.id,
//             fullName: fullName,
//             phoneNumber: phoneNumber,
//             email: email,
//           );
//         } else {
//           print(
//               "AuthRepository: Failed to insert profile: ${response.error!.message}"); // Debug print
//           throw Exception(
//               'Failed to save profile information: ${response.error!.message}');
//         }
//       } else {
//         print(
//             "AuthRepository: Supabase user is null after registration"); // Debug print
//       }
//     } catch (e) {
//       print("AuthRepository: Error occurred: $e"); // Debug print
//       rethrow;
//     }
//     return null;
//   }
// }
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart' as userModel;
import '../provider/auth_providers.dart';

class AuthRepository {
  final AuthProvider authProvider;
  final SupabaseClient supabase = Supabase.instance.client;

  AuthRepository(this.authProvider);

  // Future<userModel.User?> registerUser({
  //   required String email,
  //   required String password,
  //   required String fullName,
  //   required String phoneNumber,
  // }) async {
  //   try {
  //     print("AuthRepository: Attempting to register user"); // Debug print
  //     final supabaseUser = await _authProvider.registerUser(
  //       email: email,
  //       password: password,
  //       fullName: fullName,
  //       phoneNumber: phoneNumber,
  //     );
  //     if (supabaseUser != null) {
  //       print(
  //           "AuthRepository: User registered, inserting profile"); // Debug print
  //       final response = await supabase.from('profiles').insert({
  //         'id': supabaseUser.id,
  //         'full_name': fullName,
  //         'phone_number': phoneNumber,
  //         'email': email,
  //         'created_at': DateTime.now().toIso8601String(),
  //         'updated_at': DateTime.now().toIso8601String(),
  //       });
  //
  //       if (response.error == null) {
  //         print("AuthRepository: Profile inserted successfully"); // Debug print
  //
  //         return userModel.User(
  //           id: supabaseUser.id,
  //           fullName: fullName,
  //           phoneNumber: phoneNumber,
  //           email: email,
  //         );
  //       } else {
  //         print(
  //             "AuthRepository: Failed to insert profile: ${response.error!.message}"); // Debug print
  //
  //         throw Exception(
  //             'Failed to save profile information: ${response.error!.message}');
  //       }
  //     }
  //   } catch (e) {
  //     // Handle or rethrow the error
  //     rethrow;
  //   }
  //   return null;
  // }

  Future<userModel.User?> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      print("AuthRepository: Attempting to register user");
      final authResponse = await authProvider.registerUser(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      if (authResponse.user != null) {
        print("AuthRepository: User registered, inserting profile");
        try {
          final response = await supabase.from('profiles').insert({
            'id': authResponse.user!.id,
            'full_name': fullName,
            'phone_number': phoneNumber,
            'email': email,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          }).select();

          print("AuthRepository: Profile inserted successfully");
          return userModel.User(
            id: authResponse.user!.id,
            fullName: fullName,
            phoneNumber: phoneNumber,
            email: email,
          );
        } on PostgrestException catch (e) {
          print("AuthRepository: Failed to insert profile: ${e.message}");
          throw Exception('Failed to save profile information: ${e.message}');
        }
      } else {
        print("AuthRepository: Supabase user is null after registration");
        throw Exception(
            'Failed to register user: No user returned from Supabase');
      }
    } on AuthException catch (e) {
      print("AuthRepository: Supabase AuthException: ${e.message}");
      throw Exception('Registration failed: ${e.message}');
    } catch (e) {
      print("AuthRepository: Unexpected error occurred: $e");
      throw Exception('An unexpected error occurred during registration');
    }
  }
}
