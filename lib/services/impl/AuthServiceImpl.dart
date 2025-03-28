import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talkio/errors/AuthException.dart';
import 'package:talkio/errors/EmailAlreadyInUseException.dart';
import 'package:talkio/errors/InvalidEmailException.dart';
import 'package:talkio/errors/OperationNotAllowedException.dart';
import 'package:talkio/errors/UserDisabledException.dart';
import 'package:talkio/errors/UserLogoutException.dart';
import 'package:talkio/errors/UserNotFoundException.dart';
import 'package:talkio/errors/WeakPasswordException.dart';
import 'package:talkio/errors/WrongPasswordException.dart';
import 'package:talkio/providers/FbAuthProvider.dart';
import 'package:talkio/services/AuthService.dart';

class AuthServiceImpl implements AuthService {
  final FbAuthProvider authProvider;

  AuthServiceImpl({
    required this.authProvider,
  });

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await authProvider.auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else if (error.code == 'invalid-email') {
        throw InvalidEmailException();
      } else if (error.code == 'operation-not-allowed') {
        throw OperationNotAllowedException();
      } else if (error.code == 'weak-password') {
        WeakPasswordException();
      }
      throw AuthException(
        message: error.message ?? 'Firebase Auth Exception',
        code: error.code,
      );
    } catch (error) {
      throw AuthException(
        message: 'AuthException: ${error.toString()}',
        code: 'Unknown Auth Code',
      );
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await authProvider.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-disabled') {
        throw UserDisabledException();
      } else if (error.code == 'invalid-email') {
        throw InvalidEmailException();
      } else if (error.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (error.code == 'wrong-password') {
        WrongPasswordException();
      }
      throw AuthException(
        message: error.message ?? 'Firebase Auth Exception',
        code: error.code,
      );
    } catch (error) {
      throw AuthException(
        message: 'AuthException: ${error.toString()}',
        code: 'Unknown Auth Code',
      );
    }
  }

  @override
  Future<void> passwordRecovery({required String email}) async {
    try {
      await authProvider.auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        throw InvalidEmailException();
      } else if (error.code == 'user-not-found') {
        throw UserNotFoundException();
      }
      throw AuthException(
        message: error.message ?? 'Firebase Auth Exception',
        code: error.code,
      );
    } catch (error) {
      throw AuthException(
        message: 'AuthException: ${error.toString()}',
        code: 'Unknown Auth Code',
      );
    }
  }

  @override
  Future<void> signOut() async => await authProvider.auth.signOut();

  @override
  User get currentUser {
    final user = authProvider.auth.currentUser;
    if (user == null) {
      throw UserLogouException();
    }
    return user;
  }

  @override
  Future<void> loginWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await authProvider.auth.signInWithCredential(credential);
    }
  }

  @override
  Future<void> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    if (loginResult.accessToken != null) {
      final credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );
      await authProvider.auth.signInWithCredential(credential);
    }
  }
}
