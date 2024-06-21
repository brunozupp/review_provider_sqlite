import 'dart:developer';

import 'package:review_provider_sqlite/app/core/exceptions/auth_exception.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';

class RegisterController extends DefaultChangeNotifier {
  
  final UserService _userService;

  RegisterController({
    required UserService userService,
  }) : _userService = userService;
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {

    try {

      resetStateAndShowLoading();
      notifyListeners();
      
      final user = await _userService.register(
        email: email,
        password: password,
      );
      
      if(user != null) {
      
        success();
      
      } else {

        setError("Error to register new user");
      }
    } on AuthException catch (e, s) {
      log("RegisterController: ${e.message}", error: e, stackTrace: s);
      
      setError(e.message);

    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}