import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/dto/user_dto.dart';

@lazySingleton
class AuthService {
  final FirebaseAuth _auth;

   AuthService(this._auth);

  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<bool?> get isConnected =>
      _auth.authStateChanges().map((user) => user != null);

  Stream<UserDto?> get authUser => _auth.authStateChanges().map(
    (user) =>
        user != null
            ? UserDto(
              id: user.uid,
              userName: user.displayName ?? user.email ?? "",
              email: user.email ?? "",
            )
            : null,
  );
}
