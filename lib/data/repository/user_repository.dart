

import 'package:firebase_auth/firebase_auth.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/users.dart';

abstract class UserRepository {
  Future<Map<String, dynamic>> fetchUserData(String userId);
  Future<void> registerUser(Users user);
  Future<User?> login(String email, String password);
  Future<void> resetPassword(String email);
  Future<bool> checkAuthenticationStatus();
  Future<void> logout();
}