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
          throw AuthException(message: "Operation is not allowed. Please, contact the support for more information!");
        case "weak-password":
          throw AuthException(message: "Password is too weak");
        default:
          throw AuthException(message: "Error to register user");
      }
    } catch(e, s) {
      log("Unknown Error: Error during register new user", stackTrace: s, error: e);

      throw AuthException(message: "Error to register user");
    }
  }
  
  @override
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    
    try {
      
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;

    } on FirebaseAuthException catch (e, s) {
      log("Error to login with email and password", stackTrace: s, error: e);

      switch(e.code) {
        case "invalid-email":
        case "wrong-password":
          throw AuthException(message: "Email and/or password is/are invalid");
        case "user-disabled":
          throw AuthException(message: "User are disabled. Please, contact the support for more information!");
        case "user-not-found":
          throw AuthException(message: "User not found");
        default:
          throw AuthException(message: "Error to login");
      }
    } catch(e, s) {
      log("Unknown Error: Error to login with email and password", stackTrace: s, error: e);

      throw AuthException(message: "Error to login");
    }
  }
  
  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    
    try {
      
      await _firebaseAuth.sendPasswordResetEmail(email: email);

    } on FirebaseAuthException catch (e, s) {
      log("Error to send recovery email", stackTrace: s, error: e);

      switch(e.code) {
        case "auth/invalid-email":
          throw AuthException(message: "Email is invalid");
        case "auth/user-not-found":
          throw AuthException(message: "User not found");
        default:
          throw AuthException(message: "Error to send recovery email");
      }
    } catch(e, s) {
      log("Unknown Error: Error to send recovery email", stackTrace: s, error: e);

      throw AuthException(message: "Error to send recovery email");
    }
  }

}