import 'package:review_provider_sqlite/app/core/exceptions/auth_exception.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  
  final UserService _userService;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> login({
    required String email,
    required String password,
  }) async {

    try {

      resetStateAndShowLoading();
      notifyListeners();

      final user = await _userService.login(
        email: email,
        password: password,
      );

      if(user != null) {
        success();
      } else {
        setError("User couldn't be found. Please, check the email and password");
      }

    } on AuthException catch(e) {

      setError(e.message);

    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}