import 'package:review_provider_sqlite/app/core/modules/todo_list_module.dart';
import 'package:review_provider_sqlite/app/modules/home/home_page.dart';

final class HomeModule extends TodoListModule {
  
  HomeModule() : super(
    bindings: [

    ],
    routers: {
      "/home": (context) => const HomePage(),
    },
  );

}