import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/repository/user_repository.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/users.dart';

@singleton
class AddUserInteractor {
  final UserRepository userRepository;

  AddUserInteractor({required this.userRepository});

  Future<void> registerUser(Users user) async {
    try {
      await userRepository.registerUser(Users(
          id: user.id,
          userName: user.userName,
          email: user.email,
          password: user.password));
    }catch(e){
      debugPrint ("Erreur lors de l'enregistrement de l'utilisateur : $e");
    }
  }
}