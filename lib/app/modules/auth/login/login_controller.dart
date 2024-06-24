import 'package:review_provider_sqlite/app/core/exceptions/auth_exception.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  
  final UserService _userService;

  LoginController({
    required UserService userService,
  }) : _userService = userService;

  String? infoMessage;
  bool get hasInfo => infoMessage != null;

  Future<void> login({
    required String email,
    required String password,
  }) async {

    try {

      resetStateAndShowLoading();
      infoMessage = null;
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

  Future<void> forgotPassword({
    required String email,
  }) async {

    try {
      resetStateAndShowLoading();
      infoMessage = null;
      notifyListeners();

      await _userService.forgotPassword(email: email);

      infoMessage = "Recovery email was sent. Please, check your email.";

    } on AuthException catch(e) {

      setError(e.message);

    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {

    try {

      resetStateAndShowLoading();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

      if(user != null) {
        success();
      } else {
        await _userService.logout();
        setError("Error to login with google");
      }
      
    } on AuthException catch(e) {

      await _userService.logout();
      setError(e.message);
      
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}