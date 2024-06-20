import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/exceptions/auth_exception.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  
  final UserService _userService;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;

  String? error;

  bool success = false;

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {

    try {
      error = null;
      success = false;
      notifyListeners();
      
      final user = await _userService.register(
        email: email,
        password: password,
      );
      
      if(user != null) {
      
        success = true;
      
      } else {

        error = "Error to register new user";
      }
    } on AuthException catch (e, s) {
      log("RegisterController: ${e.message}", error: e, stackTrace: s);
      
      error = e.message;

    } finally {
      notifyListeners();
    }
  }
}