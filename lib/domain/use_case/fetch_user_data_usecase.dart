import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/repository/user_repository_impl.dart';

@injectable

class FetchUserDataUseCase {
  final UserRepositoryImpl _userRepositoryImpl;
  final String userId;

  FetchUserDataUseCase(this._userRepositoryImpl, this.userId);

  Future<Map<String, dynamic>> invoke()async {
    try {
      return await _userRepositoryImpl.fetchUserData(userId);
    }catch(e) {
      debugPrint("Erreur lors de la récupérationb des données utilisateur : $e");
      rethrow;
    }
  }
  Future<void> checkAuthenticationStatus() async {
    await _userRepositoryImpl.checkAuthenticationStatus();
  }

}