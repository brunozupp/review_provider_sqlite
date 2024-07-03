import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/navigator/todo_list_navigator.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';

class AuthController extends ChangeNotifier {
  
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthController({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  Future<void> logout() => _userService.logout();

  User? get user => _firebaseAuth.currentUser;

  void loadListener() {

    // calling notifyListeners quando ANY change occur inside user to
    // update the status of currentUser
    _firebaseAuth.userChanges().listen((_) => notifyListeners());

    // It listens the changes in login and logout
    // So, because I am using authStateChanges, when I register/create a new
    // user and succeed, it will fire the listening and go to the home.
    _firebaseAuth.authStateChanges().listen((user) {

      if(user != null) { // Login
        TodoListNavigator.to.pushNamedAndRemoveUntil("/home", (route) => false);

        FirebaseCrashlytics.instance.setCustomKey('USER_UID', user.uid);

      } else { // Logout
        TodoListNavigator.to.pushNamedAndRemoveUntil("/login", (route) => false);

        FirebaseCrashlytics.instance.setCustomKey("USER_UID", "");

      }
    });
  }
}