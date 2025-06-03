
import 'package:les_petite_creations_d_alexia/data/repository/user_repository.dart';

class AccountInteractor {
  final UserRepository userRepository;
  final String userId;

  AccountInteractor(this.userRepository, this.userId);

  Future<Map<String, dynamic>> invoke(String userId)async {
    return await userRepository.fetchUserData(userId);
  }

  Future<Map<String, dynamic>> fetchUserData(userId) async {
    return await userRepository.fetchUserData(userId);
  }
}