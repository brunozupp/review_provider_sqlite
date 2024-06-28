import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';
import 'package:review_provider_sqlite/app/modules/home/home_page.dart';

final class HomeModule extends TodoListModule {
  
  HomeModule() : super(
    bindings: [
      ChangeNotifierProvider(
        create: (context) => HomeController(),
      ),
    ],
    routers: {
      "/home": (context) => const HomePage(),
    },
  );

}