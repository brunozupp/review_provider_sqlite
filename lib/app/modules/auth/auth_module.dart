import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/auth/login/login_controller.dart';
import 'package:review_provider_sqlite/app/modules/auth/login/login_page.dart';
import 'package:review_provider_sqlite/app/modules/auth/register/register_controller.dart';
import 'package:review_provider_sqlite/app/modules/auth/register/register_page.dart';

final class AuthModule extends TodoListModule {
  
  AuthModule() : super(
    routers: {
      "/login": (_) => const LoginPage(),
      "/register": (_) => const RegisterPage(),
    },
    bindings: [
      ChangeNotifierProvider(create: (_) => LoginController()),
      ChangeNotifierProvider(create: (context) => RegisterController(
        userService: context.read(),
      )),
    ]
  );
  
}