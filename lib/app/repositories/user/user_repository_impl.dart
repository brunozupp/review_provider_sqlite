import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:review_provider_sqlite/app/core/exceptions/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential.user;
    } on FirebaseAuthException catch (e,s) {
      log("Error during register new user", stackTrace: s, error: e);

      switch(e.code) {
        case "email-already-in-use":
          throw AuthException(message: "Email is already in use");
        case "invalid-email":
          throw AuthException(message: "Email is not valid");
        case "operation-not-allowed":
          throw AuthException(message: "Operation is not allowed. Please, submit a ticket for support");
        case "weak-password":
          throw AuthException(message: "Password is too weak");
        default:
          throw AuthException(message: "Error to register user");
      }

    }
  }

}