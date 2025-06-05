import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/repository/user_repository.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/users.dart';


@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRepositoryImpl(this._auth, this._firestore);

  @override
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await _firestore.collection('Users').doc(currentUser.uid).get();
        if (snapshot.exists) {
          debugPrint("🆔 UID utilisateur connecté : ${FirebaseAuth.instance.currentUser?.uid}");

          return snapshot.data() as Map<String, dynamic>;

        } else {
          throw Exception('Aucune donnée utilisateur trouvée.');
        }
      } else {
        throw Exception('Aucun utilisatuer connecé.');
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération des données utilisateur : $e');
      rethrow;
    }
  }

  @override
  Future<void> registerUser(Users user) async {
    try {
      // 1. Création du compte Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      debugPrint("✅ Compte Auth créé avec UID: ${result.user?.uid}");

      // 2. Création du document Firestore
      await _firestore.collection('Users').doc(result.user!.uid).set({
        'email': user.email,
        'userName': user.userName,
        'createdAt': FieldValue.serverTimestamp(), // Ajout d'un timestamp
        'uid': result.user!.uid, // Stockage de l'UID dans le document
      });

      debugPrint("✅ Document utilisateur créé dans Firestore");

    } on FirebaseAuthException catch (e) {
      debugPrint("Erreur Auth: ${e.code} - ${e.message}");
      throw Exception("Erreur d'inscription: ${e.message}");
    } on FirebaseException catch (e) {
      debugPrint("Erreur Firestore: ${e.code} - ${e.message}");
      throw Exception("Erreur de création de profil: ${e.message}");
    } catch (e) {
      debugPrint("Erreur inattendue: $e");
      throw Exception("Erreur inattendue: $e");
    }
  }

  @override
  Future<bool> checkAuthenticationStatus() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        debugPrint("L'utilisateur est connecté.");
        return true;
      } else {
        debugPrint("L'utilisateur n'est pas connecté");
        return false;
      }
    } catch (e) {
      debugPrint(
        'Erreur lors de la vérification du statut d\'authentification : $e',
      );
      rethrow;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception(
        "Veullez fournir une adresse email et un mot de passe valides.",
      );
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      debugPrint("Erreur d'authentification : $e");
      throw Exception("Echec de l'authentification : $e");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
      debugPrint("Déconnexion réussie");
    } catch (e) {
      debugPrint("Erreur lors de la déconnexion : $e");
      throw Exception("Echec de la déconnexion : $e");
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      debugPrint("Erreur de Réinitialisation du mot de passe : $e");
      throw Exception("Echec de la réinitialisation du mot de passe : $e");
    }
  }

  FirebaseFirestore get firestore =>  throw UnimplementedError();
}
