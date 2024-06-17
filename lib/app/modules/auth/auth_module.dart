import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/auth/login/login_controller.dart';
import 'package:review_provider_sqlite/app/modules/auth/login/login_page.dart';

class AuthModule extends TodoListModule {
  
  AuthModule() : super(
    routers: {
      "/login": (_) => const LoginPage()
    },
    bindings: [
      ChangeNotifierProvider(create: (_) => LoginController())
    ]
  );
  
}