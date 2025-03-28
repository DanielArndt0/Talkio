import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  User get currentUser;

  Future<void> register({
    required String email,
    required String password,
  });

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> passwordRecovery({
    required String email,
  });

  Future<void> signOut();

  Future<void> loginWithGoogle();

  Future<void> loginWithFacebook();
}
